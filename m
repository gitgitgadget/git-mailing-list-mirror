From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: Re: differences between old clone and new  Re: git-svn performance
Date: Thu, 30 Oct 2014 00:55:50 +0000
Message-ID: <1414630550.65737.YahooMailBasic@web172303.mail.ir2.yahoo.com>
References: <20141030002136.GA31920@dcvr.yhbt.net>
Reply-To: htl10@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Oct 30 01:55:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xje1t-0002g6-3W
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 01:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758059AbaJ3Azx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Oct 2014 20:55:53 -0400
Received: from nm37-vm9.bullet.mail.ir2.yahoo.com ([212.82.97.150]:39119 "EHLO
	nm37-vm9.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757300AbaJ3Azw convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2014 20:55:52 -0400
Received: from [212.82.98.126] by nm37.bullet.mail.ir2.yahoo.com with NNFMP; 30 Oct 2014 00:55:50 -0000
Received: from [212.82.98.113] by tm19.bullet.mail.ir2.yahoo.com with NNFMP; 30 Oct 2014 00:55:50 -0000
Received: from [127.0.0.1] by omp1050.mail.ir2.yahoo.com with NNFMP; 30 Oct 2014 00:55:50 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 759106.83792.bm@omp1050.mail.ir2.yahoo.com
Received: (qmail 44841 invoked by uid 60001); 30 Oct 2014 00:55:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1414630550; bh=fV5RpdciwuEMZqBY3W6ZQHMRvLikAyZwNQfDpKUx58A=; h=Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=w9uILZUME+I08DbbG+mCL7tyxzWMJ03SW32Byy55xEHbgy+g64rSQ88f20o3xCpQbTLwnroVFw+q0MVOxnDKYIm0bzM1riy1pZIG5fy/u96bTIdXgfVCbFZ7aqtOWSDK7aaV1HETWkCIEXbEuZxqX4DIJh4te+OkM1oqnkZavnE=
X-YMail-OSG: 6Ums6_kVM1ntgkXGUMHAAlYAkmmsxCdRbVXYrFgsCqXefpF
 aNBeduja54HeILR3VAtrn.KvTSEI44kWdI_9rE4p77zBPlm.FHez63urUOL7
 6sbJ8YkJtri_nItQjYp1e4lDOBupFwhDUBC0fOu0p24F79sMipC8zCAfXhgq
 tgjEt4OLdjvoNbr9PY7dcQwkrjWcnr24PWXKiFZTrUFSTb4c6Y3LM7aBivXO
 3MI_lzQCWDCXQasuDKS6gHZZPL1DiUdrG_.GDw11IAWZZVGJIOTOmwn1QQHI
 wdCU5GIoEuztcJvjZxef5YgzCcnDy7_OizF9CWaCOvPpcrceQ7kZCnZV842R
 mELld0q7JLxFhrYy3te2BKkV20aspfXgDtIXuB0XGl9v93NyFFw6MdTm0ceE
 XMCE5K_3J3azcxVVLL9ZfJnAr_Ddfqrpjlq0FDhtDx.jPQNjPSz6BaIKk0DK
 GU2DmRmD__CN0xo.tyyxXV117XKiZqTF4o_JXIJnkPjz_RgI5UW59E51J_Q6
 3zwBKd.0dw3PwzuF4q0FjWUQMRdYAx22LKYqaPN4zQ0A_dlTrT8HPeB9wom6
 d7AKdMfTGAT9X5NQgn7Ljuxu_Gfn91F_ql0c6OTPiiqrrZwcv9Zlv6tIO.3A
 6eRhmOzgEPDnKz8AWCkUGvtmaA_xPo6v8M44Xf5PCsA_Z51WJTwWW
Received: from [86.30.137.134] by web172303.mail.ir2.yahoo.com via HTTP; Thu, 30 Oct 2014 00:55:50 GMT
X-Rocket-MIMEInfo: 002.001,LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCk9uIFRodSwgMzAvMTAvMTQsIEVyaWMgV29uZyA8bm9ybWFscGVyc29uQHloYnQubmV0PiB3cm90ZToNCg0KID4gVGhlIG1pc3NpbmcgbWVyZ2Ugb24gYnJhbmNoDQogIlItMi0xNC1icmFuY2giIGlzOg0KID4gDQogPiBjb21taXQNCiA5M2FmNGQ0Y2MzYTVlMDAzOTk0NGRkNGUzNDBkMjY5OTViZThhMjUyDQogPiBNZXJnZTogMTIxOTkwZiA2ZmYxYjg3DQogPiBBdXRob3I6IHJpcGxleSA8cmlwbGV5QDAwZGI0NmIzLTY4ZGYtMDMBMAEBAQE-
X-RocketYMMF: hintak_leung
X-Mailer: YahooMailClassic/810 YahooMailWebService/0.8.203.733
In-Reply-To: <20141030002136.GA31920@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--------------------------------------------
On Thu, 30/10/14, Eric Wong <normalperson@yhbt.net> wrote:

 > The missing merge on branch
 "R-2-14-branch" is:
 >=20
 > commit
 93af4d4cc3a5e0039944dd4e340d26995be8a252
 > Merge: 121990f 6ff1b87
 > Author: ripley <ripley@00db46b3-68df-0310-9c12-caf00c1e9a41>
 > Date:=A0=A0=A0Wed Feb 22 13:45:34
 2012 +0000
 >=20
 >=A0
 =A0=A0=A0port r58453 from trunk
 >
=20
 >=A0 =A0=A0=A0git-svn-id: https://svn.r-project.org/R/branches/R-2-14-=
branch@58454
 00db46b3-68df-0310-9c12-caf00c1e9a41
=20
> I'm curious if you can tell me which
 version of git-svn you used to get
 that as a
 merge commit.=A0 git-svn mergeinfo handling has changed
 (hopefully improved) over the years, so some
 differences in history
 can be
 (unfortunately) expected, I think.

That's quite straight-forward, I think  - except for the recent burst (=
I am essentially
adapting the git 2.1.0 release shipped by the upcoming fedora 21 schedu=
led for christmas)
I tend to update to the latest fedora release about a week or two after=
 release;
fedora 17 was shipped in May 2012 and only just enter Alpha in 22 Feb 2=
012.
and I tracked R at least as frequently as weekly around then;
So I would be using what ever version of git was shipping with fedora 1=
6 around late
=46eb 2012.

On fedora's build farm, git-1.7.7.5 was bult in dec 2011 and git-1.7.7.=
6 was built
on 2012-01-19 . Depending on how soon
1.7.7.6 filtered down to update, and when I update my git and also trac=
ked R,
(all three of these events probably happened around 22 Feb), I could be
using either 1.7.7.5 or 1.7.7.6. I still have the system software updat=
e log around
(the repo was cloned on a now-dead system, then moved over when it died=
),
and presumably I can get git log to show me the fetch date (?), I might
be able to tell whether it is 17.7.5 or 1.7.7.6 if you really want to k=
now.
