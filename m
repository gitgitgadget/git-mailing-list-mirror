From: Seshu Parvataneni <parvata@rocketmail.com>
Subject: Re: [solved] how to create a diff in old file new file format (for code reviews)
Date: Wed, 15 Dec 2010 19:33:50 -0800 (PST)
Message-ID: <415120.5940.qm@web34306.mail.mud.yahoo.com>
References: <4D073619.2010103@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Dec 16 04:40:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PT4hs-0005yg-En
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 04:40:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756012Ab0LPDke convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Dec 2010 22:40:34 -0500
Received: from web34306.mail.mud.yahoo.com ([66.163.178.138]:22302 "HELO
	web34306.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755968Ab0LPDkd convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 22:40:33 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Dec 2010 22:40:33 EST
Received: (qmail 11887 invoked by uid 60001); 16 Dec 2010 03:33:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s1024; t=1292470431; bh=vX7ljhFahJma5141/kg3tNGpZE9Ui33rSr1n+8/281E=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=4qiLoM6Kz3Ccc87QmFymzfgMgmlv0RiM04JkfVIqet6NHpTFhP5+dCe6ATknjviA/MMbe0ONNRjUyETmC+Rv5p9oshARDhn19Yl5oILprdpLLF+3AxAVAwggOawpJ4rYvDjqs3idVeXSrnFp2KNEWlUrIP4vVHBXw8NYIufxROk=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rocketmail.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=pqmTeYEk2taYAiES8hRmWRBSo9GibxjVeI8UfWkMXee9RX1HxRnpmQgOCBzdp6EvDcFIey09Ml9PUoGmIGsxMnDeZDuBR+yVjFQTT62Ywxfta7VGQsxn19WmWBu96S7eOlB1ONWjZTHt+qp+kLvxK63H57/VdXV+ptI7xRRP9GU=;
X-YMail-OSG: I0RgNvgVM1lpuN0YWC6Z4mwWMuj69CZ8aHZTZEicUCHBjjE
 Tce9RJX38GuQ87M2t.8_SGs97ttvZqt1VxwAkpm3TeEgZ7gEAoB7eIhEWg1n
 sz5RsUQ_TK4MOmC3hXpa5XTaiAjq0COKjgV3oJIqJT32CuSaCKzp9WIXKYBt
 H.TlQjzh9DUpYgyT7D53VOXLI833UVe7W5cUeDcaPhJDLOz8mCd0Tm6JIkOz
 z1j6P96e2V4bzgtDykt645l08XWhGT.9e.SoiMNPN9CJ5Ch2lm9J9mOw8D6R
 1ppAjnpH2MCucrgCgYki6FJ0DwwQaqyddtP1_jMsm2sdXJBOAj0orFsFAWs7
 u9zh6.ZJriBN1lAZIxH8UmKYpHujhq.1zJI9xzaLXHVA_7699ofwk1ld4lkn
 I4pNcScqGTMWmy.MSXA--
Received: from [207.6.159.130] by web34306.mail.mud.yahoo.com via HTTP; Wed, 15 Dec 2010 19:33:50 PST
X-Mailer: YahooMailClassic/11.4.9 YahooMailWebService/0.8.107.285259
In-Reply-To: <4D073619.2010103@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163799>

Hi Michael,

Thanks very much for the reply. Your example with the difftool worked. =
This was what I was looking for.



--- On Tue, 12/14/10, Michael J Gruber <git@drmicha.warpmail.net> wrote=
:

> From: Michael J Gruber <git@drmicha.warpmail.net>
> Subject: Re: how to create a diff in old file new file format (for co=
de reviews)
> To: "aerosmith" <parvata@rocketmail.com>
> Cc: git@vger.kernel.org
> Date: Tuesday, December 14, 2010, 1:17 AM
> aerosmith venit, vidit, dixit
> 14.12.2010 01:07:
> >=20
> > Hi,
> >=20
> > I am trying to create a diff such that the original
> file (entire file) is
> > saved something like file1.h.old and the new modified
> file as file1.h.new. I
> > have read the various options for git-diff* tools but
> could not find one
> > such utility. All I get is the removals and additions
> as a diff. Does anyone
> > know how to create one with the help the available git
> utils? The only
> > method that I can think of is to do everything
> manually. Any help w.r.t.
> > this is really appreciated. Thanks in advance.
>=20
> You could script around this e.g. with an external
> diff-helper. The
> easiest way is to reuse difftool. For example,
>=20
> git difftool -y -x echo <revexpression>
>=20
> will give you pairs of names of temporary files for
> old/new, where
> <revexpression> is what you would give to "git diff"
> to specify what to
> diff.
>=20
> With the patch I'm sending in a minute, the helper you
> specify with "-x"
> can also access the basename easily, so that you could use
> "-x oldnew"
> with a script "oldnew" containing
>=20
> #!/bin/sh
> cp "$1" "$BASE".old
> cp "$2" "$BASE".new
>=20
> Even without the patch, you could use
>=20
> git difftool -y -x 'cp "$LOCAL" "$BASE".old; cp "$REMOTE"
> "$BASE.new";
> #' <revexpression>
>=20
> (all on one line) directly. But this requires insider
> knowledge and may
> break some day.
>=20
> Cheers,
> Michael
> --
> To unsubscribe from this list: send the line "unsubscribe
> git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=A0 http://vger.kernel.org/majordomo-info.html
>=20


     =20
