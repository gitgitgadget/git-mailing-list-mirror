From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] remote-helpers: general fixes
Date: Tue, 27 Nov 2012 18:30:26 -0800
Message-ID: <7vtxsaihml.fsf@alter.siamese.dyndns.org>
References: <1354064495-23171-1-git-send-email-felipe.contreras@gmail.com>
 <7vfw3ujxh8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 03:30:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdXQH-000636-8n
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 03:30:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308Ab2K1Cac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 21:30:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51096 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750889Ab2K1Cac (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 21:30:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34C69AD25;
	Tue, 27 Nov 2012 21:30:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q2gxFpB1IVHoCCVSFUR1odSa5fM=; b=IlCM/2
	dzv8Wt4nbHJhlC+NzZFp6iwZwED9fAPK7RI32hJda/BG2dsAScNJFZTZSt4ElO3f
	pRMLDO4rOpmiRAIQGZDrk9rRfNC5Jo5yM/eiXMR6h0fZwRcucBOzdSMQsqkUTY+s
	mujUnljzR2zPwOZ6WIVfI6np7JBGdBH53kAvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qL8ulxrJ9nDB1eOfEMB0fJdwzXtej6bM
	C0EvHWB7Br41pTHBCp6kzvVM/BHXDHgu/D6JE7Y6akyBca4cQRM0vzTtBFUPxDlT
	jbS6WhVN0PBeoIemi3ybwtncl6f4yHxiOXmhIV0dZ+RIj8roE7PrgTjfiel2pCas
	J7cvLpvXyLQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22A5CAD24;
	Tue, 27 Nov 2012 21:30:31 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 93F63AD1F; Tue, 27 Nov 2012
 21:30:30 -0500 (EST)
In-Reply-To: <7vfw3ujxh8.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 27 Nov 2012 18:02:43 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 940D931E-3903-11E2-8E73-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210676>

Junio C Hamano <gitster@pobox.com> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> These are general fixes, some for old versions of bazaar, mercurial, and
>> python. Some of these have already been sent, but here they go alone so they
>> are not missed.
>>
>> The bazaar fixes are on top of the series v3 which is still not in 'pu'.
>
> Please stop then.  Its v2 has been cooking in 'next' and it won't be
> replaced.

Picked up the -hg bit.  The other two has to wait until
fc/remote-bzr gets updated (but see other thread).
