From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH] [kernel] completion: silence "fatal: Not a git
 repository" error
Date: Tue, 14 Oct 2014 09:58:08 -0400
Message-ID: <CAEBDL5Uh-LE36EmQ9hzzHKv4+=hjmj5S2z54wMmrpCWZyg9ziw@mail.gmail.com>
References: <1413283785-505-1-git-send-email-john@szakmeister.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 14 15:58:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xe2cC-0005bL-No
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 15:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbaJNN6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 09:58:12 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:39236 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932327AbaJNN6L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 09:58:11 -0400
Received: by mail-la0-f54.google.com with SMTP id gm9so8602109lab.27
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 06:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:content-type;
        bh=fzQfiO46zeWoegf0iyK3q8Jrg8IY7sXXjzx0LFMZlsU=;
        b=Gx+5f87fUMWjw0G0R5U0E4jOCHUiCY67jtuyHrAr5oLjrRfea3usuHkHqPhy9G/sDo
         eT+dF8nNIHOTFRVRc8qy3RLnwa+UyJYJ8eb1K8qXq0vY+QPzgHdaCifdMHgOfjzTUARn
         YXGovcFNNBBU8TyqWNgkykaX9ZWLJOFZTO9cXq7ZZl11S9WIxIYtdroBSipFhx4+Jy5H
         IS/bk6MpguHkYScDCAZeM/Ag2sm08xiFtTQEcS8wwkuIjz/XzIMfKuKyg60i/3oJjD1e
         /2fc7jtYIWkUtqxHjqjGBsq/Ae/e282QLCazX3Gt3ZJbA3k3Gk06vhVvPTXKQ+oqMAia
         oTig==
X-Received: by 10.152.216.167 with SMTP id or7mr3206202lac.93.1413295088970;
 Tue, 14 Oct 2014 06:58:08 -0700 (PDT)
Received: by 10.25.138.132 with HTTP; Tue, 14 Oct 2014 06:58:08 -0700 (PDT)
In-Reply-To: <1413283785-505-1-git-send-email-john@szakmeister.net>
X-Google-Sender-Auth: Pnn1vzEFT1d1RpNuNzruQf6hYqU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 14, 2014 at 6:49 AM, John Szakmeister <john@szakmeister.net> wrote:
> It is possible that a user is trying to run a git command and fail to realize
> that they are not in a git repository or working tree.  When trying to complete
> an operation, __git_refs would fall to a degenerate case and attempt to use
> "git for-each-ref", which would emit the error.
>
> Let's fix this by shunting the error message coming from "git for-each-ref".
>
> Signed-off-by: John Szakmeister <john@szakmeister.net>
> ---

Sorry for the "[kernel]" in the subject.  I must have forgotten to
remove that off of my format-patch invocation.  If you need me to
resubmit without it, I can do that.

Thanks!

-John
