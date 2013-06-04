From: Gianfranco Costamagna <costamagnagianfranco@yahoo.it>
Subject: I: git archive --worktree-attributes doesn't exclude .gitattributes anymore
Date: Tue, 4 Jun 2013 23:24:26 +0100 (BST)
Message-ID: <1370384666.57411.YahooMailNeo@web172701.mail.ir2.yahoo.com>
References: <1370384339.31882.YahooMailNeo@web172702.mail.ir2.yahoo.com>
Reply-To: Gianfranco Costamagna <costamagnagianfranco@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 05 00:31:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujzl2-0007bS-SP
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 00:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136Ab3FDWbI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jun 2013 18:31:08 -0400
Received: from nm16-vm1.bullet.mail.ird.yahoo.com ([77.238.189.88]:29143 "EHLO
	nm16-vm1.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751112Ab3FDWbH convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 4 Jun 2013 18:31:07 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jun 2013 18:31:07 EDT
Received: from [77.238.189.57] by nm16.bullet.mail.ird.yahoo.com with NNFMP; 04 Jun 2013 22:24:26 -0000
Received: from [212.82.98.79] by tm10.bullet.mail.ird.yahoo.com with NNFMP; 04 Jun 2013 22:24:26 -0000
Received: from [127.0.0.1] by omp1016.mail.ir2.yahoo.com with NNFMP; 04 Jun 2013 22:24:26 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 793406.48426.bm@omp1016.mail.ir2.yahoo.com
Received: (qmail 73904 invoked by uid 60001); 4 Jun 2013 22:24:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.it; s=s1024; t=1370384666; bh=eTGeKTc25vidx+AnLndLpDe6zuazvHp4u27UeDWxDsg=; h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=AmqYThDqnLAk4w0NQVAGT8HFSqGfMoOqSsQO5xIK9/+2GE99lb3sBDEyE/PDH2GX0NIh5TGizUtqLr0cDKlzwFFGiPiPqdV7h0bdwztmCKv0+8F7NqYRVwuZkXOk9Ja2Wk0mglLHUCA0WVqN3nkdYTw6v/Tw7QgVah3kiYPqWws=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=wWpcSQ7SDfZozpk6W6DX+gGS6nZMEplTqZvWYIKjDXLkg/6zYG53ONm+a4zgomRfNd2pmMcNy9MSP+gRjZP+oqBKwihcx1LAZQY/hsku9fX9lf7WKvxp94lEo+2JIS1p1DZRNmRbLlzo3d8pnXxariNfYl4zBJ9VmdeqX7wm+Qk=;
X-YMail-OSG: IEJyymwVM1nZ_ptf7jvrZh0Q._Rea.yt8n4kptjsBsz2TFU
 vp7zh77xRh22OtgEOxTtf7GesgGgfJ_QlqsSdHTkwMqjFK2c9BqLrU8UdBkg
 mnHhBjtH._aF5FXRcF8QANkW7q7ZJ__FE.oyVTb90bQbgzFQx4zmr3s5l5N3
 tvMfG2MgNYLRFR3yG12MUKhnvFYQsfIL2IF0Tq9Qq20ovk_ufQKStoMbgxGD
 dBG2wL0RT04EeKj85b8Y882bj1hKc2wWlCDwmvX503XOyWWY2kgiO7KY.qDG
 VTmCpQYhph45fcK6MV64iuWuPhzJDRIRReUtRgRuaJcj6O.axB3zXS2.Rmz8
 5v_CKsP4QdAuW2pZrq0iZ.6lmIAZZZq._eyExQsPK6ZuW8FVwnpuKOj3o3XN
 iapk4JmhmfLPXtpOl13XaMek46Jr2pjni_ciS67KysB2hlCRG5bY4KBIJ10g
 6dNPhQ1bbx5nYFeKmvZGTu_QPXBeynn_efkktaRERxnwU7Gjhw4YgaI1qOiC
 LowbmPAUDcv4gy3tOkCZqSLpVCdgD5ulYjB.pXQzk5dFkoq_edKV1YwTLs_j
 B51paQMSiIj6_m_pOI8GD3dVAQebpjSb0mTuJHGkqo03.1Jq8zEeejqrRlcg
 iXxsBLsQ.J00TAateXkOgWPgxZuglyI_774Gy8uildWk0U5fQefIqoACum_g
 VV1mrq3W0flZfRIzi7w--
Received: from [151.18.140.52] by web172701.mail.ir2.yahoo.com via HTTP; Tue, 04 Jun 2013 23:24:26 BST
X-Rocket-MIMEInfo: 002.001,Rm9yZ290IHRvIG1lbnRpb24sIGFsc28gdGhpcyBjb21tYW5kIGRvZXNuJ3Qgd29yawoKCmdpdCBhcmNoaXZlIC0td29ya3RyZWUtYXR0cmlidXRlc8KgIC12IC0tZm9ybWF0IHRneiAtbyAuLi9ib2luY183LjEuNytkZnNnLm9yaWcudGFyLmd6IC05IC0tcHJlZml4IGJvaW5jLTcuMS43K2Rmc2cvIGNsaWVudF9yZWxlYXNlLzcuMS83LjEuNwoKCkdpYW5mcmFuY28KCgoKLS0tLS0gTWVzc2FnZ2lvIGlub2x0cmF0byAtLS0tLQo.IERhOiBHaWFuZnJhbmNvIENvc3RhbWFnbmEgPGNvc3RhbWFnbmFnaWFuZnJhbmMBMAEBAQE-
X-Mailer: YahooMailWebService/0.8.145.547
In-Reply-To: <1370384339.31882.YahooMailNeo@web172702.mail.ir2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226420>

=46orgot to mention, also this command doesn't work


git archive --worktree-attributes=A0 -v --format tgz -o ../boinc_7.1.7+=
dfsg.orig.tar.gz -9 --prefix boinc-7.1.7+dfsg/ client_release/7.1/7.1.7


Gianfranco



----- Messaggio inoltrato -----
> Da: Gianfranco Costamagna <costamagnagianfranco@yahoo.it>
> A: "git@vger.kernel.org" <git@vger.kernel.org>
> Cc:=20
> Inviato: Mercoled=EC 5 Giugno 2013 0:18
> Oggetto: git archive --worktree-attributes doesn't exclude .gitattrib=
utes anymore
>=20
>g it version 1.8.1.2
> (please cc me, I'm not subscribed to this list)
>=20
>=20
> Hi Developers, I write here because since my ubuntu update (quantal t=
o raring)
> and git update from 1.7.10.4-1ubuntu1 to 1.8.1.2
>=20
> my export script doesn't work anymore.
>=20
> I tried to put .gitattributes or .git/info/attributes, the file is th=
e following
> http://pastebin.com/irngA1L8
>=20
> the git is
> git clone http://boinc.berkeley.edu/git/boinc-v2.git
>=20
> and the command is
>=20
> git archive --prefix boinc-7.1.7+dfsg/ --format tgz -o=20
> ../boinc_7.1.7+dfsg.orig.tar.gz -9=A0 client_release/7.1/7.1.7
>=20
> The archive gets created, but every file is inside, no exclusions at =
all.
>=20
> I suspect a regression between git 1.7 and 1.8
>=20
> thanks for your time
>=20
>=20
> Gianfranco
>=20
