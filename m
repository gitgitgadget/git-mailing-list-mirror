From: dexen deVries <dexen.devries@gmail.com>
Subject: Re: Feature requset: listing of current stash in git gui
Date: Mon, 21 Nov 2011 13:41:06 +0100
Message-ID: <201111211341.07939.dexen.devries@gmail.com>
References: <201111211100.52367.dexen.devries@gmail.com> <4ECA2D8F.4060005@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 21 13:41:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSTBW-0005YH-Ev
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 13:41:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192Ab1KUMlN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Nov 2011 07:41:13 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61124 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134Ab1KUMlN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2011 07:41:13 -0500
Received: by bke11 with SMTP id 11so6493750bke.19
        for <git@vger.kernel.org>; Mon, 21 Nov 2011 04:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:x-face
         :mime-version:content-type:content-transfer-encoding:message-id;
        bh=4PXhEx/elK9rrRalSypr37zDsS/RbQg+vbWLJ5utmSs=;
        b=tK382mdy8kaXZroxw2az9wEWklfT22M5AYoOndXreCsaBJvxnfIQqmbXXvbCLyGLMQ
         edwZj3y9y+PQXPSxPOPQp1UKTZbVTFegKTqg8cLmWNVmqT4ygpiaazacMkeyjS+OJkyD
         F6/dh8xO4GWCyU4u+iNivkho+GTdX+iRPkWo8=
Received: by 10.204.130.85 with SMTP id r21mr13943368bks.38.1321879271789;
        Mon, 21 Nov 2011 04:41:11 -0800 (PST)
Received: from coil.localnet ([89.228.8.130])
        by mx.google.com with ESMTPS id x19sm15462460fag.5.2011.11.21.04.41.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Nov 2011 04:41:09 -0800 (PST)
User-Agent: KMail/1.13.6 (Linux/3.2.0-rc2-l41; KDE/4.5.5; x86_64; ; )
In-Reply-To: <4ECA2D8F.4060005@atlas-elektronik.com>
X-Face: 1TH%]0KlR_DQ/V9+m_"neC|Yj3$MU@B/vVI\}^j`G/[9JKe=5`p[$l|z^\MRO%<
 =?utf-8?q?k=3A9xXL=5B=0A=09=5F!jEZo8=24=5B=5Dyo=7B7O-=5Dt=5F?=@Qj`v5H@L[YyU<#j7(H)P\{pMs))9$@Vww1"
 =?utf-8?q?ni-=7B+=7B5olk=3DXY=26G=0A=09?=,}|UHQMC08506\0=+p|75ucH!S!1UcXoC1vgpN_{lOMt_54_N5;)ngh6=D^uZN,
 =?utf-8?q?=7DZI9-k9=0A=09?="v<!}`jpCUMM,//`>H6w{K<geM^bS]jwD8'lAEX9>F[ScIHig1.r%65;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185742>

On Monday 21 of November 2011 11:53:03 Stefan N=C3=A4we wrote:
> You can simply put the following in your ~/.gitconfig:
>=20
> [guitool "Stash/show"]
> 	cmd =3D git stash show -p
> [guitool "Stash/list"]
> 	cmd =3D git stash list
> [guitool "Stash/pop"]
> 	cmd =3D git stash pop
> [guitool "Stash/drop"]
> 	cmd =3D git stash drop
> 	confirm =3D yes

that's nice, but doesn't list visually the stashed changes. I'd rather =
have a=20
listing similar to Unstanged Changes / Staged Changes, with ability to =
view=20
line-by-line diff just like for Changes.


Regards,
--=20
dexen deVries

[[[=E2=86=93][=E2=86=92]]]

``As my friend Jacob Gabrielson once put it, advocating Object-Oriented=
=20
Programming is like advocating Pants-Oriented Clothing.''
 -- Steve Yegge, in
http://steve-yegge.blogspot.com/2006/03/execution-in-kingdom-of-nouns.h=
tml
