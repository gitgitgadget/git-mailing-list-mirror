From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 1/2] worktrees: add find_shared_symref
Date: Mon, 10 Aug 2015 18:30:31 -0400
Message-ID: <CAPig+cTBLx2Q0n2ZcA-QgwNQMHZm9G45ThHbGc+Orkz-6c5cUg@mail.gmail.com>
References: <1439229165-25773-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 00:32:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOvc6-0002p0-CF
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 00:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933387AbbHJWcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 18:32:08 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:34795 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933430AbbHJWac (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 18:30:32 -0400
Received: by ykdt205 with SMTP id t205so71878416ykd.1
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 15:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=SgJmEZye5hiqVt5HcOm8js3UKXYlmT5j5bOkmwSoafo=;
        b=iy5/nr4RCEtg9jxzVuRNt9T8eNLm7gI33L1EknJtpkyOwcxCuoqgcM4r2Wq7X1j5eX
         S5tcbbYuoED12oeteti/sRvefk3oSPNNnmuXfFUh/e5LXScT6qbpeqY9uvteQ6mX9r85
         /3F1bu3k+IxphCnTR5Vswejq4zoz8lOr+SuJSEx/Q6QuVFZ3ZioblDdWXJ4+NXJC+fEk
         ex6pHd5+M8XH47sin0SP7l2vnKfD1T3G4weUdx4J8E+9KUPVE1il5c16tPiU1rR2jepZ
         7MOmFPI3hv/KaWfRgAN0D/lHaF1bVJGjbXM/yV5whUVDl8dLH/F09QsYUKRX7a+XF3YB
         jRUQ==
X-Received: by 10.170.55.70 with SMTP id 67mr7514361ykx.82.1439245831862; Mon,
 10 Aug 2015 15:30:31 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Mon, 10 Aug 2015 15:30:31 -0700 (PDT)
In-Reply-To: <1439229165-25773-1-git-send-email-dturner@twopensource.com>
X-Google-Sender-Auth: CpGwmBS0aP7WVynpin1F55hyFHw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275657>

On Mon, Aug 10, 2015 at 1:52 PM, David Turner <dturner@twopensource.com> wrote:
> worktrees: add find_shared_symref

s/worktrees/branch/ perhaps?

> Add a new function, find_shared_symref, which contains the heart of
> die_if_checked_out, but works for any symref, not just HEAD.  Refactor
> die_if_checked_out to use the same infrastructure as
> find_shared_symref.
>
> Soon, we will use find_shared_symref to protect notes merges in
> worktrees.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
> This version addresses Eric Sunshine's comments on v5.  It fixes an error
> message and cleans up the code.

All issues identified in previous versions seem to have been
addressed, and nothing else pops out at me. Thanks.
