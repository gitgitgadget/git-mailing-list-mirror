From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2013, #07; Thu, 20)
Date: Fri, 21 Jun 2013 11:26:19 -0700
Message-ID: <7vehbvmib8.fsf@alter.siamese.dyndns.org>
References: <7v1u7woydw.fsf@alter.siamese.dyndns.org>
	<CALkWK0=1e5ospzJBqaz9iLwSiOoTy_+vTxwVMvW-H7kynfkbBg@mail.gmail.com>
	<7vk3lno40x.fsf@alter.siamese.dyndns.org>
	<CALkWK0kDDRicX9VmcRgG9daXVi6W-zGNt=x6ruy7X5MhrHOZbQ@mail.gmail.com>
	<7vtxkrmlz5.fsf@alter.siamese.dyndns.org>
	<CALkWK0mUcJ1f0xP2w-fUFr-tMSKMX23_nmYQUYXw3zjw7Hm9GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 20:26:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq62V-0002hQ-Nc
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 20:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945929Ab3FUS0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 14:26:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38555 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945926Ab3FUS0W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 14:26:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBDFD2A711;
	Fri, 21 Jun 2013 18:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BV0NdGMhIJv8SKZ7wFwaOxi0+wk=; b=nHCspo
	povuiNmTT3sO+YeOEphS7zoEjCOlewiFMePqMmWBUGjyKSs0MOi6jqnMGk07g8Vw
	Mlj8vg3XkMNqKIKrGuvgAFj+92/ptak+x5xgigrQexmunXTaAq82P8nVdLJWBLAQ
	dag/o9E6jROG0rHvcuB3BMiGniYxaATaPjhh0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=akyPWgZQ6W3sIRvt4+v0K9pmHsQ/bbxR
	xz5CsSqtPQS0Z9l1FdirUhxiNwsNEPq0wT986MZuowdO78qx/ibDJbTz4Z0q7SVi
	ROMb/OLnqb9jK3pB8WAKmch3f7EV66sHazgSib1hVfTTReTLmCzhIEQIUGGCOtyk
	yOhcQiZPKgY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1DE12A710;
	Fri, 21 Jun 2013 18:26:21 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2EC2C2A70F;
	Fri, 21 Jun 2013 18:26:21 +0000 (UTC)
In-Reply-To: <CALkWK0mUcJ1f0xP2w-fUFr-tMSKMX23_nmYQUYXw3zjw7Hm9GQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 21 Jun 2013 22:43:20 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 12593AFA-DAA0-11E2-96B9-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228643>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>>> ...  I've noticed a significant decline in
>>> list-reviews in general: a lot of good code on the list hasn't been
>>> reviewed.
>>
>> Hmph, I do not particularly see that happening.
>
> Observer bias.  To verify either claim, could you run some stats on
> the ML archives [1] and report the results?

Unfortunately, I tend to become bottleneck more often than you do,
so I do not think that would be a good use of my time.

Which ones went unreviewed that are of high value?
