From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: Re: [PATCH] Make git-pack-redundant take a list of unimportant objs
 on   stdin
Date: Mon, 21 Nov 2005 12:45:22 +0100
Message-ID: <4381B352.20107@etek.chalmers.se>
References: <437E530E.1020803@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 21 12:45:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeA6W-00072K-EB
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 12:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbVKULo5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 21 Nov 2005 06:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbVKULo5
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 06:44:57 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:51855 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932182AbVKULo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 06:44:56 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout2-sn1.fre.skanova.net (7.2.069.1)
        id 437D32AE000B53D9; Mon, 21 Nov 2005 12:44:49 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <437E530E.1020803@etek.chalmers.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12438>

Lukas Sandstr=C3=B6m wrote:
> This lets us do "git-fsck-objects --full --unreachable | cut -d ' ' -=
f3 |
> git-pack-redundant --all", which will keep git-pack-redundant from ke=
eping
> packs just because they contain unreachable objects.
>=20
> Also add some more --verbose output.
>=20
> Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
>=20

The patch which documents this feature was committed (9a888b758f48d88d1=
e83c9765e33d4452710d5a5),
but not the feature. Did you just miss the patch, or is there something=
 wrong with it?

/Lukas
