From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] doc: State coding guideline for error message punctuation
Date: Tue, 15 Jul 2014 20:28:06 +0100
Organization: OPDS
Message-ID: <93D8A848078245C2BA36B26D878B5970@PhilipOakley>
References: <1402923357-3788-1-git-send-email-philipoakley@iee.org><1402923357-3788-2-git-send-email-philipoakley@iee.org><20140617093759.GA6267@sigill.intra.peff.net> <xmqqwqbl6jey.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 15 21:28:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X78Oc-00009V-4h
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 21:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933036AbaGOT2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 15:28:10 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:53317 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933003AbaGOT2J (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jul 2014 15:28:09 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhgmANx/xVNZ8YixPGdsb2JhbABZgw6BKYctgQTBAAUBAgEBgRAXBAEBAQE4NYN+BQEBBAEIAQEuHgEBFA0FBgIDBQIBAxEDAQEBAQklFAEEGgYHAwwIBgESCAIBAgMBiCkMuQmRJBePSw2DJ4EWBYonhm2hbjwv
X-IPAS-Result: AhgmANx/xVNZ8YixPGdsb2JhbABZgw6BKYctgQTBAAUBAgEBgRAXBAEBAQE4NYN+BQEBBAEIAQEuHgEBFA0FBgIDBQIBAxEDAQEBAQklFAEEGgYHAwwIBgESCAIBAgMBiCkMuQmRJBePSw2DJ4EWBYonhm2hbjwv
X-IronPort-AV: E=Sophos;i="5.01,667,1400022000"; 
   d="scan'208";a="508856897"
Received: from host-89-241-136-177.as13285.net (HELO PhilipOakley) ([89.241.136.177])
  by out1.ip02ir2.opaltelecom.net with SMTP; 15 Jul 2014 20:28:06 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253590>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Thursday, July 10, 2014 9:36 PM
> Jeff King <peff@peff.net> writes:
>
>> On Mon, Jun 16, 2014 at 01:55:57PM +0100, Philip Oakley wrote:
>>
>>> +Error Messages
>>> +
>>> + - We typically do not end error messages with a full stop. While
>>> +   we've been rather inconsistent in the past, these days we mostly
>>> +   settle on no punctuation.
>>
>> Unlike Junio, I do not mind spelling out guidance for error messages.
>> However, I do not think the second sentence is adding anything here
>> (everything in CodingGuidelines is subject to "we did not always do 
>> it
>> this way, but this is the preferred way now"). So I'd drop it.
>>
>> And then add in more guidance. Besides "no full stop", probably:
>>
>>   1. do not capitalize ("unable to open %s", not "Unable to open %s"
>>
>>   2. maybe something on sentence structure / ordering? We tend to 
>> prefer
>>      "cannot open 'foo': No such file or directory" to "foo: cannot
>>      open: No such file or directory".
>>
>> Perhaps there are others (we do not have to be exhaustive, but it 
>> makes
>> sense to think for a moment while we are here).
>
> I do not want to forever be waiting for a reroll, so let's queue
> this and advance it to 'next' soonish, and refine the guidelines by
> further building on top of it as needed.
>

Sorry, I've been away on vacation for the last few weeks. I hadn't been 
sure what to include in a re-roll without it gaining too much mission 
creep.

Thanks for keeping an eye on it.


> Thanks.
>
> -- >8 --
> From: Philip Oakley <philipoakley@iee.org>
> Date: Mon, 16 Jun 2014 13:55:57 +0100
> Subject: [PATCH] doc: give some guidelines for error messages
>
> Clarify error message puntuation to reduce review workload.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> Documentation/CodingGuidelines | 9 +++++++++
> 1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/CodingGuidelines 
> b/Documentation/CodingGuidelines
> index f424dbd..f4137c6 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -264,6 +264,15 @@ For Python scripts:
>    documentation for version 2.6 does not mention this prefix, it has
>    been supported since version 2.6.0.
>
> +Error Messages
> +
> + - Do not end error messages with a full stop.
> +
> + - Do not capitalize ("unable to open %s", not "Unable to open %s")
> +
> + - Say what the error is first ("cannot open %s", not "%s: cannot 
> open")
> +
> +
> Writing Documentation:
>
>  Most (if not all) of the documentation pages are written in the
> -- 
> 2.0.1-751-ge540734
> 
