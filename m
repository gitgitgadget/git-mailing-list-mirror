From: Quark <unixuser2000-fbsd@yahoo.com>
Subject: Re: git-svn too slow, contacts upstream svn repo
Date: Tue, 28 May 2013 23:20:59 +0800 (SGT)
Message-ID: <1369754459.53926.YahooMailNeo@web190706.mail.sg3.yahoo.com>
References: <1369668359.69324.YahooMailNeo@web190701.mail.sg3.yahoo.com>
	<1369726977.1915.YahooMailNeo@web190701.mail.sg3.yahoo.com> <20130528155411.beed9d3450d5a9d135cd93e6@domain007.com>
Reply-To: Quark <unixuser2000-fbsd@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Konstantin Khomoutov <kostix+git@007spb.ru>
X-From: git-owner@vger.kernel.org Tue May 28 17:21:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhLi0-0003EF-Vi
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 17:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934474Ab3E1PVD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 May 2013 11:21:03 -0400
Received: from nm4-vm7.bullet.mail.sg3.yahoo.com ([106.10.148.134]:37263 "HELO
	nm4-vm7.bullet.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S933381Ab3E1PVB convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 11:21:01 -0400
Received: from [106.10.166.122] by nm4.bullet.mail.sg3.yahoo.com with NNFMP; 28 May 2013 15:20:59 -0000
Received: from [106.10.151.187] by tm11.bullet.mail.sg3.yahoo.com with NNFMP; 28 May 2013 15:20:59 -0000
Received: from [127.0.0.1] by omp1013.mail.sg3.yahoo.com with NNFMP; 28 May 2013 15:20:59 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 629237.64748.bm@omp1013.mail.sg3.yahoo.com
Received: (qmail 55900 invoked by uid 60001); 28 May 2013 15:20:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1369754459; bh=+bFB5nI4a7ybiu6U2In202el0yYYV7LPVz0Jb3Tuyvo=; h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=omld3sv6pqDkjRGKd5QPAN3/8r4obhC6IOflswiJ4RvRMraRguYllxDHEnSlEhnud7lJvLaAAJr2xtJtXpXVKcA6qbOw0eeCDzH5i/EYNFCy77CG380q+LO+ViU1Xx0bNLPsagJC1HdxRnjtT23lSJGPJbSDAgYPz7YOImiUFdw=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ygC5MnJEBgU8nkCJYgnC6tX1AhduO4njqgr4zkvEzBKevBqqi8tnOW+cOV1dJwl+AGTbA2zbxaWagbOHzicO75hl99mUZCcTlVciVWysM+TENNBkPr6UAXLQJbTlKyyMYmQf/dlmvwUra6iMyvqO8rxKueRFNqLlqJErT1KnjnE=;
X-YMail-OSG: H14CsAUVM1mL9VqyGpys.Zm4WseHgR4Agpvb.YuG.AHubT2
 bG1fzma4.u16MPS1H0prlqwfPCMjBxUDr89aZAK6pf6_xwV3TwE3l3O.7mqX
 pdFx81CrWqM6z_BMH6U8.HEPlZFZ9XZvhVg4t6xSSkO0OVRy_5aeI0T4ftf_
 _icsSZ0rbzXDAk8owGIzTZ3rZ53kgRZWZqQsYu0rMzO1VCooeTiG32gZ3tMj
 Xrf7GYZFMoqhiVzzEAZmAU8BR5StSX5v1i65JPsDjw74P9794Z3kUPpJ4nve
 L4c3msoGCXS8V6afWhxRnQ4sagDiNEhnJ5qRUQICUQBrWqD6CE_Hkz2cDa4J
 aZ_.nauzhkP8opJ2Z6EH6Ssh0rb05o2thWpqwmEYKAUBnUzujB_hMK7XHp__
 NB7.QmG9i4q71_B43tXt34cB_92pRUVuDoVxU9cKCgZoeNa686PXwOHVJ7tG
 5yE3bgY6U03O1KEfFzGpNKwnt34znfU.D46Y6WVH154o1eLiE8y36u.4-
Received: from [103.245.47.20] by web190706.mail.sg3.yahoo.com via HTTP; Tue, 28 May 2013 23:20:59 SGT
X-Rocket-MIMEInfo: 002.001,CgoKCi0tLS0tIE9yaWdpbmFsIE1lc3NhZ2UgLS0tLS0KPiBGcm9tOiBLb25zdGFudGluIEtob21vdXRvdiA8a29zdGl4K2dpdEAwMDdzcGIucnU.Cj4gVG86IFF1YXJrIDx1bml4dXNlcjIwMDAtZmJzZEB5YWhvby5jb20.Cj4gQ2M6IEdpdCBMaXN0IDxnaXRAdmdlci5rZXJuZWwub3JnPgo.IFNlbnQ6IFR1ZXNkYXksIDI4IE1heSAyMDEzIDU6MjQgUE0KPiBTdWJqZWN0OiBSZTogZ2l0LXN2biB0b28gc2xvdywgY29udGFjdHMgdXBzdHJlYW0gc3ZuIHJlcG8KPiAKPiBPbiBUdWUsIDI4IE1heSAyMDEzIDE1OjQBMAEBAQE-
X-Mailer: YahooMailWebService/0.8.144.546
In-Reply-To: <20130528155411.beed9d3450d5a9d135cd93e6@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225657>





----- Original Message -----
> From: Konstantin Khomoutov <kostix+git@007spb.ru>
> To: Quark <unixuser2000-fbsd@yahoo.com>
> Cc: Git List <git@vger.kernel.org>
> Sent: Tuesday, 28 May 2013 5:24 PM
> Subject: Re: git-svn too slow, contacts upstream svn repo
>=20
> On Tue, 28 May 2013 15:42:57 +0800 (SGT)
> Quark <unixuser2000-fbsd@yahoo.com> wrote:
>=20
>>  > I have been using git-svn in an corporate environment where svn
>>  > repo has lot of branches, (lot means > 100). To avoid cloning all
>>  > branches my config looks as below
> [...]
>>  is this not right forum?
>=20
> As a matter of fact, this mailing list is the only correct place to a=
sk
> questions like yours.=A0 But this is free software after all -- peopl=
e
> who could answer your question may be busy/absent at the moment or ev=
en
> not involved in the project anymore (in the worst case).=A0 So be
> prepared to wait some time.=A0 Also be prepared for your particular
> trouble not being solved.
>=20
> In the meantime, I think Thomas provided you with valuable suggestion=
s
> in reply to your mirror post on git-users, so you could possibly
> explore them.
>

I was impatient not because feeling-of-entitlement, but I thought it mi=
ght get lost in pile of e-mails
Secondly was not sure if this is right forum, I might be making noise a=
fter all, thanks for your clarification.
Now will you please excuse, I have to check Thomas's suggestions? :)
