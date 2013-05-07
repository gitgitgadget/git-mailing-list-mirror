From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revision.c: Fix a sparse warning
Date: Mon, 06 May 2013 18:21:06 -0700
Message-ID: <7vehdjpou5.fsf@alter.siamese.dyndns.org>
References: <518544A4.4080202@ramsay1.demon.co.uk>
	<51854FE5.4050907@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Tue May 07 03:21:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZWav-0001Yf-5p
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 03:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759354Ab3EGBVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 21:21:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49584 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758586Ab3EGBVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 21:21:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29F3C12168;
	Tue,  7 May 2013 01:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T8MisdIhn4hbBgnqy+gmrmZcI98=; b=mM7gQ8
	JeGq0CyRtxvZtzHUk1o4LTIMHOci8BhvIqK18B2ZfSMf5jlAqXOdFFtaupapN2Rp
	jVuUKk9rom4JjqnS3RzEEe46Ik1WU8BB/plcioitwIeqVNXYE0vTwbdI32nqbfPF
	XgvqLF/GgdYficmXxo9Uwqp+qdbugU/wwmSJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x0mIrr/mk59ZM6VZejkLnjUQhdxeF2a8
	SQkaKkYoIM4Vv0DrExHWirntt53/Av833GGl9Vdm5efldRlCrtFKSjTOcNwFajwE
	XCwubgzKbbwSveMir1pLzmSczwDhJBLrJpVk1yzMYNnEd1riHfGozkPLIdX2SvLJ
	GinL1JAtE9Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2119012166;
	Tue,  7 May 2013 01:21:08 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 90D8712165;
	Tue,  7 May 2013 01:21:07 +0000 (UTC)
In-Reply-To: <51854FE5.4050907@bracey.fi> (Kevin Bracey's message of "Sat, 04
	May 2013 21:13:57 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 64CC2E56-B6B4-11E2-9135-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223515>

Kevin Bracey <kevin@bracey.fi> writes:

> On 04/05/2013 20:25, Ramsay Jones wrote:
>> Sparse issues an "'sole_interesting' not declared. Should it be static?"
>> warning. In order to suppress the warning, since this symbol does not
>> need more than file visibility, we simply add the static modifier to
>> its declaration.
>>
>>
> Thanks! I'll include that fix.

Thanks.
