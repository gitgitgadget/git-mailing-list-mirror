From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 2/3] test: improve rebase -q test
Date: Sun, 9 Jun 2013 23:44:11 +0100
Organization: OPDS
Message-ID: <C30D5684C80641EFAC0F89F00B48A74F@PhilipOakley>
References: <1370637143-21336-1-git-send-email-felipe.contreras@gmail.com><1370637143-21336-3-git-send-email-felipe.contreras@gmail.com><CACsJy8DHeqOz=WbxurCvPiDq73k4eftwrEEZzWBbifS51PDbLQ@mail.gmail.com><7vd2rvqgra.fsf@alter.siamese.dyndns.org><CAMP44s3Pny7JkyHbLZ3kUemNK70JhdYWdpELTjNLz0y3Z2V3+A@mail.gmail.com><7vy5ajozuj.fsf@alter.siamese.dyndns.org> <CAMP44s38T9EUOe8EBKy1kxa-rEu7g0jb7+HB019AgCub+2SVnw@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Duy Nguyen" <pclouds@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	"Stephen Boyd" <bebarino@gmail.com>,
	"Jens Lehmann" <Jens.Lehmann@web.de>
To: "Felipe Contreras" <felipe.contreras@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 00:43:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UloKl-000264-6U
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 00:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886Ab3FIWnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 18:43:31 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:19215 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750910Ab3FIWna (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 18:43:30 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AjcOABwEtVFOl3so/2dsb2JhbABZgwkwgz2FP7YCBAEDAXkXdIIeBQEBBQgBARkVHgEBIQsCAwUCAQMVAQICAgUhAgIUAQQIEgYHFwYBEggCAQIDAYdqAxOoH4dqDYhSgSaLNYFzaoJTM2EDjm6FAIFrjgWFJIMQOw
X-IronPort-AV: E=Sophos;i="4.87,833,1363132800"; 
   d="scan'208";a="74943323"
Received: from host-78-151-123-40.as13285.net (HELO PhilipOakley) ([78.151.123.40])
  by out1.ip07ir2.opaltelecom.net with SMTP; 09 Jun 2013 23:43:28 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227203>

From: "Felipe Contreras" <felipe.contreras@gmail.com>
Sent: Sunday, June 09, 2013 8:33 PM
> On Sun, Jun 9, 2013 at 2:20 PM, Junio C Hamano <gitster@pobox.com> 
> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> On Sun, Jun 9, 2013 at 1:30 PM, Junio C Hamano <gitster@pobox.com> 
>>> wrote:
>>>
>>>> --- a/t/test-lib-functions.sh
>>>> +++ b/t/test-lib-functions.sh
>>>> @@ -606,6 +606,18 @@ test_cmp() {
>>>>         $GIT_TEST_CMP "$@"
>>>>  }
>>>>
>>>> +# Check if the file expected to be empty is indeed empty, and 
>>>> barfs
>>>> +# otherwise.
>>>> +
>>>> +test_output_must_be_empty () {
>>>
>>> Why such a big name? test_empty() does the trick.
>>
>> Primarily in order to avoid that exact name "test_empty" that others
>> may want to use for a helper to check that the contents of a string
>> variable is empty.
>
> Which is never going to happen.
>

While folks do use such simplistic names, given that the patch had many 
call sites, I do think Filipe's short name would quickly become the 
accepted test name and not cause any great difficulties.

regards
Philip 
