From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [Patch] Use a default for a bad env config file variable
Date: Tue, 10 Aug 2010 16:02:48 +0000
Message-ID: <AANLkTikDtK0vyRwJE3Un5uFkK7FzoWtiWpL8gPqLQjH5@mail.gmail.com>
References: <AANLkTi=42V8=26oEwcNOHubuK+VAf-QaYnvCLAKQ0xtg@mail.gmail.com>
	<vpq4of2scen.fsf@bauges.imag.fr>
	<AANLkTi=UCJa9uT5i9TRB9hGsH1D8b9DgB49TPM5k1htQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: James <purpleidea@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 18:03:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OirI6-0000aQ-It
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 18:03:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307Ab0HJQCx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 12:02:53 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42896 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932292Ab0HJQCt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 12:02:49 -0400
Received: by fxm13 with SMTP id 13so787755fxm.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 09:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=SGqte2yOhBZKFPOzV7tFQ5CUX+eMhTFhLxan32X5vEE=;
        b=avwumzXLSnujjICzcUehUwudhHvP7620i8wTD1G4wo/84hq7tw/62l60yL57NSJjOG
         8t8HBH15QQqzvVALcIg7+aGts6CMxdpLjJSDz1gdHt4tR7VhpRItj1fY9RpMpOnQ2/lK
         MQlY7IuSxWgqC62zoVuMGngKImkbebevbLPQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=vUNkCG8mtKYgPpefvHbsdpROBUf7omB1K4KTBhLg8oQPFF8RWC5CGasQghGlWrCD2r
         uBtsB7nzl9VztubnkD7cOjru7eKpHLIqxhRjD+KypabZhFoT9sKOE0vALinCBvZW9E6R
         dtslanCdnTZcDWpE5YrP9D0ZtXhWtiBV/q/fA=
Received: by 10.223.104.130 with SMTP id p2mr18516043fao.9.1281456168494; Tue, 
	10 Aug 2010 09:02:48 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Tue, 10 Aug 2010 09:02:48 -0700 (PDT)
In-Reply-To: <AANLkTi=UCJa9uT5i9TRB9hGsH1D8b9DgB49TPM5k1htQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153125>

On Tue, Aug 10, 2010 at 15:54, James <purpleidea@gmail.com> wrote:
> Sorry about that,
> I guess I had only read the README.
> Hope this is better:

Not really, no. You should send the patches you produce with
git-format-patch with git-send-email, and try sending to yourself
first and apply it with git-am (this is all mentioned in
SubmittingPatches).

This is what your new patch looks like after being applied with
git-am:

    commit 7be6207e8923cd7c4c48243f5257a0fdba6bfa0a
    Author: James <purpleidea@gmail.com>
    Date:   Tue Aug 10 11:54:43 2010 -0400

        Use a default for a bad env config file variable

        Sorry about that,
        I guess I had only read the README.
        Hope this is better:

        From d29adf8c788b8a747bfd38dd7e10f684de9aa8e9 Mon Sep 17 00:00:00 2001
        From: James Shubin <purpleidea@gmail.com>
        Date: Tue, 10 Aug 2010 10:30:22 -0400
        Subject: [PATCH] Use a default for a bad env config file variable.

        Signed-off-by: James Shubin <purpleidea@gmail.com>

    diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
    index 4efeebc..43294e1 100755
    --- a/gitweb/gitweb.perl
    +++ b/gitweb/gitweb.perl
    @@ -605,6 +605,10 @@ sub evaluate_gitweb_config {
            } elsif (-e $GITWEB_CONFIG_SYSTEM) {
                    do $GITWEB_CONFIG_SYSTEM;
                    die $@ if $@;
    +       # if config file from env is missing, then try the default anyways
    +       } elsif (-e "++GITWEB_CONFIG_SYSTEM++") {
    +               do "++GITWEB_CONFIG_SYSTEM++";
    +               die $@ if $@;
            }
     }

I.e. your message has become part of the patch. To include commentary
on resend add it after -- and before the diffstat (also in
SubmittingPatches).

Thanks.
