From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Failure to extra stable@vger.kernel.org addresses
Date: Tue, 20 Nov 2012 14:30:02 -0800
Message-ID: <7vhaojrjpx.fsf@alter.siamese.dyndns.org>
References: <20121119151845.GA29678@shrek.podlesie.net>
 <7vk3thxuj2.fsf@alter.siamese.dyndns.org>
 <20121119225838.GA23412@shrek.podlesie.net>
 <CAMP44s0f0zYa1FVf9RhNuwYJbkQ7zPwgJ6=ty3c5knjo5a2TNw@mail.gmail.com>
 <7vlidxuowf.fsf@alter.siamese.dyndns.org>
 <20121120073100.GB7206@shrek.podlesie.net>
 <20121120075628.GA7159@shrek.podlesie.net>
 <CAMP44s38gTB_3Ao1rFZgMo2EAuiNb+h88-qRFcQPRMJNxo3CAQ@mail.gmail.com>
 <20121120115942.GA6132@shrek.podlesie.net> <m2lidw11yb.fsf@igel.home>
 <20121120212126.GA12656@shrek.podlesie.net>
 <CAMP44s3+vnKfhhh=qqU2vuKvWwhii4CQ7=YAuhFiceX1EDaVKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Krzysztof Mazur <krzysiek@podlesie.net>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Felipe Balbi <balbi@ti.com>, git@vger.kernel.org,
	Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 23:30:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TawKm-0003O9-M4
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 23:30:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001Ab2KTWaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 17:30:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33316 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752489Ab2KTWaG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 17:30:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BE3E9BF6;
	Tue, 20 Nov 2012 17:30:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XBFYVxxveiXFFIB1l8fqI5nemdk=; b=TXT12N
	m1xEJSsksJyO2EMmhJJDUT9dU6hMWFafNyBdh5Ct+eMHqvRH+srbc3S/WtSzhFug
	bBEeI1v6yuIDz5U+/TWEDGjlMCd0neF3XeBR64CdrULND58yPB5nEPU6RR+rWpWo
	ZpuiamrOJgUbNcol6YZI8FjnYody4czOusa24=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V9Xt6inHRDYzMlROMDsMnjs31K53Elit
	lE0DCfuzcsPsqFsIJ9grnE+YtgcjNaL76P7IIR1iwDuxg0zSrK9hBG7Rv1q4vyv1
	VlRGgDRwJACKZ7KOTxcmrJgzV9QrT8IRNMJItMTdVY0y3wG1ixRHFxb3SALCPHIR
	iYRs7g41/hM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FE269BF5;
	Tue, 20 Nov 2012 17:30:05 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8205B9BF3; Tue, 20 Nov 2012
 17:30:04 -0500 (EST)
In-Reply-To: <CAMP44s3+vnKfhhh=qqU2vuKvWwhii4CQ7=YAuhFiceX1EDaVKQ@mail.gmail.com> (Felipe
 Contreras's message of "Tue, 20 Nov 2012 23:06:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D491AC1A-3361-11E2-ADF1-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210119>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, Nov 20, 2012 at 10:21 PM, Krzysztof Mazur <krzysiek@podlesie.net> wrote:
>
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -924,6 +924,10 @@ sub quote_subject {
>>  # use the simplest quoting being able to handle the recipient
>>  sub sanitize_address {
>>         my ($recipient) = @_;
>> +
>> +       # remove garbage after email address
>> +       $recipient =~ s/(.*?<[^>]*>).*$/$1/;
>
> That won't work for 'foo@bar.com # test'. I think we should abandon
> hopes of properly parsing an email address and just do:
>
> $recipient =~ s/(.*?) #.*$/$1/;

We should probably fix the tools that generate these bogus
non-addresses first.  What's wrong with

	Cc: stable kernel (v3.5 v3.6 v3.7) <stable@vger.kernel.org>

which should be OK?

Also I suspect that this should be also deemed valid:

	Cc: stable@vger.kernel.org (Stable kernel - v3.5 v3.6 v3.7)
