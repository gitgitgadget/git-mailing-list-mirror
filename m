From: Timothy Normand Miller <theosib@att.net>
Subject: =?windows-1252?Q?Re=3A_Git_hangs_at_=93Writing_objects=3A_11=25?=
 =?windows-1252?Q?=94?=
Date: Tue, 29 May 2012 16:42:29 -0400
Message-ID: <995429D1-7204-4B8E-A7CE-94ABB99D707B@att.net>
References: <EF4D4C5F-2D6B-46F2-B5A4-9DB1BA55BB6B@att.net> <20120525005156.GC11300@sigill.intra.peff.net> <033AF49C-4CB3-4412-8845-0246D356358C@att.net> <2DE05B0B-1D7E-451F-9151-B01CDDF4593E@att.net> <201205270312.q4R3Chef014187@no.baka.org> <3BBC77C3-B747-4F68-A135-954C3C00ECBA@att.net> <alpine.DEB.2.00.1205282225590.31146@cone.martin.st>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Seth Robertson <in-gitvger@baka.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: =?iso-8859-1?Q?Martin_Storsj=F6?= <martin@martin.st>
X-From: git-owner@vger.kernel.org Tue May 29 22:42:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZTFX-00078m-2X
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 22:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754302Ab2E2Umd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 May 2012 16:42:33 -0400
Received: from nm16.bullet.mail.bf1.yahoo.com ([98.139.212.175]:44331 "HELO
	nm16.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753716Ab2E2Umc convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2012 16:42:32 -0400
Received: from [98.139.212.151] by nm16.bullet.mail.bf1.yahoo.com with NNFMP; 29 May 2012 20:42:32 -0000
Received: from [68.142.194.244] by tm8.bullet.mail.bf1.yahoo.com with NNFMP; 29 May 2012 20:42:31 -0000
Received: from [66.94.237.121] by t2.bullet.mud.yahoo.com with NNFMP; 29 May 2012 20:42:31 -0000
Received: from [127.0.0.1] by omp1026.access.mail.mud.yahoo.com with NNFMP; 29 May 2012 20:42:31 -0000
X-Yahoo-Newman-Id: 862573.50553.bm@omp1026.access.mail.mud.yahoo.com
Received: (qmail 37490 invoked from network); 29 May 2012 20:42:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1338324151; bh=kB5LtP07EsFHhELjInvWHekt8gVQHZAJ4bdgQaTKhZU=; h=X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:Received:Subject:Mime-Version:Content-Type:From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:To:X-Mailer; b=ZV3EVfzs329ssogyi7EYcHTJTm9For/mRQMeWR3OZYIjDKnfF0YapFvyiwnTtL63pfit+uQvNhlXF9UoVCUWQ8gN8kxncUepVSz/5lDrPyX4+/BElyMzupC4+QvJyij5ZFsF3tg+tow7hy88MTsjAjiQ52HqwE1ASBW9eCpJHnc=
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: pK2roWgVM1lLGP7C5VZ9Bq8KqdT8VgGwhrBV3_X6BD4Wrol
 pe.gFj1DDc6rVAxvO3Au6CzvONoT8HeTx8fCejzhxHjWLUv64yyGQ.LMg4UF
 9wl8IN99gS2HfqsCIFjDU_OUkcH0mIkd80Gx6VV9LbSHS3fxNxtthCNRjhRs
 qkCByLWwgO67C.mpZIfth.mu9kSclbgdIpmuZ_gwgScsdzmHCxK52evgjtVD
 6dui96Z1IPWpkA7JZepHVpJtusI1lGKOGRZ3_hCNpg_C543lB_PTIcUB2_37
 889I2H_FT4AH_GPp8IZlQV8V0yrJNHfIZYswCw5S9YoiN8p77UHhk_tID9Sc
 stib2dK5iJDx9srgqJabuIPlMWodWkzjdLDN_U3iWu52eh219OktJFiWWkPo
 Ttj7p4ZRar_z1Ia7BLQEVrV97UbsfLNbX8Ir8S0W7J8819_FIXkrJrVH_F_q
 0eF9zIWV1qp0R3QkUnFTmtIhbizTJkOo-
X-Yahoo-SMTP: fnCipqKswBBOUfpM7XF4CajMkMYSy.KS.UTLsA--
Received: from [192.168.115.12] (theosib@76.232.38.36 with plain)
        by smtp106.sbc.mail.ne1.yahoo.com with SMTP; 29 May 2012 13:42:31 -0700 PDT
In-Reply-To: <alpine.DEB.2.00.1205282225590.31146@cone.martin.st>
X-Mailer: Apple Mail (2.1278)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198760>


The fix is to set "TcpRcvBufPoll no" in sshd_config.

http://forums.gentoo.org/viewtopic-t-925044-start-0-postdays-0-postorde=
r-asc-highlight-.html
http://forums.gentoo.org/viewtopic-p-7036250.html


On May 28, 2012, at 3:36 PM, Martin Storsj=F6 wrote:

> On Mon, 28 May 2012, Timothy Normand Miller wrote:
>=20
>> I tried uploading a file via sftp, and it stalls out at 160K.  So th=
is is the cause of the problem.  SSH is broken.  Unfortunately, googlin=
g for ssh and stall isn't getting me anywhere.
>=20
> Not sure if this is the same issue you're seeing or not, but I ran in=
to something similar a while ago - when connected from less reliable ne=
tworks, connections (especially rsync or scp) over SSH stalled after a =
short while - interactive sessions worked fine.
>=20
> In my case, the issue was a too pedantic iptables configuration. When=
 communicating with the server from a less reliable network, packets co=
uld arrive out of order. If the server received packets that iptables/c=
onntrack didn't think belonged to the session, my config sent ICMP unre=
achable packets as response (-j REJECT), basically terminating the conn=
ection.
>=20
> I fixed it by adjusting the iptables config to not send ICMP unreacha=
ble for this case. An alternative solution was to set sysctl "net.netfi=
lter.nf_conntrack_tcp_be_liberal =3D 1" - this made the out of order pa=
ckets still be counted as part of the session, not triggering the bad b=
ehaviour of my iptables config.
>=20
> Again, not sure if this is related to your issue or not, but it at le=
ast a similar symptom.
>=20
> // Martin
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
