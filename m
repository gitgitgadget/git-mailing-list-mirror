From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: git semd-email - Unknown callback: 'authname'. (user|auth|language|pass)
Date: Sat, 4 Sep 2010 10:29:18 +0000
Message-ID: <AANLkTi=cORHnbzPLkGPAG+nUz5+3FGTxzSvAO+TrdA1Q@mail.gmail.com>
References: <1283586088.7322.35.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Mike Galbraith <efault@gmx.de>
X-From: git-owner@vger.kernel.org Sat Sep 04 12:29:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Orq07-0007k9-19
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 12:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442Ab0IDK3U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Sep 2010 06:29:20 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64200 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637Ab0IDK3T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Sep 2010 06:29:19 -0400
Received: by iwn5 with SMTP id 5so2348962iwn.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 03:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TryK7d09gcEarFd7+lPMGMNOhgw8YCc0ovX38DnsMII=;
        b=JbvjeQDI0UGHIjGIiUvI3tJ7hUC578MSbmPA09EJ6IfCYHhOmmi0VAApT/+o32hKxY
         9JQiovbOUiR+Rp2SiUYNzr8jNIo0yNApxEsxiECO6IVfd8biHKquVANAkaBD6bjUoV5Q
         GSY3kc75AxLLs9NAIif4gw4Z7GZcKXg2exirs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=J+bWJHtV3xV4UNNRGulgu1nT2rwbBXXvr5Voak5vZTsGxK+F8+xRd1Vu/gWCXME1fx
         f4DH010n0pIg3DgMukWRxSicMuRa7NcAzH0ESrynGRtXsoZx2qPKxZJOYFRZWg047K2M
         0sKw4pVewl6lgLoh9V/GrCD2zX8P3CP3HgLB4=
Received: by 10.231.19.74 with SMTP id z10mr2578647iba.120.1283596158948; Sat,
 04 Sep 2010 03:29:18 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sat, 4 Sep 2010 03:29:18 -0700 (PDT)
In-Reply-To: <1283586088.7322.35.camel@marge.simson.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155315>

On Sat, Sep 4, 2010 at 07:41, Mike Galbraith <efault@gmx.de> wrote:
> Greetings,
>
> Trying to convince send-email to send a series isn't working out for =
me
> at all, and I'm wondering what I'm doing wrong.
>
> (using git 1.7.2.3 now , was 1.7.2.2 yesterday)
>
> git send-email --compose --from=3D'Mike Galbraith <efault@gmx.de>' --=
to=3D'Mike Galbraith <efault@gmx.de>' --subject=3D'el-testo' --suppress=
-cc=3Dall --thread v2.6.32.21...
>
> From: Mike Galbraith <efault@gmx.de>
> To: Mike Galbraith <efault@gmx.de>
> Subject: [PATCH 01/50] sched: kill migration thread in CPU_POST_DEAD =
instead of CPU_DEAD
> Date: Sat, =C2=A04 Sep 2010 09:03:26 +0200
> Message-Id: <1283583855-23333-1-git-send-email-efault@gmx.de>
> X-Mailer: git-send-email 1.7.2.3
>
> Send this email? ([y]es|[n]o|[q]uit|[a]ll): y
> Unknown callback: 'authname'. (user|auth|language|pass)

No idea what that's about.

> Also, with sendemail.smtpencryption =3D ssl
>
> Send this email? ([y]es|[n]o|[q]uit|[a]ll): y
> Can't locate Net/SMTP/SSL.pm in @INC (@INC contains: /usr/lib/perl5/s=
ite_perl/5.10.0/x86_64-linux-thread-multi /usr/lib/perl5/site_perl/5.10=
=2E0 /usr/lib/perl5/5.10.0/x86_64-linux-thread-multi /usr/lib/perl5/5.1=
0.0 /usr/lib/perl5/vendor_perl/5.10.0/x86_64-linux-thread-multi /usr/li=
b/perl5/vendor_perl/5.10.0 /usr/lib/perl5/vendor_perl .) at /usr/lib/gi=
t/git-send-email line 1037.
>
> Linking /usr/lib/perl5/vendor_perl/5.10.0/x86_64-linux-thread-multi/N=
et/SSL.pm so it can find/include it didn't help much..
>
> From: Mike Galbraith <efault@gmx.de>
> To: Mike Galbraith <efault@gmx.de>
> Subject: [PATCH 01/50] sched: kill migration thread in CPU_POST_DEAD =
instead of CPU_DEAD
> Date: Sat, =C2=A04 Sep 2010 09:19:09 +0200
> Message-Id: <1283584798-23449-1-git-send-email-efault@gmx.de>
> X-Mailer: git-send-email 1.7.2.3
>
> Send this email? ([y]es|[n]o|[q]uit|[a]ll): y
> Can't locate object method "new" via package "Net::SMTP::SSL" at /usr=
/lib/git/git-send-email line 1039.

You can't just symlink a single .pm file like that to use it. It
likely ends up using some .so in the perl module tree to include
libssl, it can't find that (and probably random other stuff) if you
symlink a single file.

The right way to do this is to include the paths you need in your @INC
(see perldoc -q '@INC'), but even then perhaps the path isn't in @INC
for a reason, e.g. it may be compiled for a different perl than yours.
