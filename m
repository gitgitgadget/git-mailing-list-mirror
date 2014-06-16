From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] doc: State coding guideline for error message punctuation
Date: Mon, 16 Jun 2014 20:57:47 +0100
Organization: OPDS
Message-ID: <05EDF0921017440B962382667FE945B7@PhilipOakley>
References: <1402923357-3788-1-git-send-email-philipoakley@iee.org><1402923357-3788-2-git-send-email-philipoakley@iee.org> <xmqq8uowr8ki.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>, "Jeff King" <peff@peff.net>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 21:57:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwd2Q-00013Y-Gk
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 21:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756064AbaFPT5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 15:57:49 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:28622 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755745AbaFPT5r (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jun 2014 15:57:47 -0400
X-Cloudmark-SP-Filtered: true
X-Cloudmark-SP-Result: v=1.1 cv=Qigz/So3gzN3zQ5CgEA2p4hDzanmeghV4jzKA5NXKmc= c=1 sm=2
 a=N7Wbkg4LlQwA:10 a=JZniprFAKO4A:10 a=JdeMvdncyXcA:10 a=8nJEP1OIZ-IA:10
 a=ybZZDoGAAAAA:8 a=xtxXYLxNAAAA:8 a=TSbVqHtbAAAA:8 a=VwQbUJbxAAAA:8
 a=EbUUo5YyVHNNTmXh16oA:9 a=wPNLvfGTeEIA:10 a=x8gzFH9gYPwA:10
 a=qIVjreYYsbEA:10 a=UMeZMYMyszsA:10
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AlMZAHASn1NZ8Y0l/2dsb2JhbABagw1SiQGzHR6HMwQBAQIBAYERF3WDfgUBAQQBCAEBLhYIAQEhCwIDBQIBAxUMJRQBBBgCBgcXBggLCAIBAgMBBQcEiBkMCbgjlxaOdoM0gRYEigWGWosnkhWDQTwvAQE
X-IPAS-Result: AlMZAHASn1NZ8Y0l/2dsb2JhbABagw1SiQGzHR6HMwQBAQIBAYERF3WDfgUBAQQBCAEBLhYIAQEhCwIDBQIBAxUMJRQBBBgCBgcXBggLCAIBAgMBBQcEiBkMCbgjlxaOdoM0gRYEigWGWosnkhWDQTwvAQE
X-IronPort-AV: E=Sophos;i="5.01,489,1400022000"; 
   d="scan'208";a="648527654"
Received: from host-89-241-141-37.as13285.net (HELO PhilipOakley) ([89.241.141.37])
  by out1.ip01ir2.opaltelecom.net with SMTP; 16 Jun 2014 20:57:45 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251811>

From: "Junio C Hamano" <gitster@pobox.com>
> Philip Oakley <philipoakley@iee.org> writes:
>
>> Clarify error message puntuation to reduce review workload [1].
>>
>> [1] http://article.gmane.org/gmane.comp.version-control.git/251547
>> (see trailing 'nit' item).
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>
> Hmmm.  Do we really need to spell everything out?
It was more of a case of 'do we often have to provide this guidance in 
reviews'?
The trailing full stop does appear to come up moderately often, along 
with other punctuation issues. I am on the 'guidance of the wise and 
education of others' side of the camp, rather than they being rules and 
regulations (as was recently misunderstood), so lets educate.

I haven't yet had the time to search deeply, but I'm sure I've also seen 
various bits of guidance on suitability and style of error messages in 
the last year of so that the section can be rounded out on that front as 
well (no doubt similar to some of the commit message guidance).

>
> I would rather hope that we can rely on our contributors to know Git
> well enough to ask "git grep" after reading the "follow the style of
> existing and surrounding code" rule that governs the overall
> guideline.

I don't see error messages as "code" per se, rather as an attempt at a 
consistent user interface[*], and the user errors can come from 
anywhere, so if we have settled on a style, let's say so.

Philip

[*] My distinction here: "code" is a developer interface, "commands and 
error messages" is the UI.

>
>>  Documentation/CodingGuidelines | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/CodingGuidelines 
>> b/Documentation/CodingGuidelines
>> index 4d90c77..b2f3442 100644
>> --- a/Documentation/CodingGuidelines
>> +++ b/Documentation/CodingGuidelines
>> @@ -404,6 +404,13 @@ For Python scripts:
>>     documentation for version 2.6 does not mention this prefix, it 
>> has
>>     been supported since version 2.6.0.
>>
>> +Error Messages
>> +
>> + - We typically do not end error messages with a full stop. While
>> +   we've been rather inconsistent in the past, these days we mostly
>> +   settle on no punctuation.
>> +
>> +
>>  Writing Documentation:
>>
>>   Most (if not all) of the documentation pages are written in the
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
