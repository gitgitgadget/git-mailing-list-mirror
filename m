From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] Prefer $EMAIL over auto-generated user@hostname.
Date: Fri, 06 Jul 2007 10:22:25 -0500
Message-ID: <468E5E31.8040504@nrlssc.navy.mil>
References: <468E59B3.7080007@nrlssc.navy.mil> <20070706151145.GA15341@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	torvalds@linux-foundation.org, gitster@pobox.com,
	mkraai@beckman.com, madcoder@debian.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 06 17:24:36 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6pfX-0005AJ-KH
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 17:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760067AbXGFPYZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 6 Jul 2007 11:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758960AbXGFPYZ
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 11:24:25 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:46754 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758790AbXGFPYY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 11:24:24 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l66FKi2X027456;
	Fri, 6 Jul 2007 10:20:46 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 6 Jul 2007 10:22:26 -0500
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
In-Reply-To: <20070706151145.GA15341@informatik.uni-freiburg.de>
X-OriginalArrivalTime: 06 Jul 2007 15:22:26.0132 (UTC) FILETIME=[75630940:01C7BFE1]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-3.6.0.1039-15280000
X-TM-AS-Result: : Yes--9.039600-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDY3MC03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwMDMyNC03MDA2MTgtNzAxNDYxLTcwMzgyOS03?=
	=?us-ascii?B?MDE3MTctMTg4MDE5LTcwMTU3Ni03MDM3ODgtNzAwMTUzLTcwODI1?=
	=?us-ascii?B?Ny0xNDgwNTEtMjAwNDA=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51765>

Uwe Kleine-K=F6nig wrote:
> Hello Brandon,
>=20
> Brandon Casey wrote:
>>  	struct passwd *pw =3D NULL;
>> +        char *email;
> Indention error. Otherwise it looks good (just from reading the patch=
).

huh. It doesn't look like that in my mail reader.
I have
        struct passwd...
+        char *email;

and the patch applied cleanly when I saved the email and applied it
using git-am

  cat git_email.patch | git-am

-brandon
