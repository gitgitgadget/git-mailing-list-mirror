From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] commit: reword --author error message
Date: Fri, 16 Jan 2015 18:33:00 -0000
Organization: OPDS
Message-ID: <C67968DA2DD34039AF6EC8B61AA1CA47@PhilipOakley>
References: <54B7CCCD.1070708@drmicha.warpmail.net><84cf10a22858275d6e213311c93df7f6a5408f60.1421331608.git.git@drmicha.warpmail.net><xmqq4mrs7x5h.fsf@gitster.dls.corp.google.com><20150116093220.GA3006@peff.net> <xmqqwq4m3a8k.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>,
	"Gunnar Wagner" <gunnar.wagner@irisgermanica.com>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Michael J Gruber" <git@drmicha.warpmail.net>,
	"Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 16 19:32:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCBh8-0007xX-Dr
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 19:32:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754029AbbAPSc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2015 13:32:26 -0500
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:41993 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751935AbbAPScZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jan 2015 13:32:25 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AmgYAGJYuVROl3fXPGdsb2JhbABagwZSWIYvbb8HhXMEAoEURAEBAQEBAQUBAQEBOCAbhAcFAQEBAQMIAQEuEQ0BASELAgMFAgEDFQMJJRQBBBoGBwMUBgESCAIBAgMBiB/EZo1dAQsBH48XEQFQgx2BEwWJQ4UJUYlNhTCLS4QQPjGBDIE3AQEB
X-IPAS-Result: AmgYAGJYuVROl3fXPGdsb2JhbABagwZSWIYvbb8HhXMEAoEURAEBAQEBAQUBAQEBOCAbhAcFAQEBAQMIAQEuEQ0BASELAgMFAgEDFQMJJRQBBBoGBwMUBgESCAIBAgMBiB/EZo1dAQsBH48XEQFQgx2BEwWJQ4UJUYlNhTCLS4QQPjGBDIE3AQEB
X-IronPort-AV: E=Sophos;i="5.09,412,1418083200"; 
   d="scan'208";a="666361625"
Received: from host-78-151-119-215.as13285.net (HELO PhilipOakley) ([78.151.119.215])
  by out1.ip06ir2.opaltelecom.net with ESMTP; 16 Jan 2015 18:32:24 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262555>

From: "Junio C Hamano" <gitster@pobox.com>
> Jeff King <peff@peff.net> writes:
>
>> On Thu, Jan 15, 2015 at 09:48:26AM -0800, Junio C Hamano wrote:
>>
>>> > Rename the error message to make it clearer that the failure has 
>>> > two
>>> > reasons in this case:
>>> > "Bad --author parameter '%s': neither completely wellformed nor 
>>> > part of
>>> > an existing one"
>>>
>>> You are trying to help a user who thought "Who www.where.com" was a
>>> valid thing to pass to --author; "it is not completely wellformed"
>>> is not very helpful without making her realize what in that bogus
>>> string is not "completely well-formed".
>>>
>>> Perhaps
>>>
>>>   "--author '%s' is not 'Name <email>' and no existing author 
>>> matches that string"
>>>
>>> or somesuch?
>>
>> Yeah, I think that is OK. It is kind of clunky to read, but it 
>> contains
>> all of the necessary information to lead the user in the right
>> direction.
>
> Indeed it is clunky and not in the usual format.
>
> This might be better, perhaps?
>
>    die(_("--author '%s': not 'Name <email>' and matches no existing 
> author"));
/Bikeshed
     die(_("--author '%s': not 'Name <email>', nor matches any existing 
author"));
The 'not/and' construct didn't feel right here in the UK, but then many 
don't understand 'nor' either.
--
Philip
