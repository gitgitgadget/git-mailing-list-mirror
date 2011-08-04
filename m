From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: (unknown)
Date: Thu, 4 Aug 2011 18:27:23 +0100 (BST)
Message-ID: <1312478843.69439.YahooMailClassic@web29510.mail.ird.yahoo.com>
Reply-To: htl10@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, rene.scharfe@lsrfire.ath.cx
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 04 19:27:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qp1hj-0003t9-8F
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 19:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650Ab1HDR11 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Aug 2011 13:27:27 -0400
Received: from nm10-vm0.bullet.mail.ird.yahoo.com ([77.238.189.90]:27363 "HELO
	nm10-vm0.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754522Ab1HDR1Z convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 4 Aug 2011 13:27:25 -0400
Received: from [77.238.189.52] by nm10.bullet.mail.ird.yahoo.com with NNFMP; 04 Aug 2011 17:27:24 -0000
Received: from [212.82.108.247] by tm5.bullet.mail.ird.yahoo.com with NNFMP; 04 Aug 2011 17:27:24 -0000
Received: from [127.0.0.1] by omp1012.mail.ird.yahoo.com with NNFMP; 04 Aug 2011 17:27:24 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 121550.93878.bm@omp1012.mail.ird.yahoo.com
Received: (qmail 1006 invoked by uid 60001); 4 Aug 2011 17:27:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1312478844; bh=cPB1NKmd+0Cz5XgS0w0PAzuXRoZHtAM9WreWXuSfMtE=; h=X-YMail-OSG:Received:X-RocketYMMF:X-Mailer:Message-ID:Date:From:Reply-To:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=WNb3llOgHuoY5zUcRAdTJ9A8EcfpiNB633B8OFoGJHqBMYJAaMfG0XM/x7djonoTEpnfotoMm5shyqTv9RgmxikYcDYPFdGvuYtk0pwUFJPFBJIgrGf2xLvf97TMcksQggNura93pdkw/1+AEJZUKlvTdcVjlsDIOM1pQT1bxKM=
X-YMail-OSG: hOtVMrEVM1mefUPaZN0tTzTe4xKbBRjzD1IZ75yjpWI0D21
 t8AbBjbcZoU8L274K1Pte0nQBUuz7LtQfyz_VXoQjes_uE93V53fv7m2sOuN
 vYoBAViI9ohsX1ZEftKml9R6QgYCHWN785mAwNfyYUR5IZORKn6lYxb9QQRQ
 SwYfVpP113kUhEyHv79iOMDEYODMqDrvfm9KsWuoSowTPqXQrIWyxhdnbsjZ
 Q3jURsMCfJfoCcB8AAqrP1QjqywKZrjlDoo.yciSL6n.rI7ysIGIYUA1MUa_
 FkNjDRQ_NXFZn17Jb7QXi8uITDrvOjrUC2oPPdcee33jv3h2THomOzMh7_HX
 ekklIPlliMoAifqnDls3gR43dRHnrNvU3JlfeT8pev6WpHTNMdINlpuAsSGx
 VAM7UFf9Atkaajhp6JA71A_1uLrXcCPanHHqjV_UswV_hSejhIQ6GawH4mmG
 0kYMVY8N.0zV1jzJWXyqUTxazcLJnSqVDAGBLNwFVpVqf.gc8evFpwnHyKet
 ADc2f6_ahYqL8MaQ1
Received: from [81.101.129.153] by web29510.mail.ird.yahoo.com via HTTP; Thu, 04 Aug 2011 18:27:23 BST
X-RocketYMMF: hintak_leung
X-Mailer: YahooMailClassic/14.0.3 YahooMailWebService/0.8.113.313619
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178754>

--- On Thu, 4/8/11, Jeff King <peff@peff.net> wrote:

> On Wed, Aug 03, 2011 at 11:17:59PM
> +0100, Hin-Tak Leung wrote:
>=20
> > The summary of the problem is that, git-archive's
> "--format=3Dtar"
> > option really write the pax format most of the time,
> and some
> > cross-platform archive extraction library (rather than
> the
> > all-powerful GNU tar) really does not think that's the
> tar format and
> > bail out.
>=20
> Out of curiosity, what is the library? Putting pax headers
> into ustar
> format has been standardized in POSIX since 2001.

The R people wrote their own in the R language (and the person who resp=
onded to my post in that R-devel thread was possibly the one who wrote =
that part, I believe) - The main reason is probably cross-platform-ness=
 and independence from other programming languages - they are gradually=
 moving away from invoking system() (because they need to run on window=
s and they used to require many cygwin/mingw tools to build add-on pack=
ages).

The R code which does that, scan for certain patterns after seek() into=
 the gunzip'ed stream after 512(?) bytes. It is in a file=20
R/src/library/utils/R/tar.R under the source repository.

> That header contains useful information (the commit id from
> which the
> archive was generated). And there is a way to turn it off:
> give a tree
> id instead of a commit id. There is an example in the
> git-archive
> manpage that does exactly this already. Look for the
> example mentioning
> "pax header" here:
>=20
> =A0 http://www.kernel.org/pub/software/scm/git/docs/git-archive.html
>=20
> It might be a bit more obvious to find if we actually had
> a
> --no-pax-header option, though.
>=20
> -Peff
>=20


I think I tried the tree example and the R code also didn't like it muc=
h... may be I'll give it another try.
