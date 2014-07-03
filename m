From: Scott McKellar <mck9@swbell.net>
Subject: Support for EBCDIC
Date: Wed, 2 Jul 2014 19:39:12 -0700
Message-ID: <1404355152.86116.YahooMailNeo@web184805.mail.gq1.yahoo.com>
Reply-To: Scott McKellar <mck9@swbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org   " <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 03 04:45:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2X1s-00021W-Gg
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jul 2014 04:45:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754430AbaGCCpk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jul 2014 22:45:40 -0400
Received: from nm16-vm6.access.bullet.mail.gq1.yahoo.com ([216.39.63.164]:33389
	"EHLO nm16-vm6.access.bullet.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754004AbaGCCpj convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 2 Jul 2014 22:45:39 -0400
X-Greylist: delayed 387 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Jul 2014 22:45:39 EDT
Received: from [216.39.60.167] by nm16.access.bullet.mail.gq1.yahoo.com with NNFMP; 03 Jul 2014 02:39:12 -0000
Received: from [216.39.60.234] by tm3.access.bullet.mail.gq1.yahoo.com with NNFMP; 03 Jul 2014 02:39:12 -0000
Received: from [127.0.0.1] by omp1005.access.mail.gq1.yahoo.com with NNFMP; 03 Jul 2014 02:39:12 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 321149.18590.bm@omp1005.access.mail.gq1.yahoo.com
Received: (qmail 32171 invoked by uid 60001); 3 Jul 2014 02:39:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swbell.net; s=s1024; t=1404355152; bh=xN/V2LD8tWedcaNIfrl8daFLJf0my6eVqLEGhl6tr28=; h=Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=1it4lb8LquQ4eaagJfdaSqa27RwyRm4GXBNgDjv7Qpqa5Qf7AF6a4JpfuY6zoJq6mtqtgfsYYFwuJsSL5YfoLmblbZ5yb6sSTBVZ/jrSqS+7Nbd4jI7yodWrvM4iYzcHqBy+Z50qtn26/gE4Bwf1aqUrzF/5lwiJbq9xCeEJ42Y=
X-YMail-OSG: hlMD0JIVM1ljZUpZUauuO4wgfbtk_Rgmd6mhG8MjyqJrvem
 jDPefvREqEJni84uDuabIMqunXj.c9D_61NNbEguwfxq5aQVkMLQ2fk5WQmZ
 pm6s6CjEL4Weqi6TmKN6OCKfI2.DXga5pnF6EQFUYIDaDCjZiQK4Y1n2Q5xG
 3XCZZb.hxnbpj.4UuOckFFYckJsAiHMf6xYQs4QDgeiO.S3YZVv6e97qPhFy
 RnAgbzqYvtI93s4zhIUbEDPg581IZ3M97ofcNtstLvaXd.PF4FtRXlsZdzMD
 BZDR64_dWyFV_MRDl.ifP_QMRR_ConONV8PMnsgCNxoeSDKXNfj0kaOwtr2o
 z6uYS6hbSchOrJX7xqy6kYXW68PUmkZQvgYBU4h2HLD9KYaKQeqQZOv0bhJE
 jqi9eLid5vXS8J1.wbLgXHPdErv0Qabe5hEKSpZImW9sGMg6uIn16kHRiTRh
 GNMKx.ifmDS8zWsSkqnttmjRehvngOEg4uf8wEq7R066FbhNt2YNLPw98KK5
 c5dvSOwisxZSXkE8_zWGje4E6xke3XPMHyhSoPWogIZ6ZE9hBXzryc_c2IQ.
 eM5yeskIBKv0kdHndO5EOz1ItApFH.2dY7ryMqW4cMQtdzLpwKX103gJu_Jc
 sOJodcdeRQ2NrLPLQEPqM8_jAXm4DGnm6wEgHs7825rNapw--
Received: from [99.20.100.156] by web184805.mail.gq1.yahoo.com via HTTP; Wed, 02 Jul 2014 19:39:12 PDT
X-Rocket-MIMEInfo: 002.001,SXMgR2l0IHN1cHBvc2VkIHRvIGJlIHVzYWJsZSBpbiBhbiBlbnZpcm9ubWVudCB3aGVyZSB0aGUgZXhlY3V0aW9uIGNoYXJhY3RlciBzZXQgaXMgRUJDRElDPwoKSSBhc2sgYmVjYXVzZSwgaW4gYnJvd3NpbmcgdGhlIHNvdXJjZSBjb2RlICh2ZXJzaW9uIDIuMC4wKSwgSSBzdHVtYmxlZCBhY3Jvc3MgdGhyZWUgZnVuY3Rpb25zIAoKdGhhdCB3b24ndCB3b3JrIGFzIHByZXN1bWFibHkgaW50ZW5kZWQgaW4gYW4gRUJDRElDIGVudmlyb25tZW50IChzdHJpaGFzaCgpLCBtZW1paGFzaCgpLCBhbmQgCgpnaXRfdXMBMAEBAQE-
X-Mailer: YahooMailWebService/0.8.191.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252852>

Is Git supposed to be usable in an environment where the execution char=
acter set is EBCDIC?

I ask because, in browsing the source code (version 2.0.0), I stumbled =
across three functions=20

that won't work as presumably intended in an EBCDIC environment (striha=
sh(), memihash(), and=20

git_user_agent_sanitized()).=A0 I can report them as bugs, but if EBCDI=
C is considered out of=20

scope, then they aren't bugs.

These three functions can be readily fixed to make them portable across=
 character sets.=A0 There may be other spots that are harder to fix.

I have done a lot of grepping and Googling, but I haven't found a clear=
, authoritative answer=20

to this question.=A0 From searching this mailing list, it appears that =
nobody is interested in=20

supporting EBCDIC.=A0 However I found one wiki page describing how to r=
un Git on an IBM i, which=20

is an EBCDIC-based successor to the AS/400 series.=A0 See:

=A0=A0=A0 http://wsip-174-79-32-155.ph.ph.cox.net/wiki/index.php/PASE/G=
it

That installation was reportedly running version 1.7.9.4, which I belie=
ve predates the=20

introduction of strihash() and memihash(); I don't know about git_user_=
agent_sanitized().

Mind you, I'm not advocating for EBCDIC.=A0 I escaped from the EBCDIC w=
orld about fifteen years=20

ago, and have no desire to return.=A0 I just want to know if character =
set issues are worth=20

reporting.=A0 The same issues may arise for other, more obscure charact=
er sets.


Scott McKellar
