From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2010, #04; Wed, 23)
Date: Fri, 25 Jun 2010 14:17:52 -0700
Message-ID: <7vaaqike0v.fsf@alter.siamese.dyndns.org>
References: <7viq59e6zn.fsf@alter.siamese.dyndns.org>
 <20100624111757.GB3453@pvv.org> <7veifwchb6.fsf@alter.siamese.dyndns.org>
 <40D1B374-E80A-4BA2-B3A2-142E8256C23E@gmail.com>
 <7vtyosnj23.fsf@alter.siamese.dyndns.org>
 <CFE3DCC1-E80A-4EF3-964B-E791D3224F06@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 25 23:18:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSGHs-0002jA-WE
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 23:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245Ab0FYVSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 17:18:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60648 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540Ab0FYVSF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jun 2010 17:18:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 161E3BFC0A;
	Fri, 25 Jun 2010 17:18:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fozNsNq84b8XXRI8ThhrEQJtImI=; b=rLqDHP
	9KcJnG+Ih2z9pqmU1CAQ72ml3wA7T33Evic4iCf7gHoXC3YwDdZqFrl7bVlOOYhd
	xVZr19EuwH7ZraAUhLd29mc9qSnfvGcRs5h2GMysAhpB/wan82Kx+6LEqBP/VKY6
	v2IJttx48rYuomPnfnZABgjtkQ9jpGUewq2Vs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M10/Gf7ogT1NZmopoaW8VUhrW3Wf8SHs
	No8NeFXA4Uq5Q7aaWdyG7S/G3rlj3wwWeI8sycvLcYwadzjmAyITPbqJ2BQqxErS
	+bEplP3WWi71FdFl+bQIlfzqxVm1F7CjEr8SSIO+onlodgFCc6HuN5mmLxH0n5Qj
	o1pGhNZmJ2s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D3ECABFC09;
	Fri, 25 Jun 2010 17:17:57 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 154EFBFC08; Fri, 25 Jun
 2010 17:17:53 -0400 (EDT)
In-Reply-To: <CFE3DCC1-E80A-4EF3-964B-E791D3224F06@gmail.com> (Eyvind
 Bernhardsen's message of "Fri\, 25 Jun 2010 21\:43\:57 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 208720F0-809F-11DF-939F-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149707>

Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com> writes:

> I think it's worth documenting that a well-written ("normalizing", as
> Finn Arne said) filter allows automatic merging of filtered and
> unfiltered data.  I'll see what I can come up with.

Thanks, both.
