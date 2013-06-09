From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v4 10/45] sequencer: trivial fix
Date: Sun, 9 Jun 2013 22:09:23 +0100
Organization: OPDS
Message-ID: <AD9D4E5DA7694BF297CDE2DA871CB3B6@PhilipOakley>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com><1370796057-25312-11-git-send-email-felipe.contreras@gmail.com><20130609171810.GA10858@goldbirke> <CAMP44s3yhVbgkhtrSfHpk=VwcwMkb66ELA-xR0i6FCVGyRwHJw@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>,
	"Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	"Martin von Zweigbergk" <martin.von.zweigbergk@gmail.com>
To: "Felipe Contreras" <felipe.contreras@gmail.com>,
	=?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Jun 09 23:09:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulmrh-0001ih-40
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 23:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252Ab3FIVJG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 17:09:06 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:4397 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750987Ab3FIVJF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 17:09:05 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AjQOAJrutFFOl3so/2dsb2JhbABZgwkwgz2FP7YGAQMBeRd0gh4FAQEFCAEBGQ8BBR4BASELAgMFAgEDFQECAgIFIQICFAEECBIGBxcGARIIAgECAwGHagMTCKhOh20NiFKBJos1gUYtaoJTM2EDjm6Ga4MQinWFJIMQOw
X-IronPort-AV: E=Sophos;i="4.87,832,1363132800"; 
   d="scan'208";a="412561016"
Received: from host-78-151-123-40.as13285.net (HELO PhilipOakley) ([78.151.123.40])
  by out1.ip04ir2.opaltelecom.net with SMTP; 09 Jun 2013 22:08:42 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227168>

=46rom: "Felipe Contreras" <felipe.contreras@gmail.com>
Sent: Sunday, June 09, 2013 6:23 PM
> On Sun, Jun 9, 2013 at 12:18 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de=
>=20
> wrote:
>> On Sun, Jun 09, 2013 at 11:40:22AM -0500, Felipe Contreras wrote:
>>> We should free objects before leaving.
>>>
>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>
>> A shortlog-friendlier subject could be: "sequencer: free objects
>> before leaving".
>
> I already defended my rationale for this succinct commit message:
>
> http://thread.gmane.org/gmane.comp.version-control.git/225609/focus=3D=
225610
>
> --=20
> Felipe Contreras

I think I'd prefer a mixture of both.

"sequencer: trivial fix: free objects before leaving".
This gives the best of both worlds in that the 'triviality' is plainly=20
there to see, and so is the type of triviality, just in case it has som=
e=20
un-noticed side effect that someone is looking for at a leter date

Same goes for "build: trivial cleanup: don't repeat prerequisites"=20
[PATCH v4 03/45]

All the best,

Philip
