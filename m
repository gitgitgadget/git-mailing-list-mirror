From: "Medve Emilian-EMMEDVE1" <Emilian.Medve@freescale.com>
Subject: RE: [ALTERNATE PATCH] Add a simple option parser.
Date: Fri, 5 Oct 2007 09:10:42 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E2701624FF2@az33exm24.fsl.freescale.net>
References: <1191447902-27326-1-git-send-email-krh@redhat.com> <20071005142140.GK19879@artemis.corp> <20071005142507.GL19879@artemis.corp> <20071005143014.GA18176@glandium.org> <20071005144540.GM19879@artemis.corp> <598D5675D34BE349929AF5EDE9B03E2701624FD6@az33exm24.fsl.freescale.net> <20071005155647.GC20305@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Mike Hommey" <mh@glandium.org>,
	=?iso-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	<git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>
To: "Pierre Habouzit" <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 18:11:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdplQ-0007RS-Ft
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 18:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759634AbXJEQKr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Oct 2007 12:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759870AbXJEQKr
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 12:10:47 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:54212 "EHLO
	de01egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757820AbXJEQKq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Oct 2007 12:10:46 -0400
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id l95GAh14025658
	for <git@vger.kernel.org>; Fri, 5 Oct 2007 09:10:43 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net [10.64.32.14])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l95GAgIF017851
	for <git@vger.kernel.org>; Fri, 5 Oct 2007 11:10:43 -0500 (CDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <20071005155647.GC20305@artemis.corp>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ALTERNATE PATCH] Add a simple option parser.
Thread-Index: AcgHaF+J6a4DIT02SVKCp3Ur91GZlgAADsCA
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60100>

Hi Pierre,

> -----Original Message-----
> From: Pierre Habouzit [mailto:madcoder@debian.org]=20
> Sent: Friday, October 05, 2007 10:57 AM
> To: Medve Emilian-EMMEDVE1
> Cc: Mike Hommey; Kristian H=F8gsberg; git@vger.kernel.org;=20
> Junio C Hamano
> Subject: Re: [ALTERNATE PATCH] Add a simple option parser.
>=20
> On ven, oct 05, 2007 at 03:45:36 +0000, Medve Emilian-EMMEDVE1 wrote:
> > You probably already considered and rejected the GNU argp parser. I
> > used it before and I'd like to know reasons I should stay away from
> > it.
>=20
>   Because it's GNU and that it's a heavy dependency to begin with.

So it's more of a political decision then a technical one?

> Moreover, getopt_long doesn't deal with argument types (like=20
> integers).

AFAIK, getopt_long in not argp.


Cheers,
Emil.
