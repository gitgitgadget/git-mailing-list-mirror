From: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH] Documentation: fix a typo in git-apply.txt
Date: Fri, 4 Mar 2011 08:56:22 +0100
Message-ID: <20110304085622.6faa0c93@mkiedrowicz>
References: <1299144510-8143-1-git-send-email-michal.kiedrowicz@gmail.com>
 <7vlj0v942a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 08:56:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvPsF-00058F-9O
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 08:56:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758451Ab1CDH41 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Mar 2011 02:56:27 -0500
Received: from mail-wy0-f194.google.com ([74.125.82.194]:40085 "EHLO
	mail-wy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896Ab1CDH40 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Mar 2011 02:56:26 -0500
Received: by wyj26 with SMTP id 26so349072wyj.1
        for <git@vger.kernel.org>; Thu, 03 Mar 2011 23:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:in-reply-to
         :references:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=kBGT4d/8sWaIwVBJ1Fu+TzjaZGeDFaqGzuo4ZxOeNBg=;
        b=eL9yFtZkW4IZcjXFchqY7Kq/qRZg8t0uTrx7w5q4cHddU8rqZbCPfjGclRbhvuPKIa
         A5kPuLJ/yxg6WK5Wxi3OqSikrm7Kz/t+yAdsVrg8MV67ulZunjWIgQ+9w/TEMMNw8Gd6
         5/WYHPhWi03jb8j4LZVEJr4Xzo1uOvQo6aYFI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=drWzj8itYt1yHKpk32yBPkg3JAV76wY+Ojk5+646Om5NfQ7FSOceZVb0qjzVilhHit
         bVcZxv8CJ76eyerGKhz+oQRR7ggzqnSQE0AmzBSGTqjn0zNOPGgvlGCrpwSGMVfN4lYr
         2WE2kLx9w0FEKyPPc3etMmMEZm6Cf2CICuzFM=
Received: by 10.216.54.133 with SMTP id i5mr305296wec.23.1299225384936;
        Thu, 03 Mar 2011 23:56:24 -0800 (PST)
Received: from mkiedrowicz (pc10.ivo.park.gdynia.pl [153.19.128.10])
        by mx.google.com with ESMTPS id t5sm1013794wes.9.2011.03.03.23.56.24
        (version=SSLv3 cipher=OTHER);
        Thu, 03 Mar 2011 23:56:24 -0800 (PST)
In-Reply-To: <7vlj0v942a.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.7.8 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168432>

On 03.03.2011 15:28:45 -0800 Junio C Hamano <gitster@pobox.com> wrote:

> Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
>=20
> > git-apply accepts the --cached option, not --cache.
> >
> > Signed-off-by: Micha=3DC5=3D82 Kiedrowicz <michal.kiedrowicz@gmail.=
com>
> > ---
> >  Documentation/git-apply.txt |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git Documentation/git-apply.txt Documentation/git-apply.txt
> > index 881652f..2dcfc09 100644
> > --- Documentation/git-apply.txt
> > +++ Documentation/git-apply.txt
>=20
> What kind of crap is this?
>=20
> We really should make it much harder for people to use funky src/dst
> prefix when generating patches.

It's called diff.noprefix=3Dtrue :). I use it @work to easily copy/past=
e
paths from git-diff output. I guess I should somehow make git.git
config ignore global settings.

---
=46rom: =3D?UTF-8?q?Micha=3DC5=3D82=3D20Kiedrowicz?=3D <michal.kiedrowi=
cz@gmail.com>
Date: Thu, 3 Mar 2011 09:51:46 +0100
Subject: [PATCH] Documentation: fix a typo in git-apply.txt
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

git-apply accepts the --cached option, not --cache.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 Documentation/git-apply.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 881652f..2dcfc09 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -22,7 +22,7 @@ DESCRIPTION
 -----------
 Reads the supplied diff output (i.e. "a patch") and applies it to file=
s.
 With the `--index` option the patch is also applied to the index, and
-with the `--cache` option the patch is only applied to the index.
+with the `--cached` option the patch is only applied to the index.
 Without these options, the command applies the patch only to files,
 and does not require them to be in a git repository.

--=20
1.7.4.1
