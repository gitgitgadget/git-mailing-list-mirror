From: =?iso-8859-1?Q?J=F8rgen_Edelbo?= <jed@napatech.com>
Subject: RE: [PATCH] git-gui: Modify push dialog to support Gerrit review
Date: Thu, 5 Sep 2013 09:18:25 +0000
Message-ID: <F8C23E99F5C6884EB99E2A1966D743637F3619CB@cph-gen-exch01.napatech.com>
References: <20130904150853.52EC4121B7E@jed-dev-01.labnet>
 <522827CE.5040303@viscovery.net>
 <F8C23E99F5C6884EB99E2A1966D743637F3619A6@cph-gen-exch01.napatech.com>
 <5228476A.2070505@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"spearce@spearce.org" <spearce@spearce.org>,
	"hvoigt@hvoigt.net" <hvoigt@hvoigt.net>,
	Pat Thoyts <patthoyts@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Sep 05 11:18:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHVi6-0000b3-PO
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 11:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763631Ab3IEJS3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Sep 2013 05:18:29 -0400
Received: from mail01.napatech.com ([188.120.77.121]:4621 "EHLO
	mail01.napatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763411Ab3IEJS1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Sep 2013 05:18:27 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqAEAN9LKFIK8AFC/2dsb2JhbABbhA3BRoE9dIIkAQEBAQN5DAQCAQgOBwEMHQcyFBECBA4FCMIxF48vMQeDHYEAA4h9o36CKg
X-IPAS-Result: AqAEAN9LKFIK8AFC/2dsb2JhbABbhA3BRoE9dIIkAQEBAQN5DAQCAQgOBwEMHQcyFBECBA4FCMIxF48vMQeDHYEAA4h9o36CKg
Received: from CPH-GEN-EXCH01.napatech.com ([fe80::8914:d366:9916:d557]) by
 cph-gen-exch01.napatech.com ([fe80::8914:d366:9916:d557%11]) with mapi id
 14.01.0438.000; Thu, 5 Sep 2013 11:18:25 +0200
Thread-Topic: [PATCH] git-gui: Modify push dialog to support Gerrit review
Thread-Index: AQHOqYCr60IA2iFMmkuxOgaQ77X075m2kZ0AgAA95pD//+fIAIAAIx3Q
In-Reply-To: <5228476A.2070505@viscovery.net>
Accept-Language: en-US, da-DK
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.240.10.71]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233943>

> -----Original Message-----
> From: Johannes Sixt [mailto:j.sixt@viscovery.net]
> Sent: 5. september 2013 10:57
>=20
> Please do not top-post.
>=20
> Am 9/5/2013 10:29, schrieb J=F8rgen Edelbo:
> > -----Original Message----- From: Johannes Sixt
> >> Am 9/2/2013 10:54, schrieb Joergen Edelbo:
> >>> Changes done:
> >>>
> >>> Remove selection of branches to push - push always HEAD. This can=
 be
> >>> justified by the fact that this far the most common thing to do.
> >>
> >> What are your plans to support a topic-based workflow? "Far the mo=
st
> >> common thing to happen" is that someone forgets to push completed
> >> topics. With this change, aren't those people forced to relinguish
> >> their current work because they have to checkout the completed top=
ics
> >> to push them?
> >
> > I am not quite sure what your concern is.
>=20
> When I have completed topics A and B, but forgot to push them, and no=
w I
> am working on topic C, how do I push topics A and B?
>=20
> You say I can only push HEAD. I understand this that I have to stop w=
ork on C
> (perhaps commit or stash any unfinished work), then checkout A, push =
it,
> checkout B, push it, checkout C and unstash the unfinished work. If m=
y
> understanding is correct, the new restriction is a no-go.

Ok, this way of working is not supported. It just never occurred to me =
that
you would work this way. Forgetting to push something that you have jus=
t=20
completed is very far from what I am used to. I think it comes most nat=
ural
to push what you have done before changing topic. The reason I make a c=
ommit
is to get it out of the door.

>=20
> -- Hannes

- J=F8rgen
