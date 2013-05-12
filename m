From: Jason Timrod <jtimrod@yahoo.com>
Subject: Mapping file contents from one repository to another
Date: Sun, 12 May 2013 08:22:00 -0700 (PDT)
Message-ID: <1368372120.73994.YahooMailNeo@web160305.mail.bf1.yahoo.com>
Reply-To: Jason Timrod <jtimrod@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 12 17:27:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbYBj-0007Cn-Tl
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 17:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753878Ab3ELP1r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 May 2013 11:27:47 -0400
Received: from nm11-vm0.bullet.mail.bf1.yahoo.com ([98.139.213.136]:34057 "HELO
	nm11-vm0.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753555Ab3ELP1q convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 11:27:46 -0400
X-Greylist: delayed 345 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 May 2013 11:27:46 EDT
Received: from [98.139.214.32] by nm11.bullet.mail.bf1.yahoo.com with NNFMP; 12 May 2013 15:22:01 -0000
Received: from [98.139.215.253] by tm15.bullet.mail.bf1.yahoo.com with NNFMP; 12 May 2013 15:22:01 -0000
Received: from [127.0.0.1] by omp1066.mail.bf1.yahoo.com with NNFMP; 12 May 2013 15:22:01 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 145975.71342.bm@omp1066.mail.bf1.yahoo.com
Received: (qmail 75550 invoked by uid 60001); 12 May 2013 15:22:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1368372120; bh=AMzgEWrc3BK5yL0CeNvMRqnT9wIMMtYwdfZSRoenimg=; h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=vOQ9AyJJ2DWTjuCG9GOMn87fnkNu4aDYTSOUbEJBwSR5JVja5yxTP3aIB0zSyOGqTsDc963pnnggc55zIHBVSpqRYyYgYtInf6GvZtLrETmmnsL5mx3CHToHztI6Ff9MRXjIyp0Ww1PfDBs87Rx8u0MSLw5xaIp+VgNv0OOdohw=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=PgyPqpB5NwfD3bF3AaH+eBXc7G0jRU/D3CJnrKf4WjxJeoVzl7iX1ExrjBi1hpdZUW55ehpmFWOEsU40nO3fxmmSLcg73iXCa+PbDPGfExlB7ygdS073aMRjVEUvQQUQMwiq62zYYTkf/SVlBcZ4MtVriZ2/NyQOpG4dzWuIrRk=;
X-YMail-OSG: bhwhTmoVM1l53N.HM.Gk510.ppzNCBnbA7_V81DNdpTXI4n
 lP6miQZmfb0m.ocCIzqKD5B_eSO1QchgCDC28AEB6yzldFimdeWTyt2Y4KdX
 kt9ukjl4WShDJYe44zqcNHCLfdXwNnqPsmzbdbeFI6j97Wl.CyY9bKpk7zBh
 qP1Af8N48Mhu1YzsiV9qTHJYvaHTJjI01qp1CSYF98GxRjHdPhYvTBlm3_CL
 5r15o2fptKd56BXE3NvVeiZ1nEt1t0KkzNZ46kmvFfqUyO_JFqDSzE5K0_mw
 X_RxuKQ57b_hrziBaLJnwhB71puWEtjbUmeta31JHQSeZTlOiudHh8m5TVc4
 GeyTsiREE60ZofJFTSH4Us4VItT9GKmISC_usdCHRfX6DjRXNbcGI1i_pY51
 k9VOaNCes6FgmB2AUHc36Oysdu3cviKoM6onbrUhf7vcqM0po7umUmClLmn7
 NaYaOAlPczHlOWsyEOl7QInmOgi07isyMUN7.diiqWldb1t2uLV.I4qXoWQ-
 -
Received: from [82.18.155.27] by web160305.mail.bf1.yahoo.com via HTTP; Sun, 12 May 2013 08:22:00 PDT
X-Rocket-MIMEInfo: 002.001,SGkgYWxsLAoKVGhpcyBpcyBhIGNvbXBsaWNhdGVkIHF1ZXN0aW9uIHRvIHRyeSBhbmQgYXNrLCBsZXQgYWxvbmUgYW5zd2VyLCBzbyBJIGhhZCBiZXN0IGdpdmUgc29tZSBiYWNrZ3JvdW5kLgoKSSBoYXZlIHR3byByZXBvc2l0b3JpZXMgLS0tIG9uZSBvZiB0aGVtLCB3aGljaCBJJ2xsIGNhbGwgInJlcG9BIiwgaXMgdGhlIG1haW4gcmVwb3NpdG9yeSwgaXQncyB0aGUgb25lIHdoaWNoIG1vc3Qgb2YgdGhlIGNvZGUgd2UgZGV2ZWxvcCBlbmRzIHVwLiDCoFRoZSBvdGhlciByZXBvc2l0b3J5LCAicmVwb0IiIGkBMAEBAQE-
X-Mailer: YahooMailWebService/0.8.141.536
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224047>

Hi all,

This is a complicated question to try and ask, let alone answer, so I h=
ad best give some background.

I have two repositories --- one of them, which I'll call "repoA", is th=
e main repository, it's the one which most of the code we develop ends =
up. =A0The other repository, "repoB" is our portable version of the cod=
e---the one which is used to deploy on systems other than the one which=
 repoA is deployed on. =A0As such, "repoB" often (and does) contain com=
mits specific to repoB which will never appear in repoA, such as OS-spe=
cific things.

In this case, in repoA we have a man page. =A0Up until recently, this u=
sed to be the same file in both repositories. =A0But because of the way=
 the files in repoB are deployed, unlike in repoA this file has had its=
 name changed from:

foo.1 -> foo.1.in

Because the man page is run through some sed script to replace various =
things which never need to happen in repoA

Now, as you might guess, foo.1 in repoA doesn't change. =A0When I merge=
 in changes from repoA to repoB, there is no way for the repositories t=
o know that repoA:foo.1 is really repoB:foo.1.in -- which means a new f=
ile is created every time.

I appreciate I could just rename foo.1.in back to foo.1 in repoB, but t=
his would cause some ambiguity with users who try to run the file throu=
gh "man", because the tradition of .in files is well-understood.

So short of renaming the file in repoB back to foo.1, my question is th=
is: =A0when merging repoA to repoB, can I somehow map the file contents=
 from foo.1 to be foo.1.in in repoB?

Kindly,

Jason
