From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] show: turn on rename progress
Date: Thu, 24 Mar 2011 08:00:38 -0700
Message-ID: <7v39mca7hl.fsf@alter.siamese.dyndns.org>
References: <20110323181756.GA17415@sigill.intra.peff.net>
 <20110323181915.GC17533@sigill.intra.peff.net>
 <7vvcz9cyxd.fsf@alter.siamese.dyndns.org>
 <20110324145047.GB16484@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 24 16:01:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2m2H-0003h9-QI
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 16:01:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933233Ab1CXPAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 11:00:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40173 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757012Ab1CXPAs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 11:00:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 82DF347FE;
	Thu, 24 Mar 2011 11:02:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fg/gi5XRD84r6JQEY1n8vJ9K8OQ=; b=eMUlBM
	jOYXegpkoyz2zjqFHB6KVxVjXzRrLeIBKwz6h6V4yFgr9b80IyMsScxMTWWEiv31
	sdDGdxIZlT0IAJRRhDxarCKV3dZQoxzlqbzvSv1/qbIF2VvXuFFLIysuGhxTVbLm
	SMIDAm7tF5JQJvAFcC+3A+DA5rCkrkZKh0UGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BHNVIDFghrGc92YV/riLfZj7pkYxqVMm
	ipsyVc76dyrFFH+StESCz1ipNwG0PYcNU/YuQroo9mftF3EhgfiCgvgyJrPBvw7i
	cc5Bje/tdAFXQwlkesMTSYJvzjGlB4enGtKN5ajENusa42HK/2RGNIW8zao9u+MT
	ofE53uo6nh8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1560B47FD;
	Thu, 24 Mar 2011 11:02:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 17AEC47F8; Thu, 24 Mar 2011
 11:02:20 -0400 (EDT)
In-Reply-To: <20110324145047.GB16484@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 24 Mar 2011 10:50:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B9AE9D4A-5627-11E0-A0F4-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169923>

Jeff King <peff@peff.net> writes:

> On Wed, Mar 23, 2011 at 02:25:02PM -0700, Junio C Hamano wrote:
>
> We could also turn it on for "git log" in that case, though it is only
> useful if the first commit happens to be the one that is slow.
>
> I should also turn it on for "git diff". I'll prepare a cleaner series
> with that in it, too.

Sounds good, thanks.

> What about the degrade-cc-to-c warnings? Are you working on another
> revision, or should I re-roll your changes on top of my series, handling
> the "one-warning-per-commit" behavior I suggested when stdout and stderr
> are combined?

Also sounds good, thanks.  No, I am spending far more time on ushering
stalled topics than looking at my weatherbaloons and no time left for the
latter.
