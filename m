From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v3 0/2] Make git-svn work with gitdir links
Date: Mon, 21 Jan 2013 21:45:53 -0000
Organization: OPDS
Message-ID: <2931F4CC43E4406DBB878482C2F0E4F4@PhilipOakley>
References: <20120308005103.GA27398@dcvr.yhbt.net> <1358731322-44600-1-git-send-email-barry.wardell@gmail.com> <7vwqv7i9su.fsf@alter.siamese.dyndns.org> <kdjip9$4j7$1@ger.gmane.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Barry Wardell" <barry.wardell@gmail.com>,
	"\"Joachim Schmitz\"" <jojo@schmitz-digital.de>
To: "Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 22:46:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxPCG-0003Yk-FM
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 22:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633Ab3AUVpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 16:45:50 -0500
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:58324 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751813Ab3AUVps (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2013 16:45:48 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgIFAE+u/VBcHIm8/2dsb2JhbABEjAKyKxdzghkFAQEEAQgBAS4eAQEhCwIDBQIBAxUBAgklFAEECBIGBxcGEwgCAQIDAYd2AwkKCLMhDYhijAmET2EDiCyFUYY5gnKKG4USgnU
X-IronPort-AV: E=Sophos;i="4.84,508,1355097600"; 
   d="scan'208";a="416574947"
Received: from host-92-28-137-188.as13285.net (HELO PhilipOakley) ([92.28.137.188])
  by out1.ip01ir2.opaltelecom.net with SMTP; 21 Jan 2013 21:45:46 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214164>

From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Sent: Monday, January 21, 2013 2:19 PM
> Junio C Hamano wrote:
>> Barry Wardell <barry.wardell@gmail.com> writes:
[...]
>> Thanks for your persistence ;-) As this is a pretty old topic, I'll
>> give two URLs for people who are interested to view the previous
>> threads:
>>
>>    http://thread.gmane.org/gmane.comp.version-control.git/192133
>>    http://thread.gmane.org/gmane.comp.version-control.git/192127
>>
>> You would want to mark it as test_expect_failure in the first patch
>> and then flip it to text_expect_success in the second patch where
>> you fix the breakage?  Otherwise, after applying the first patch,
>> the testsuite will break needlessly.
>
> I'd just apply them the other way round, 1st fix the problem, 2nd add 
> a test for it

Isn't it a case of, 1st demonstrate the problem with a test, and then 
2nd  fix the problem.

Those less principled could could simply "fix" a non-existent problem 
merely to get themselves into the change log, or worse, even if one may 
fix-test under the hood.

>
> Bye, Jojo

Philip 
