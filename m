From: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: Re: fix git-pack-redundant crashing sometimes
Date: Thu, 17 Nov 2005 00:59:13 +0100
Organization: Chalmers
Message-ID: <437BC7D1.1070605@etek.chalmers.se>
References: <81b0412b0511150749g5672158v7b39c02ffdf13e08@mail.gmail.com> <20051115213442.GA4256@steel.home> <437A560E.8020500@etek.chalmers.se> <20051115223340.GA3951@steel.home> <Pine.LNX.4.64.0511151552400.11232@g5.osdl.org> <437BA6A6.8080900@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>,
	Linus Torvalds <torvalds@osdl.org>,
	Alex Riesen <raa.lkml@gmail.com>, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Nov 17 01:00:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcXBD-0008B9-1f
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 00:59:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161034AbVKPX6q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 16 Nov 2005 18:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161031AbVKPX6p
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 18:58:45 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:9861 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1161034AbVKPX6p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 18:58:45 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout1-sn2.hy.skanova.net (7.2.060.1)
        id 4378E953000CE349; Thu, 17 Nov 2005 00:58:44 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <437BA6A6.8080900@etek.chalmers.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12076>

Lukas Sandstr=F6m wrote:
> Linus Torvalds wrote:
>=20
>>On Tue, 15 Nov 2005, Alex Riesen wrote:
>>
>>
>>>Sorry, it doesn't. The code loops here:
>>>
>>>401             /* find the permutations which contain all missing o=
bjects */
>>>402             perm_all =3D perm =3D get_all_permutations(non_uniqu=
e);
>>
>>
>>Looks like the whole thing is exponential.
>>
>=20
> Slightly less, but not far from.
>=20
After doing some maths; actually it is very exponential. 2**n - 1 to be=
 precise.
