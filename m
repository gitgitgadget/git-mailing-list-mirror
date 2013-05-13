From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 7/7] rebase: implement --[no-]autostash and rebase.autostash
Date: Mon, 13 May 2013 13:33:50 +0530
Message-ID: <CALkWK0nP=RmJHjcFUG2u4pz1ORtPhR7bzi3VvTE=7ggnKbjaQA@mail.gmail.com>
References: <1368359801-28121-1-git-send-email-artagnon@gmail.com>
 <1368359801-28121-8-git-send-email-artagnon@gmail.com> <7vd2svqtqd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 13 10:04:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbnkS-0001dc-PV
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 10:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584Ab3EMIEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 04:04:32 -0400
Received: from mail-bk0-f51.google.com ([209.85.214.51]:49731 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120Ab3EMIEb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 04:04:31 -0400
Received: by mail-bk0-f51.google.com with SMTP id ji2so2267418bkc.24
        for <git@vger.kernel.org>; Mon, 13 May 2013 01:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=U8nNWEKXcuo/3Bz7E4kyy2c7KA7r7H3wF4O4xq6aTss=;
        b=HBg50Yls25uVsSNYlCLRoLQWXht8gEJjF1WoXr7C2reCYg7q4ApEVPZTbKGBFZ3U3t
         DkzBdReF+OqGdf4aCmxkQ0yspLKkSVBdNfBHjsc2yOKNQDOQzBrXgCBW6r0QjKbGjT/g
         nJApbPpjpXQ5IAZGsitUD0JOwnapxQyJeVBDXq2/sO8ZVzGdADG/VLm+bsM5x65EE5M8
         UxYcYIZw5AdI1dyXJg/DOcDw2L48LvjK8C64YxSKmZHQJiFA67slfIlQhMpNGzv+5MT2
         9AomPbYjXVT/jMS3CjZbHkE1VlvitxweZViQeqvdvFj92Fb5i4tqiJ8UjgJlSMf5OV7I
         C0Pw==
X-Received: by 10.204.57.142 with SMTP id c14mr5219733bkh.7.1368432270239;
 Mon, 13 May 2013 01:04:30 -0700 (PDT)
Received: by 10.204.172.209 with HTTP; Mon, 13 May 2013 01:03:50 -0700 (PDT)
In-Reply-To: <7vd2svqtqd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224107>

Junio C Hamano wrote:
> Writing it like this:
> [...]
> with a blank line before the next "echo", it would be more readable.

> This feels funny.  Why not
> [...]
> without an extra command substitution with an echo?

I'll re-roll if there are more comments.  Otherwise, can you fix these
up locally?  Thanks.

>                         git stash store -m "autostash" $stash_sha1 || exit

Definitely nicer.  I'll write follow-ups for pull and stash.
