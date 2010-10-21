From: "Wilson, Kevin Lee (OpenView Engineer)" <kevin.l.wilson@hp.com>
Subject: GIT as binary repository
Date: Thu, 21 Oct 2010 12:52:46 +0000
Message-ID: <2EBB46ACFCD6CF48B45E2B1865BD02338037D36B4E@GVW1098EXB.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 21 14:54:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8uf4-0000V2-Ou
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 14:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757887Ab0JUMyK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Oct 2010 08:54:10 -0400
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:10925 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755742Ab0JUMyJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Oct 2010 08:54:09 -0400
Received: from G1W0401.americas.hpqcorp.net (g1w0401.americas.hpqcorp.net [16.236.31.6])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by g5t0006.atlanta.hp.com (Postfix) with ESMTPS id EA42EC638
	for <git@vger.kernel.org>; Thu, 21 Oct 2010 12:54:08 +0000 (UTC)
Received: from G3W0629.americas.hpqcorp.net (16.233.58.78) by
 G1W0401.americas.hpqcorp.net (16.236.31.6) with Microsoft SMTP Server (TLS)
 id 8.2.176.0; Thu, 21 Oct 2010 12:52:42 +0000
Received: from GVW1098EXB.americas.hpqcorp.net ([16.234.97.244]) by
 G3W0629.americas.hpqcorp.net ([16.233.58.78]) with mapi; Thu, 21 Oct 2010
 12:52:41 +0000
Thread-Topic: GIT as binary repository
Thread-Index: ActxHtxOu/4/4t+bSZC6D9GFIyhgMA==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-cr-hashedpuzzle: BP0/ BhuZ CnGl DgEm D47K EeO3 FbTK F5wV Go26 HS+6 H2MR
 Icfo JnvV J/Q2 KAql
 KC7J;1;ZwBpAHQAQAB2AGcAZQByAC4AawBlAHIAbgBlAGwALgBvAHIAZwA=;Sosha1_v1;7;{5BE98CA0-077E-4588-B73F-726CD559AFB8};awBlAHYAaQBuAC4AbAAuAHcAaQBsAHMAbwBuAEAAaABwAC4AYwBvAG0A;Thu,
 21 Oct 2010 12:52:46
 GMT;RwBJAFQAIABhAHMAIABiAGkAbgBhAHIAeQAgAHIAZQBwAG8AcwBpAHQAbwByAHkA
x-cr-puzzleid: {5BE98CA0-077E-4588-B73F-726CD559AFB8}
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159499>

Hello,=20

We are investigating the use of GIT as a binary repository solution. Ou=
r larger files are near 800MB and the total checked out repo size is ab=
out 3 GB the repo size in SVN is more like 20-30GB, if we could prune t=
he history prior to MR, we could get these sizes down considerably. Thi=
s binary repo is really for our super project build. =A0From what I hav=
e read and learned, this is not a good fit for the GIT tool. Have there=
 been performance improvements lately? Some of the posts I have read ha=
ve been quite old?

I also have some questions, about how the workflow would be for getting=
 all of the changes merged from several different teams into the one re=
pository would operate. Do we setup a shared system for engineers to pe=
rform the merges onto? Our teams are geographically disbursed.=20

Thanks for any light you can shed on this. We are trying to digest a lo=
t of information quickly, so sorry if there are things covered here tha=
t are elsewhere.

Thanks,
Kevin
