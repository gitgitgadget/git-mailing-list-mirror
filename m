From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Python scripts audited for minimum compatible version
 and checks added.
Date: Mon, 24 Dec 2012 11:12:44 -0800
Message-ID: <7v7go7nu1f.fsf@alter.siamese.dyndns.org>
References: <20121220141855.05DAA44105@snark.thyrsus.com>
 <20121224133649.GA1400@padd.com> <20121224153257.GA28213@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Mon Dec 24 20:13:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TnDSU-00055T-2C
	for gcvg-git-2@plane.gmane.org; Mon, 24 Dec 2012 20:13:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343Ab2LXTMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2012 14:12:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64822 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753129Ab2LXTMr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2012 14:12:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6586916F;
	Mon, 24 Dec 2012 14:12:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wOspadJ573MnYKlCpZXrCxzXtEU=; b=Q5tg3I
	y13izRWvJnJv4dWnqD3kOFomEAIXXEH3ehSaIVmSMqGAsWnQZkiOPUTj2+XWVz22
	o/o9smKu4qB5RHMGkaLEPqrM/NebrGa9oNHfs0rtuZozNaQvMiileQcWcr8g8rZq
	vOPzciqFOceTV6Ow1dARUivpjAazy0o+UshxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FY/HOXSyQtrTpufAXc7ula0DeLkTtfgb
	kjwDcQh6tEAIot6ll5rvEgwIi56OLI+U+/QysWx18JGVvkxX/zbJWGcWzNX2OvKH
	7aBpTNMEUCgZLywzk+l3dgGXnNGio3jDiIHvcyuYcXCs+00nG/+WBN9QhTdPsY0N
	Xi1QF3U+aII=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1860916E;
	Mon, 24 Dec 2012 14:12:46 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 338D49168; Mon, 24 Dec 2012
 14:12:46 -0500 (EST)
In-Reply-To: <20121224153257.GA28213@thyrsus.com> (Eric S. Raymond's message
 of "Mon, 24 Dec 2012 10:32:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E6680D42-4DFD-11E2-B54D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212116>

"Eric S. Raymond" <esr@thyrsus.com> writes:

> Pete Wyckoff <pw@padd.com>:
>> esr@thyrsus.com wrote on Thu, 20 Dec 2012 09:13 -0500:
>>  ...
>> Many of your changes have these three problems; I just picked on
>> my favorite one.
>
> Should I resubmit, or do you intend to fix these while merging?

I'd appreciate a re-roll, perhaps in a few days after the dust
settles.

Thanks, both, for the patch and the review.
