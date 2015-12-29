From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] improve symbolic-ref robustness
Date: Tue, 29 Dec 2015 10:35:07 -0800
Message-ID: <xmqq7fjxhzms.fsf@gitster.mtv.corp.google.com>
References: <20151220072637.GA22102@sigill.intra.peff.net>
	<20151229055558.GA12848@sigill.intra.peff.net>
	<56824362.30903@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Dec 29 19:35:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDz77-0002VX-95
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 19:35:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753751AbbL2SfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 13:35:13 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58628 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753667AbbL2SfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 13:35:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2C9C83738E;
	Tue, 29 Dec 2015 13:35:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EaerI21uvL2uffG7xtwFOfJtSEA=; b=BqhOyF
	uQwlTkaaIHxmaXdKW4SwuBwsvqjkUieQxuo7sXxeEZr75VNYTkh1/mxl2A1AXAiS
	W5ATLWQOV1uhRZhstX6rAxiPFBWzD5YBtERgs+4bB29NITuj43SNyQhvhmP9eOZZ
	kApzHK//0I4si67NSXPFnPUzG6/b0Jw0DB03Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vlLgChLEFucnkVA5UJfqoWL78Md5kBfo
	LanIm4vVYzmJk7YJIGd4HDZpfAFi9CIfngAJdsiW+6HWuFdFpAXnJY0mQOsHMjHe
	Qo0Hjv2hPhKVPRcMPuE7LLcWoJiPK7gHudwDYCTHs87YKwPuaZdnbuj/cXaQdFGY
	LiwbW+S3tsQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1912D3738D;
	Tue, 29 Dec 2015 13:35:09 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 90E953738C;
	Tue, 29 Dec 2015 13:35:08 -0500 (EST)
In-Reply-To: <56824362.30903@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 29 Dec 2015 09:25:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E3297DBC-AE5A-11E5-8176-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283141>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 12/29/2015 06:55 AM, Jeff King wrote:
>
>> The patches are:
>> 
>>   [1/3]: create_symref: modernize variable names
>>   [2/3]: create_symref: use existing ref-lock code
>>   [3/3]: create_symref: write reflog while holding lock
>
> Thanks, Peff. The whole series is
>
> Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
>
> Michael

Thanks, both.
