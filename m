From: Jens Hausherr <Jens.Hausherr@xing.com>
Subject: Deletion of remote branches
Date: Mon, 1 Oct 2012 13:22:44 +0000
Message-ID: <CC8F65C7.E79%jens.hausherr@xing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 01 15:23:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIfxZ-00034O-PV
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 15:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443Ab2JANWr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Oct 2012 09:22:47 -0400
Received: from mx1-3.xing.com ([109.233.152.98]:36006 "EHLO mx1-3.xing.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753076Ab2JANWq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Oct 2012 09:22:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx1-3.xing.com (Postfix) with ESMTP id ADA0D200442CE
	for <git@vger.kernel.org>; Mon,  1 Oct 2012 15:22:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xing.com; h=
	mime-version:content-transfer-encoding:content-id:content-type
	:content-type:user-agent:content-language:accept-language
	:message-id:date:date:subject:subject:from:from:received
	:received:received; s=main; t=1349097765; bh=yAODP6ytR1BhTKOxj7x
	ZVpBCoLT3lCzp8XdZB37VnI8=; b=t7h8ENjMjs5mYY2sbcQhd4wB3mWDvDDDpuj
	FCMvnVda1dnC2HAFFXN3BJqg6GC1Cm5OzskBaN3ba3laYrxVZSyBwqMTTaEXLoqp
	6rN9GCzUqaarOj702j1IlYnODQOSbIkLCTowfuv9nCGLG707jAE8E6g/EAUkxxtP
	OqDP12bI=
X-Virus-Scanned: Debian amavisd-new at mx1-3.mail.fra1.xing.com
Received: from mx1-3.xing.com ([127.0.0.1])
	by localhost (mx1-3.mail.fra1.xing.com [127.0.0.1]) (amavisd-new, port 10030)
	with ESMTP id R+7F7BJtr4Sk for <git@vger.kernel.org>;
	Mon,  1 Oct 2012 15:22:45 +0200 (CEST)
Received: from XING-EXCHSVR01.xing.hh (unknown [172.20.1.16])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mx1-3.xing.com (Postfix) with ESMTPS id 945AC200442B0
	for <git@vger.kernel.org>; Mon,  1 Oct 2012 15:22:45 +0200 (CEST)
Received: from XING-EXCHSVR02.xing.hh ([fe80::c94c:f7e0:c93d:de5f]) by
 XING-EXCHSVR01.xing.hh ([fe80::4110:9584:97c1:27a9%22]) with mapi id
 14.02.0298.004; Mon, 1 Oct 2012 15:22:45 +0200
Thread-Topic: Deletion of remote branches
Thread-Index: AQHNn9fX2dpkrvRfQk201KJe1aLYKw==
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.2.4.120824
x-originating-ip: [172.29.0.21]
Content-ID: <98623C26CE26954AB01A9F4B465DAE07@xing.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206732>

Hi,

I came across an issue with deleting remote branches: When deleting a
branch using "git branch =ADr =ADd <branch>" the branch is deleted and =
no
longer shown by "git branch =ADr".

"git ls-remote --heads" on the other hand still lists the ref for the l=
ast
branch commit.

If I delete the branch using "git push origin :<branch>" the branch is
removed completely (i.e. git ls-remote  no longer returns a ref).

Is this a bug or is this behavior intentional? (I am currently using gi=
t
1.7.12).

Cheers,
Jens

--=20
Jens Hausherr
Senior Software Engineer QA
jens.hausherr@xing.com
=20
XING AG
Gaensemarkt 43, 20354 Hamburg, Germany

Tel. +49 40 419131-634, Fax +49 40 419131-11
=20

Commercial Reg. (Registergericht): Amtsgericht Hamburg, HRB 98807
Exec. Board (Vorstand): Dr. Stefan Gro=DF-Selbeck (Vorsitzender), Dr. T=
homas
Vollmoeller, Ingo Chu, Dr. Helmut Becker, Jens Pape
Chairman of the Supervisory Board (Aufsichtsratsvorsitzender): Dr. Neil
Sunderland
=20

Please join my network on XING
<https://www.xing.com/go/invite/3287358.18c191>

This e-mail may contain confidential and/or privileged information. If =
you
are not the intended recipient (or have received this e-mail in error)
please notify the sender immediately and destroy this e-mail. Any
unauthorised copying, disclosure or distribution of the material in thi=
s
e-mail is strictly forbidden and may be unlawful.
