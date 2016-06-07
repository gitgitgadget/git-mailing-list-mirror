From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] t1404: document function test_update_rejected
Date: Tue, 07 Jun 2016 12:25:37 -0700
Message-ID: <xmqqeg88pzri.fsf@gitster.mtv.corp.google.com>
References: <cover.1465299118.git.mhagger@alum.mit.edu>
	<2561c38f85648144d665e870ca42c133a3a78909.1465299118.git.mhagger@alum.mit.edu>
	<5756FCF3.7050509@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	David Turner <dturner@twopensource.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= Duy 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jun 07 21:28:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAMdG-00034x-Ml
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 21:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbcFGTZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 15:25:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53963 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755260AbcFGTZl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 15:25:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B7A4823547;
	Tue,  7 Jun 2016 15:25:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5DC45fpFXGDC/RH2SF81ReNZa0k=; b=AnTNma
	T8xfKIxLxtCFpjfX4hRHKRkbOjVdnLkvhOjEjdkCCyWi3ciT+W9LGz9akzRqyK7f
	1BYTNKF80dLWNf+NbKnOU/w8hSufCB+fVLBvOjYkxoLmwmEG9KINBcEGycsRmVzV
	6dLugwDGzeHZ1q0vUWWQarFRlDjUvg2R2e/+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lKjSqWYrRwaHXiEzjzIVMPUccei2xnQh
	4Qbr6ySgMY2zKcj9cYSfSMiT/ogkkPtAgTTKaU7/WsoHqlSqpcWIwSsxyC2UYJz1
	ucXskJB5HttCYxQCys6Nyey2rXQpMTUDFvq9WsEUS+4pVrdVCU3d5gwQbEVQIp2f
	Pcuddu3mGcQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B066A23546;
	Tue,  7 Jun 2016 15:25:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2C2BC23545;
	Tue,  7 Jun 2016 15:25:39 -0400 (EDT)
In-Reply-To: <5756FCF3.7050509@kdbg.org> (Johannes Sixt's message of "Tue, 7
	Jun 2016 18:57:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9E132DF4-2CE5-11E6-BFF0-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296712>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 07.06.2016 um 13:50 schrieb Michael Haggerty:
>>   test_update_rejected () {
>> +	local prefix before pack create error &&
>
> Do we want to add more of unportable 'local' declarations?

Not really ;-)  Thanks for catching.

>>   	prefix="$1" &&
>>   	before="$2" &&
>>   	pack="$3" &&
>
> -- Hannes
