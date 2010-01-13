From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] commit: show interesting ident information in
 summary
Date: Wed, 13 Jan 2010 12:50:42 -0800
Message-ID: <7vljg1lof1.fsf@alter.siamese.dyndns.org>
References: <20100112153656.GA24840@coredump.intra.peff.net>
 <20100112154631.GC24957@coredump.intra.peff.net>
 <7v3a2asda8.fsf@alter.siamese.dyndns.org>
 <20100113173050.GB21318@coredump.intra.peff.net>
 <7vbpgxn5ui.fsf@alter.siamese.dyndns.org>
 <20100113201708.GA23018@coredump.intra.peff.net>
 <20100113201843.GB23018@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Adam Megacz <adam@megacz.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 13 21:51:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVAB9-0002oe-07
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 21:50:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755287Ab0AMUuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 15:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755258Ab0AMUuz
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 15:50:55 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49529 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476Ab0AMUuz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 15:50:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 73F8D90591;
	Wed, 13 Jan 2010 15:50:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EI4MGHlNnlLKFXeaYLr1hWHIlh4=; b=Tgs+f1
	Ux3ZVj/fzKfFf2aw4kWe/xXSnLrLXGPmw2XvzzIhWJnVeE4Y+gwWlJfCJz88qL5U
	Zz9OiEJtALjqpVqPcZ6oS278qtduajaHPgPHaSuLLTlHaPcCEA6tmvF0NcF//uAQ
	LphJcoihGpex8OF8JdHV1BGzNCQQBDpYtnvbk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vT82Rzxh+KG9E/t+ubmrdYA7fuU4bkTS
	kZ6iPw6TJlx/VrZJuJDs3YJ6AQzhfJlKah/SsLvuUF/5450LC5Q45NKy9ezxjpvx
	XKI/rrRW++11Y7NbqtGY3AYkH9a+klgWlEKydUIq2lc3rMpgPJADGmYfIbg7dofB
	tLLb6mXeXsM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E00B90590;
	Wed, 13 Jan 2010 15:50:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 40E9390583; Wed, 13 Jan
 2010 15:50:45 -0500 (EST)
In-Reply-To: <20100113201843.GB23018@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 13 Jan 2010 15\:18\:44 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5505496E-0085-11DF-9853-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136885>

Jeff King <peff@peff.net> writes:

> On Wed, Jan 13, 2010 at 03:17:08PM -0500, Jeff King wrote:
>
>> Even outside of competent maintenance or individuals being served by
>> ISPs, I think it is really that it is no longer the case that the
>> machines we get our mail on and the machines we do our work on are less
>> and less the same. Even as an individual, I can afford a Linux
>
> Er, re-reading that I think I have too many negatives. But hopefully you
> get the point: "it is less and less the case that..." or "it is no
> longer the case that..."

Yes, I am in full agreement with everything you wrote in the message you
are responding to, including the comments after three-dash line about
showing the "Committer: " line even when the advice.implicitidentity is
declined.

Thanks.
