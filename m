From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2 2/2] send-email: handle adjacent RFC 2047-encoded words properly
Date: Wed, 10 Dec 2014 22:21:10 -0000
Organization: OPDS
Message-ID: <A6412B2B2F584CDC9ACCB22623CF789A@PhilipOakley>
References: <1417894583-2352-1-git-send-email-dpb@corrigendum.ru> <1417894583-2352-2-git-send-email-dpb@corrigendum.ru> <20141207091859.GA21311@peff.net> <op.xqh5hrafnngjn5@freezie> <316EF32F3157400882911A84EA0CFC61@PhilipOakley> <op.xqifqmyznngjn5@freezie>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	reply-type=response
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>,
	=?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, "Jay Soffian" <jaysoffian@gmail.com>,
	"Thomas Rast" <tr@thomasrast.ch>, "Jeff King" <peff@peff.net>
To: =?utf-8?B?0KDQvtC80LDQvSDQlNC+0L3Rh9C10L3QutC+?= 
	<dpb@corrigendum.ru>
X-From: git-owner@vger.kernel.org Wed Dec 10 23:21:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XypdC-0007rk-CE
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 23:21:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757951AbaLJWVJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Dec 2014 17:21:09 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:61218 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752091AbaLJWVI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Dec 2014 17:21:08 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AtkPACTGiFQCYJ6mPGdsb2JhbABZgwaBKoMFgypsvDyIJQQCgSAXAQEBAQEBBQEBAQE4O4QHBQEBAQEDCAEBGQ8BBR4BASELAgMFAgEBAhUBBAIFIQICFAEEGgYHAxQGCgkIAgECAwGIK6N7nGaGZ5BeAQsBH4EmiymCUhEBUIJ2MoEVAQSOAk2cDIFgPjCBDIE3AQEB
X-IPAS-Result: AtkPACTGiFQCYJ6mPGdsb2JhbABZgwaBKoMFgypsvDyIJQQCgSAXAQEBAQEBBQEBAQE4O4QHBQEBAQEDCAEBGQ8BBR4BASELAgMFAgEBAhUBBAIFIQICFAEEGgYHAxQGCgkIAgECAwGIK6N7nGaGZ5BeAQsBH4EmiymCUhEBUIJ2MoEVAQSOAk2cDIFgPjCBDIE3AQEB
X-IronPort-AV: E=Sophos;i="5.07,554,1413241200"; 
   d="scan'208";a="537082323"
Received: from host-2-96-158-166.as13285.net (HELO PhilipOakley) ([2.96.158.166])
  by out1.ip03ir2.opaltelecom.net with SMTP; 10 Dec 2014 22:21:05 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261250>

=46rom: "=D0=A0=D0=BE=D0=BC=D0=B0=D0=BD =D0=94=D0=BE=D0=BD=D1=87=D0=B5=D0=
=BD=D0=BA=D0=BE" <dpb@corrigendum.ru>
Sent: Sunday, December 07, 2014 6:17 PM
>> Would that be worth a terse comment in the documentation change part=
=20
>> of  the patch?
>> "Multiple  (RFC2047) encodings are not supported.",
>> or would that be bike shed noise.
>
> I didn't change any documentation... and in either case, they weren't=
=20
> supported in the first place, so I don't think it's anything I need t=
o=20
> mention.

I'd confused this with the crossing thread by Paolo Bonzini=20
<bonzini@gnu.org> [PATCH 2/2] git-send-email: add --transfer-encoding=20
option; 25 November 2014 14:00. $gmane/260217.

Sorry for the noise.
--
Philip=20
