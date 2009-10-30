From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] More precise description of 'git describe --abbrev'
Date: Fri, 30 Oct 2009 14:53:46 -0700
Message-ID: <7vmy38im51.fsf@alter.siamese.dyndns.org>
References: <b48ea8a00910291438r8b66a0fq9e821393ecfff0bf@mail.gmail.com>
 <m2my38fxeo.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gisle Aas <gisle@aas.no>, git@vger.kernel.org, gitster@pobox.com
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Oct 30 22:54:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3zQ1-0002oz-KM
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 22:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932940AbZJ3Vxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 17:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932936AbZJ3Vxw
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 17:53:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35813 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932929AbZJ3Vxv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 17:53:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9DDF38BD87;
	Fri, 30 Oct 2009 17:53:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pQoj6RWZf59Nz0qyF9008qIKhkc=; b=Pa3jHv
	H5IVc2sk5CGMtdXFmZY/VcIG5N91qFFYGM9ZQXrxUGV6/uZPHwz0TVLpfXTsoaAn
	EaLTpfFg0xAduN4Cuepz0ftUiVuVY27k+VWMd1syZCEuH44zHy9q19BgwlC0cRdv
	0O5nTOiryl3wg7K6HtIhThLPqPUEx1+F6w72o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fjn3cOTaXj3l9g3/OyYN/EF6gN7P1L3V
	RVODdOu8Q9DI+C/oACJ8eA5X7JBg2upc3lNMPQQMQP4+17F49tguQ1ilC4IuQITw
	R0LZo3w3Ijomc2q2rpQBSh3RQtRdO5uMbBl9sPEKx5tUWzmlTdnkyHMhDrsAQywa
	urs+8lOCpg4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 71C6A8BD86;
	Fri, 30 Oct 2009 17:53:53 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B2B738BD80; Fri, 30 Oct 2009
 17:53:47 -0400 (EDT)
In-Reply-To: <m2my38fxeo.fsf@igel.home> (Andreas Schwab's message of "Fri\,
 30 Oct 2009 21\:18\:39 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B70C3FAE-C59E-11DE-9DEB-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131760>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Gisle Aas <gisle@aas.no> writes:
>
>> diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
>> index b231dbb..743eb95 100644
>> --- a/Documentation/git-describe.txt
>> +++ b/Documentation/git-describe.txt
>> @@ -44,7 +44,9 @@ OPTIONS
>>
>>  --abbrev=<n>::
>>  	Instead of using the default 7 hexadecimal digits as the
>> -	abbreviated object name, use <n> digits.
>> +	abbreviated object name, use <n> digits or as many digits
>> +	are needed to form a unique object name.  An <n> of 0
>
> "as many digits as needed"?

Thanks; queued with this fix-up.
