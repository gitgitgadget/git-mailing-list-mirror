From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t0006: test timezone parsing
Date: Tue, 06 Jul 2010 22:28:15 -0700
Message-ID: <7vk4p7274g.fsf@alter.siamese.dyndns.org>
References: <20100704104834.GA23070@sigill.intra.peff.net>
 <7vpqz13xgw.fsf@alter.siamese.dyndns.org>
 <20100706072849.GA3567@sigill.intra.peff.net>
 <20100706075433.GD3567@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 07 07:28:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWNBM-0008Mo-Fh
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 07:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922Ab0GGF2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 01:28:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40852 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877Ab0GGF2X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 01:28:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AD269C241C;
	Wed,  7 Jul 2010 01:28:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=6B2NNSV7Jb4cbOtpGJQsCaOeItA=; b=CoJzRMgO9W5wXe5afgru/m8
	PdyVsSh/bKrrUbLyN9DDYZVTD5fdk4XueHT2jhM0GLGcxo3B5wnidRpx0xPIpgrm
	oDHJeCWM4rJRrFEniHnp6M8RQdpoeMY2EYyQL5617FPYwlcTC8+kBiSzVPqjEvp8
	vMDnflPy2h5Fa3GcOF1U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=VzJO4qv/iINpV90byNsEhB0VO9RyrokBeJb7PgQ1xvxTax685
	e0SzQE58A9FNGFJ3VHxG5WqAljmLgHIwBwbpJd1RTnBxQZe5liNLMXhUy4AU7hvB
	0heW8bVmEoeKJ/UNC4j1xMHFK4fC2FxyEkXQaNdMJaxr0Hx/MWLBq8Hf7w=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 740ECC2419;
	Wed,  7 Jul 2010 01:28:20 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B47C3C2418; Wed,  7 Jul
 2010 01:28:16 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7450564C-8988-11DF-B757-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150446>

Jeff King <peff@peff.net> writes:

> On Tue, Jul 06, 2010 at 03:28:49AM -0400, Jeff King wrote:
>
>> > On FreeBSD 8.0, we now see this.
>> > 
>> >    cc1: warnings being treated as errors
>> >    test-date.c: In function 'parse_dates':
>> >    test-date.c:28: warning: format '%ld' expects type 'long int *', but argument 3 has type 'time_t *'
>> 
>> Meh. I was worried about that when I used sscanf. I think we can just do
>> this:
>
> Oh, I see this is already on maint. :) So here is my fixup in a nicer
> form:

Thanks.
