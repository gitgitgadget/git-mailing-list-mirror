From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 3/5] bisect: introduce --no-checkout[=<ref>] support into porcelain.
Date: Sun, 31 Jul 2011 03:00:22 +1000
Message-ID: <CAH3AnrqaruBM8djz6Hfs0Rj5nqHBv6kU+yWNV5QYtaHrOKhRew@mail.gmail.com>
References: <1312014511-7157-1-git-send-email-jon.seymour@gmail.com>
	<1312014511-7157-4-git-send-email-jon.seymour@gmail.com>
	<201107301634.33710.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, j6t@kdbg.org, gitster@pobox.com,
	jnareb@gmail.com
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Jul 30 19:00:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnCto-0006ra-Cr
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 19:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164Ab1G3RAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 13:00:24 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:57283 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134Ab1G3RAX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 13:00:23 -0400
Received: by vxh35 with SMTP id 35so3335231vxh.19
        for <git@vger.kernel.org>; Sat, 30 Jul 2011 10:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dElr5Hhm+IE4zM1NPEe1APMkqIyNRDafhtKegAmoYOk=;
        b=BitXvicSEneElcT3LTt0/cgYWRR1RjWXa+GhY9t6FEUm12VCCdNpHnv7YIl4lK5z2K
         r4A1Dlw9dcrj+F0UQ05xr4AeICKqgdR29HCu11/hiXi9Sdk+ycf4ErhFJDitpHmHC+sc
         HgxG6TWwilChVp6QNTtgO7keGJZ0X+zie1kDU=
Received: by 10.52.97.234 with SMTP id ed10mr2489722vdb.240.1312045222189;
 Sat, 30 Jul 2011 10:00:22 -0700 (PDT)
Received: by 10.52.183.41 with HTTP; Sat, 30 Jul 2011 10:00:22 -0700 (PDT)
In-Reply-To: <201107301634.33710.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178213>

On Sun, Jul 31, 2011 at 12:34 AM, Christian Couder
<chriscool@tuxfamily.org> wrote:
>
> Is there a reason you use "${GIT_DIR}" instead of "$GIT_DIR" that is used
> everywhere else?
>

No, there is no good reason.

I've pushed a revision that addresses your comments to github  -
https://github.com/jonseymour/git/commits/no-checkout-v2
(git@github.com:jonseymour/git.git)

I'll post the revised series to the list once Junio and others have
had a chance to comment.

jon.
