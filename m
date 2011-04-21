From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 0/5] Date Mode: Add --time-zone; deprecate --date=local
Date: Wed, 20 Apr 2011 18:50:43 -0700
Message-ID: <7v62q8z824.fsf@alter.siamese.dyndns.org>
References: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
 <20110420064318.GF28597@sigill.intra.peff.net>
 <4a235331-951f-481e-8603-896af4e67df9-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 03:51:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCj2p-0006VJ-QY
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 03:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509Ab1DUBuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 21:50:55 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57001 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012Ab1DUBuy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 21:50:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1B43D4487;
	Wed, 20 Apr 2011 21:52:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6ktChm+raWJV0ixH/MXP1WHsnV0=; b=oNv7X/
	lDDRqnxi6JT6Twgf+q3dk4vuXrXo96XVo5iXut/eWZo9PsFy8Gx/RLu2tnSr+0uB
	Xfc/vMoDVqbNNi60KkeQiK1gFzD+o5QxpDEl7mUtbYNYx7C5a9JRpRKaOSLNp8T4
	SC1/v489c7SfK5uMjHA98GP8EMx8V4lR4zsKM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X6f9TSUITlnreUMnjaeOe+0S0T0Y8mos
	iUNEr8W57qFF4L53Qzl9eI4MUG0Hi/ooa1HxvEBut7nLd0VkXReB1wWZr65Aom0H
	hK5PlD0SCFYxA03+pvHKdVSwDzW3c+t+ECg/2QUsyQg6ho4MWgaemjLxrY3Ed4YJ
	lBBcLrRHmOQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DB4A64484;
	Wed, 20 Apr 2011 21:52:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CFC6A4482; Wed, 20 Apr 2011
 21:52:44 -0400 (EDT)
In-Reply-To: <4a235331-951f-481e-8603-896af4e67df9-mfwitten@gmail.com>
 (Michael Witten's message of "Wed, 20 Apr 2011 14:21:11 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F6F7BF8-6BBA-11E0-9BF3-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171886>

Michael Witten <mfwitten@gmail.com> writes:

>> I think the intent of this series is good. See also this thread from
>> quite a while back:
>>
>>  http://article.gmane.org/gmane.comp.version-control.git/112026
>
> I took a cursory look, but I've spent so much time on this series already
> that I don't really care what it says...

This is not a very good way to motivate somebody who is already tired at
the end of the day to reivew the RFC series, I would have to say.
