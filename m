From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2013, #01; Wed, 4)
Date: Thu, 05 Dec 2013 10:17:13 -0800
Message-ID: <xmqq1u1ri2mu.fsf@gitster.dls.corp.google.com>
References: <xmqqiov4hz07.fsf@gitster.dls.corp.google.com>
	<CACsJy8BR-DPSxdNzJupHsktP1nPW79TJ_8N__xfOaAdP4MBp5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 05 19:17:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VodUZ-0006kI-ML
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 19:17:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757598Ab3LESRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Dec 2013 13:17:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35588 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757557Ab3LESRP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 13:17:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FC9C577C9;
	Thu,  5 Dec 2013 13:17:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zFAJlUEoghzYetT3YN7hfDclC7Y=; b=fK9yuM
	0CunruOpF9LTaxcmBuefzWOfgxCE3/zZvj8vy1NHYSbBaRa2xT9uSsauIXYV4CEI
	EWuV1LhbkeAvsMY7ME6Pm4mPpkktllbn+ZlvgqVh8iLrkt15xx7wT9jCunKKWFRd
	zs3lnhzOP2HKg0Wb86GE4OaggDXvNFqHeaZGI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MT+2Oc7rlwLlL2m47ke2HIFkzpHTV1Ql
	cIE+ESuYjSImIilMTIn4/rdTdnKJzUklkK2HP2j309CG8wH6MG1H93bJUKFZbgYF
	2ay50WcH+tcw1L5WmWyVgi0FJ6Z0u0HiPGa6ElnUQ3Nxz6KBIhPICQXB04/57Ovt
	e5HtiaZRq/M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37C4C577C8;
	Thu,  5 Dec 2013 13:17:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 788E5577C7;
	Thu,  5 Dec 2013 13:17:14 -0500 (EST)
In-Reply-To: <CACsJy8BR-DPSxdNzJupHsktP1nPW79TJ_8N__xfOaAdP4MBp5g@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 5 Dec 2013 09:01:09 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7779E1E8-5DD9-11E3-8903-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238894>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Dec 5, 2013 at 8:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> * aa/transport-non-positive-depth-only (2013-11-26) 1 commit
>>   (merged to 'next' on 2013-11-27 at b01f05b)
>>  + transport: catch non positive --depth option value
>>
>>  Will merge to 'master'.
>
> Don't. It breaks smart-http [1]. I'm starting to think catching this
> at fetch/clone level is probably better. But I need to add a test case
> to exercise this backfill_tags code in smart-http first.
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/238714/focus=238720

Thanks.
