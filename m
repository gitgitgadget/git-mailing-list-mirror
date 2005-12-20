From: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: Re: [PATCH] git-pack-redundant: speed and memory usage improvements
Date: Tue, 20 Dec 2005 22:26:19 +0100
Organization: Chalmers
Message-ID: <43A876FB.8020901@etek.chalmers.se>
References: <43A86422.3090909@etek.chalmers.se> <7virtjh479.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 20 22:28:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoozE-0007E7-M4
	for gcvg-git@gmane.org; Tue, 20 Dec 2005 22:25:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbVLTVZ3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 20 Dec 2005 16:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbVLTVZ3
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Dec 2005 16:25:29 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:16270 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932125AbVLTVZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2005 16:25:28 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout2-sn1.fre.skanova.net (7.2.069.1)
        id 43A8126C00026D9B; Tue, 20 Dec 2005 22:25:18 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virtjh479.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13855>

Junio C Hamano wrote:
> Lukas Sandstr=F6m <lukass@etek.chalmers.se> writes:
>=20
>=20
>>This might be post-1.0 material, but I have tested it on a couple of
>>different repositories and it appears to work as before, only faster
>>and using less memory.
>=20
>=20
> Thanks.
>=20
> I had an impression that somehow we already had this slabbish
> allocation but apparently we didn't.
>=20
> Any particular area you have worries/uncertainty about, that
> makes you mark this post-1.0?
>=20

No, as far as I can see, there should be no problems with the patch.
It is non-trivial though so, according to history, there might be=20
bugs that only show on certain repositories.

/Lukas
