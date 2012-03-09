From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] configure: allow user to prevent $PATH "sanitization" on
 Solaris
Date: Fri, 09 Mar 2012 13:59:06 -0800
Message-ID: <7vty1x4es5.fsf@alter.siamese.dyndns.org>
References: <7vhay6etqc.fsf@alter.siamese.dyndns.org>
 <a706eaa1e1cd5e13a8cd98362fe09bba628789d1.1331296220.git.stefano.lattarini@gmail.com> <7vaa3p5zht.fsf@alter.siamese.dyndns.org> <4F5A7A34.3050000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 22:59:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S67qF-0008Vv-3W
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 22:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758572Ab2CIV7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 16:59:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51570 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030193Ab2CIV7J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 16:59:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F7FC64FD;
	Fri,  9 Mar 2012 16:59:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uufTzlIdu2F2KoZ0SMIZCWgyJyA=; b=xozt79
	j/v0tPJL0gO8zxwh09s0+zWD+OfnlGosZfqZJX7ZRBaZvdsQGPOaABKN9qN8Sm1e
	MD+NHkHgXyIZdbaYm2b3ORCzrRlMF/SBZBNytbqT4xrvJW3cdtdkR385F/VDHOrY
	/5OmsXwVi8QVBjhEOUtos7Y8k5WC7Q6z3SbC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dh7NEECRTDcpEgpIeQgvTMsa9aJl9uBG
	Lc38PMzd9CtGGWoZOLQtDIadXVypksqOTDmk1Fiq9J5G3EnWdhjds6BRysJg1vn8
	tZKRuGKCwOQVcjSKqaidHyrR0F6xSsqkKcs1C79k/dAeHECDBsTjy7PT+RwXv9m0
	uwgKr8VdA4A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52C1764FC;
	Fri,  9 Mar 2012 16:59:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC6F664FB; Fri,  9 Mar 2012
 16:59:07 -0500 (EST)
In-Reply-To: <4F5A7A34.3050000@gmail.com> (Stefano Lattarini's message of
 "Fri, 09 Mar 2012 22:46:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 182A6D48-6A33-11E1-A9BB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192743>

Stefano Lattarini <stefano.lattarini@gmail.com> writes:

> On 03/09/2012 08:46 PM, Junio C Hamano wrote:
>> Stefano Lattarini <stefano.lattarini@gmail.com> writes:
>> 
>>> This change implements the second approach, which is less-ambitious but
>>> also much less fragile.
>> 
>> I personally think your second one is the only sane option.
>> 
>>> ---
>> 
>> You forgot to sign-off the patch, perhaps?
>>
> Indeed (but I've now fixed my git aliases to avoid similar issues in
> the future).  Will you fix the issue locally, or should I re-roll?

Sure, I'll fix it up.  Thanks.
