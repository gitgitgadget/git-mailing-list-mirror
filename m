From: Daniel Johnson <computerdruid@gmail.com>
Subject: Re: svn2git question:  Build directory inserted at top level?
Date: Wed, 15 Sep 2010 13:44:03 -0400
Message-ID: <201009151344.17066.ComputerDruid@gmail.com>
References: <DDB24DEE-934B-4C8D-8DAA-595905035AC4@jetbrains.com> <4E10ACF241081344B9702AA8C6440440C5B13F2162@MX01A.corp.emc.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1603687.ZWlik7kaTx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: nolan.ring@emc.com
X-From: git-owner@vger.kernel.org Wed Sep 15 19:43:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ovw0p-0000Wl-U2
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 19:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754215Ab0IORnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 13:43:09 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:38023 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753847Ab0IORnH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Sep 2010 13:43:07 -0400
Received: by qyk33 with SMTP id 33so428103qyk.19
        for <git@vger.kernel.org>; Wed, 15 Sep 2010 10:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=4o9glpieVcb37/a+LTc8bzjY5ZPLI+hM7V6/JRYucw4=;
        b=TQOxbzBdYNhVoM5uqR8PPSSpjWdtNkc31j+9nIvLw8OA6v2drH5ZiUg0qAkpB6QIZq
         3CQvcEJnHQaex86WBkD9Tt6RUFB+7TMJnMsS6xuekmooupzK6oAvtpIw2N9MGB0xmz7l
         BygcRE2HxbYOdMRim+WxwgCmFrApbhmReKf5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=H7BkVjl70cWc9Jge2sKVjJbF2P0yYYAbCPLZVlP8/BQgfsIz/sbknrwvhTrYp275jK
         dFC5aQNBArPrRFKjNx0odT9UrRiGWR/DyRyW+gYSiTJCtqOeUSoOfCEla7Rf+AYLd0bg
         V3+0+nrtfjnxxwADm82N+6I4bhuTqYOdlZUos=
Received: by 10.224.69.14 with SMTP id x14mr1309511qai.212.1284572585923;
        Wed, 15 Sep 2010 10:43:05 -0700 (PDT)
Received: from hyperion.localnet (hyperion.student.rit.edu [129.21.115.212])
        by mx.google.com with ESMTPS id 9sm1595122qca.30.2010.09.15.10.43.03
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 15 Sep 2010 10:43:03 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.35.3; KDE/4.5.0; x86_64; ; )
In-Reply-To: <4E10ACF241081344B9702AA8C6440440C5B13F2162@MX01A.corp.emc.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156241>

--nextPart1603687.ZWlik7kaTx
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Sidenote: You shouldn't reply to unrelated messages when starting a new=20
thread. In my mail client this shows up as a reply to "git log --pretty=3Df=
ormat=20
joins lines in the subject of commit message" which doesn't seem to have=20
anything to do with your question.

On Wednesday 15 September 2010 09:47:42 nolan.ring@emc.com wrote:
> When I include the branches in the conversion I get a Build directory at
> the top level and then the usual directory structure of the repo.  Where
> is the Build dir coming from?  Is svn2git doing that?  Or is it finding
> that somewhere somehow in the repo?
>=20
> buildadm@suse-s11:/work/POCcs> ls
> Build
> buildadm@suse-s11:/work/POCcs/Build> ls
> Automation  build_cs_rpm.pl  ControlStation  depends.properties

Assuming the files are tracked by git, you might want to try running "git l=
og=20
=2D- $filename" over them to see which commits touched them.

--nextPart1603687.ZWlik7kaTx
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAkyRBfAACgkQhP2Vm0oJTtzqwQCgltuNHe5Qj3TmP081U8EXXeIl
+2gAoJFpe0WqjGYHOrgIjVpOmsfQP+9s
=tgze
-----END PGP SIGNATURE-----

--nextPart1603687.ZWlik7kaTx--
