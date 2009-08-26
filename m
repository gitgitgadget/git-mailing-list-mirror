From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
Subject: Re: Linus' sha1 is much faster!
Date: Wed, 26 Aug 2009 12:39:39 +0100
Message-ID: <4A951EFB.1010400@draigBrady.com>
References: <4A85F270.20703@draigBrady.com> <3e8340490908151302y33a97d50t38ad0a8a788f1cee@mail.gmail.com> <43d8ce650908151312o6a43416el27965c4b0ab8d83d@mail.gmail.com> <alpine.LFD.2.01.0908151315400.3162@localhost.localdomain> <alpine.LFD.2.01.0908151336530.3162@localhost.localdomain> <alpine.LFD.2.00.0908162151180.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	John Tapsell <johnflux@gmail.com>,
	Bryan Donlan <bdonlan@gmail.com>, Bug-coreutils@gnu.org,
	Git Mailing List <git@vger.kernel.org>,
	Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Kocher <paul@paulkocher.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Aug 26 13:40:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgGrU-0002i7-4Z
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 13:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756352AbZHZLkH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Aug 2009 07:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754273AbZHZLkG
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 07:40:06 -0400
Received: from mail121.emailantidote.com ([80.169.59.121]:60677 "EHLO
	SC-MTA-02.mxsweep.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754066AbZHZLkF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Aug 2009 07:40:05 -0400
Received: from tombstone.lincor.com ([84.203.137.218]) by SC-MTA-02.mxsweep.com with Microsoft SMTPSVC(7.0.6001.18000);
	 Wed, 26 Aug 2009 12:40:03 +0100
Received: from [192.168.2.25] (crom.labs.lincor.com [192.168.2.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by tombstone.lincor.com (Postfix) with ESMTP id 0BEF9600C208;
	Wed, 26 Aug 2009 12:40:01 +0100 (IST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071008)
In-Reply-To: <alpine.LFD.2.00.0908162151180.6044@xanadu.home>
X-Enigmail-Version: 0.95.0
X-OriginalArrivalTime: 26 Aug 2009 11:40:03.0836 (UTC) FILETIME=[F3CABBC0:01CA2641]
x-MXSweep-CtasdSpam: Unknown
x-MXSweep-CtasdVirus: Unknown
x-Ctasd-RefID: str=0001.0A090202.4A951F15.0005,ss=1,fgs=0
x-MXSweep-KeywordsCount: 0
x-MXSweep-MetaScanResult: Clean
x-MXSweep-MetaScanThreat: 
x-MXSweep-VirusScanned: 26/08/2009 11:40:05
x-MXPurifier-SpamScore: 0
x-MXPurifier-VirusScore: 0
x-MXSweep-Threat: Clean
X-MXUniqueID: 552e4ab1-f751-41ee-b77e-0d95363584aa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127087>

Nicolas Pitre wrote:
> On Sat, 15 Aug 2009, Linus Torvalds wrote:
>=20
>> (Heh. Looking at that, I probably should move the 'size' field first=
,=20
>> since that would have different alignment rules, and the struct woul=
d be=20
>> more tightly packed that way, and initialize better).
>=20
> I was about to suggest (i.e. post) a patch for that.  This is indeed =
a=20
> good idea.
>=20
>> Afaik, none of the actual code remains (the mozilla SHA1 thing did t=
he=20
>> wrong thing for performance even for just the final bytes, and did t=
hose a=20
>> byte at a time etc, so I rewrote even the trivial SHA1_Final parts).
>=20
> Maybe a patch adding a proper header with the actual license would be=
 a=20
> good idea too.

So have you decided on a final licence,
and if so update the headers accordingly?

cheers!
P=E1draig.
