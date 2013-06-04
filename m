From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] t/README: test_must_fail is for testing Git
Date: Tue, 4 Jun 2013 22:12:06 +0100
Organization: OPDS
Message-ID: <82E212D3F25A4ABA923D1D81684F6578@PhilipOakley>
References: <CAGLuM14_MQffwQWrB2YCQXzhkGaxdaYBuY74y7=pfb-hB6LskA@mail.gmail.com><CACsJy8BqCUKhc8vhjhNz0OedBngk7zcSOk70ekRm3EiruHfNxA@mail.gmail.com><CACsJy8DD=LxAKh_fUELJ5Mj0xS_gZE88N_rJFkKGer=YAOqsMg@mail.gmail.com><51A62A96.6040009@gmail.com> <51A665E4.9080307@gmail.com><CACsJy8D4wmhGkEsn8r5OEQv_hX=OFD5W8abnBnYFcFCQZfLOoQ@mail.gmail.com><7vk3mcnwlj.fsf@alter.siamese.dyndns.org><7vppw195x7.fsf_-_@alter.siamese.dyndns.org><AAD729AEE8D044B89388799A7CC7552A@PhilipOakley> <7v1u8h7gac.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Karsten Blees" <karsten.blees@gmail.com>,
	"Duy Nguyen" <pclouds@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 23:12:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjyWg-0002bj-AF
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 23:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404Ab3FDVMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 17:12:08 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:22923 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751188Ab3FDVMH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jun 2013 17:12:07 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AtYNAIZXrlFOl3th/2dsb2JhbABUBoMJiSu2JQQBAwF8F3SCHgUBAQQBCAEBLh4BASELAgMFAgEDFQELJRQBBBoGBxcGEwgCAQIDAYd2Cr1ujX48aoMBYQOIaIYFkm2HJYMQOw
X-IronPort-AV: E=Sophos;i="4.87,802,1363132800"; 
   d="scan'208";a="74331432"
Received: from host-78-151-123-97.as13285.net (HELO PhilipOakley) ([78.151.123.97])
  by out1.ip07ir2.opaltelecom.net with SMTP; 04 Jun 2013 22:12:05 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226405>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Tuesday, June 04, 2013 9:49 PM
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> From: "Junio C Hamano" <gitster@pobox.com>
>> Sent: Tuesday, June 04, 2013 5:50 PM
>>> When a test wants to make sure there is no <string> in an output
>>> file, we should just say "! grep string output";
>>
>> Small nit: It took me two readings of the commit message to correctly
>> parse this break point. The flowing together of the two parts with 
>> the
>> semicolon fooled me. Separate them?
>>
>>>      "test_must_fail"
>>> is there only to test Git command and catch unusual deaths we know
>>> about (e.g. segv) as an error, not as an expected failure.
>
> Thanks.  Does this read better?

Yes.  Thanks.

>
>    t/README: test_must_fail is for testing Git
>
>    When a test wants to make sure there is no <string> in an output
>    file, we should just say "! grep string output".
>
>    "test_must_fail" is there only to test Git command and catch 
> unusual
>    deaths we know about (e.g. segv) as an error, not as an expected
>    failure.  "test_must_fail grep string output" is unnecessary, as
>    we are not making sure the system binaries do not dump core or
>    anything like that.
>
>    Signed-off-by: Junio C Hamano <gitster@pobox.com>
> --

Philip 
