From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Do not search submodules in deep recursive merge
Date: Thu, 13 Oct 2011 11:15:54 -0700
Message-ID: <7v4nzc69lx.fsf@alter.siamese.dyndns.org>
References: <7vipnu9hbj.fsf@alter.siamese.dyndns.org>
 <cover.1318509069.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 20:16:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REPp4-0002bP-U5
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 20:16:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754373Ab1JMSP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 14:15:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50275 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752533Ab1JMSP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 14:15:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E9E04ADD;
	Thu, 13 Oct 2011 14:15:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=R9BjZ7BU6OqAS3Ro+kPE4hcW0q8=; b=W498/TaYDZ6bj9sPuY/y
	QMuuH2VD58ugBqoeVmJN0EwErYfQJKE8jduYhAPu5Mg3rS124JHwXb7pk+NFvAmi
	p3uJdnBXXKAr9zMlhhFlYIaR1PrVcyxKVPrKU3ucgFfOq381GdqCQX8s7kyg4yua
	I5FJ9AEcQnR9w5+X+QTnCy4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=ppsBERlhGUQLxUEEFgpfpjUTcNz9qT7qKlRCfIaehW0fEH
	OaQFvGG1CH1lPJWqatBC6DfbSzyHYrOZ2rK2kWuL+oE7I4UPG8/fdyXCmaO7zcFt
	VdPxWAO7W1S+25A65heIVDBTDFa+sesLKUQqXkwZirYzU2wmdoUr5aNVRhKG4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9463D4ADC;
	Thu, 13 Oct 2011 14:15:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 258914ADB; Thu, 13 Oct 2011
 14:15:56 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 64ECBBB2-F5C7-11E0-9DDD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183503>

Brad King <brad.king@kitware.com> writes:

> On 10/12/2011 2:48 PM, Junio C Hamano wrote:
>> [Stalled]
>>
>> * hv/submodule-merge-search (2011-08-26) 5 commits
>>   - submodule: Search for merges only at end of recursive merge
>>   - allow multiple calls to submodule merge search for the same path
>>   - submodule: Demonstrate known breakage during recursive merge
>>   - push: Don't push a repository with unpushed submodules
>>   - push: teach --recurse-submodules the on-demand option
>>   (this branch is tangled with fg/submodule-auto-push.)
>
> AFAICT these two topics are tangled due revision traversal interactions.
> I've untangled the two "submodule:" commits from this stalled topic and
> rebased on master (34c4461a) resolving one conflict.

Thanks.
