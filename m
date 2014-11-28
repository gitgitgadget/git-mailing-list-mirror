From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Our cumbersome mailing list workflow
Date: Fri, 28 Nov 2014 12:09:08 -0000
Organization: OPDS
Message-ID: <A2A8D58134DA4E0B8D9CCE3D29E5319E@PhilipOakley>
References: <1416423000-4323-1-git-send-email-sbeller@google.com><1416578950-23210-1-git-send-email-mhagger@alum.mit.edu><546F4B5B.2060508@alum.mit.edu><xmqq61e81ljq.fsf@gitster.dls.corp.google.com><5473CD28.5020405@alum.mit.edu> <54776367.1010104@web.de> <vpqoars7b8z.fsf@anie.imag.fr>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Michael Haggerty" <mhagger@alum.mit.edu>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Stefan Beller" <sbeller@google.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	"Ronnie Sahlberg" <sahlberg@google.com>, <git@vger.kernel.org>
To: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>,
	=?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Nov 28 13:11:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XuKOU-000292-Sy
	for gcvg-git-2@plane.gmane.org; Fri, 28 Nov 2014 13:11:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbaK1MLX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Nov 2014 07:11:23 -0500
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:34293 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750985AbaK1MLV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Nov 2014 07:11:21 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AiITACNmeFRZ8Y9EPGdsb2JhbAAmMQSDBlGHfcAbhkcEAoEOFwEBAQEBAQUBAQEBOCAbggqBcwUBAQEBAwgBASgBBRENAQEPBwsLAgMFAgEDFQMJJRQBBBoGBwMUBgESCAIBAgMBiBoDFgnCdohNIoYmAQEIAgEfkBkRARI+gzWBHwWLaIZ9bYN6ok0/MAGBDoE7AQEB
X-IPAS-Result: AiITACNmeFRZ8Y9EPGdsb2JhbAAmMQSDBlGHfcAbhkcEAoEOFwEBAQEBAQUBAQEBOCAbggqBcwUBAQEBAwgBASgBBRENAQEPBwsLAgMFAgEDFQMJJRQBBBoGBwMUBgESCAIBAgMBiBoDFgnCdohNIoYmAQEIAgEfkBkRARI+gzWBHwWLaIZ9bYN6ok0/MAGBDoE7AQEB
X-IronPort-AV: E=Sophos;i="5.07,476,1413241200"; 
   d="scan'208";a="478052673"
Received: from host-89-241-143-68.as13285.net (HELO PhilipOakley) ([89.241.143.68])
  by out1.ip04ir2.opaltelecom.net with SMTP; 28 Nov 2014 12:11:04 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260361>

=46rom: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
> Torsten B=F6gershausen <tboegi@web.de> writes:
>
>> On 2014-11-25 01.28, Michael Haggerty wrote:
>> []
>>> Let me list the aspects of our mailing list workflow that I find
>>> cumbersome as a contributor and reviewer:
>>>
>>> * Submitting patches to the mailing list is an ordeal of configurin=
g
>>> format-patch and send-email and getting everything just right, usin=
g
>>> instructions that depend on the local environment.
>> Typically everything fits into ~/.gitconfig,
>> which can be carried around on a USB-Stick.
>
> I personnally submit all my Git patches from a machine whose
> /usr/sbin/sendmail knows how to send emails, so for me configuration=20
> is
> super simple. But I can imagine the pain of someone working on variou=
s
> machines with various network configuration and normally using a=20
> webmail
> to send emails. Sharing ~/.gitconfig does not always work because on
> machine A you only can use one SMTP server, and on machine B only
> another ...

The bit I find awkward for the send-email step is the creation of the=20
"to" and "cc" lists. I tend to create the command line in a separate=20
file so that I can re-use it for V2 etc. and even then I end up with al=
l=20
patches going to the full to/cc list.

Michael's original discussion email did feel to summarise the isses [1]=
=20
well.

--
Philip
[1] System Problems are Wicked problems :
http://en.wikipedia.org/wiki/Wicked_problem
www.poppendieck.com/wicked.htm
