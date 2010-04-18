From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] Documentation: Describe other situations where -z
 affects git diff
Date: Sun, 18 Apr 2010 13:44:39 -0700
Message-ID: <7vbpdgwkw8.fsf@alter.siamese.dyndns.org>
References: <9eaa7a4672f2010c9e6e3b3f473f1c09abcfcc45.1271614677.git.charles@hashpling.org> <20100418182817.GC29329@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Sun Apr 18 22:45:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3bMR-0004ug-Po
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 22:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675Ab0DRUoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 16:44:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51336 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438Ab0DRUox (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 16:44:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 016A0AB6DF;
	Sun, 18 Apr 2010 16:44:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Mw1YIw2AiJE45WqmcxpUbwjrmCQ=; b=gt14Mp
	kDzA8YsV7euq3fczpw31QB78bOFxCpt/1AVliDtDxxSwEBiNO/T7PCOYnmC/wBND
	FWKh5HkTwPY0pXTbcFM9WHX1p3V7lzJGRy2F/O07g647+HqN94Up9heTZmB6i2b7
	93zP3hPpuYxtYgFV+hhTCctBudKfPCwVNhRXM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yO6+ATbno7MYELh8QVchPLSmCbsjGw2b
	fjHVxCwZE+US3RWOHhVIFNE75uDyqm0uod2ikBXBw0ROErl+bv7/uM5kVwAlSApF
	Ofk4tPQGrqXaiJsr82g12EAWkqCHWaVMn8omWnCnmGt9EElveY/sg+E64zzo72it
	44yviQjOX50=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B2AB8AB6DD;
	Sun, 18 Apr 2010 16:44:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C92BDAB6DC; Sun, 18 Apr
 2010 16:44:40 -0400 (EDT)
In-Reply-To: <20100418182817.GC29329@hashpling.org> (Charles Bailey's message
 of "Sun\, 18 Apr 2010 19\:28\:17 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 39A2217E-4B2B-11DF-A6A7-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145245>

Charles Bailey <charles@hashpling.org> writes:

> -z also alters the behaviour of --name-only and --name-status.
>
> Signed-off-by: Charles Bailey <charles@hashpling.org>

Thanks; this is good, independent from the other patches, for 'maint'.
