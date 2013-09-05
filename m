From: =?iso-8859-1?Q?J=F8rgen_Edelbo?= <jed@napatech.com>
Subject: RE: [PATCH] git-gui: Modify push dialog to support Gerrit review
Date: Thu, 5 Sep 2013 08:29:18 +0000
Message-ID: <F8C23E99F5C6884EB99E2A1966D743637F3619A6@cph-gen-exch01.napatech.com>
References: <20130904150853.52EC4121B7E@jed-dev-01.labnet>
 <522827CE.5040303@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"spearce@spearce.org" <spearce@spearce.org>,
	"hvoigt@hvoigt.net" <hvoigt@hvoigt.net>,
	Pat Thoyts <patthoyts@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Sep 05 10:39:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHV65-0008Jk-8k
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 10:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763501Ab3IEIjT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Sep 2013 04:39:19 -0400
Received: from mail01.napatech.com ([188.120.77.121]:41487 "EHLO
	mail01.napatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763496Ab3IEIjQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Sep 2013 04:39:16 -0400
X-Greylist: delayed 595 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Sep 2013 04:39:16 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqEEACdAKFIK8AFC/2dsb2JhbABbhA3BRoE8dIIkAQEBAQN5DAQCAQgOAwQBAQsdBzIUCQgCBA4FCMIiF48vMQcGgxeBAAOIfaN+gio
X-IPAS-Result: AqEEACdAKFIK8AFC/2dsb2JhbABbhA3BRoE8dIIkAQEBAQN5DAQCAQgOAwQBAQsdBzIUCQgCBA4FCMIiF48vMQcGgxeBAAOIfaN+gio
Received: from CPH-GEN-EXCH01.napatech.com ([fe80::8914:d366:9916:d557]) by
 cph-gen-exch01.napatech.com ([fe80::8914:d366:9916:d557%11]) with mapi id
 14.01.0438.000; Thu, 5 Sep 2013 10:29:18 +0200
Thread-Topic: [PATCH] git-gui: Modify push dialog to support Gerrit review
Thread-Index: AQHOqYCr60IA2iFMmkuxOgaQ77X075m2kZ0AgAA95pA=
In-Reply-To: <522827CE.5040303@viscovery.net>
Accept-Language: en-US, da-DK
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.240.10.71]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233941>

Hi,

I am not quite sure what your concern is.

Anyway - I don't think you are any more restricted with this change tha=
n before. If you currently work on a topic branch, and the same branch =
exists on the chosen remote, then this branch will be the default one t=
o push to.=20

BR J=F8rgen Edelbo

-----Original Message-----
=46rom: Johannes Sixt [mailto:j.sixt@viscovery.net]=20
Sent: 5. september 2013 08:42
To: J=F8rgen Edelbo
Cc: git@vger.kernel.org; spearce@spearce.org; hvoigt@hvoigt.net
Subject: Re: [PATCH] git-gui: Modify push dialog to support Gerrit revi=
ew

Am 9/2/2013 10:54, schrieb Joergen Edelbo:
> Changes done:
>=20
> Remove selection of branches to push - push always HEAD.
> This can be justified by the fact that this far the most common thing=
=20
> to do.

What are your plans to support a topic-based workflow? "Far the most co=
mmon thing to happen" is that someone forgets to push completed topics.
With this change, aren't those people forced to relinguish their curren=
t work because they have to checkout the completed topics to push them?

-- Hannes
