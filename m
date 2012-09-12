From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Suggestions for "What's cooking"
Date: Wed, 12 Sep 2012 14:49:30 -0700
Message-ID: <7vligec3o5.fsf@alter.siamese.dyndns.org>
References: <7vpq5tjuw3.fsf@alter.siamese.dyndns.org>
 <504F8427.1020507@web.de> <7vhar4gxdq.fsf@alter.siamese.dyndns.org>
 <5050E0CA.7080907@web.de>
 <CAPBPrnu9adK0mPLyVfimAzBEo7ZH+6HhqtLBRFWAvEA9mEGFfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Dan Johnson <computerdruid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 23:49:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBuoc-0007ho-Dj
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 23:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753690Ab2ILVte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 17:49:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64057 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752946Ab2ILVte (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 17:49:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17A4C9C7D;
	Wed, 12 Sep 2012 17:49:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s134xYdpzK+Wi6EGqfBLHhS9u6M=; b=nD8g8G
	jGO82TVq99cSaMM2WDRuU9tEvf8fug4Yp0N/X6Kp+l6rVGlP68kZz0jNmxhuv1Qv
	eSPa2QfoboNeP/1Y1M2DukfLTWN4qmYTm3GvNccpgxYw8j5mDmUsxyKChEJYeMEc
	ctuwf5s9jEUg8MmI8zElptoV1OyM3hXYSn9PI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VirxbG4ucoNgO4ly+y9GRQjVhxIpP0lg
	qlzjI6FOmpPwgznsySvluNWCLTa+OmXwv64Xve05uLKXbJZLXRwVya8cpPx71/lB
	Gf/h2qsHDN4rB22Q9jTq2GMO2QIp1hj7ziSqdbTehBerNf7pnYMNFrPAgHaP9WVI
	knyq765jGf8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 058DA9C7C;
	Wed, 12 Sep 2012 17:49:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 65C1A9C7B; Wed, 12 Sep 2012
 17:49:32 -0400 (EDT)
In-Reply-To: <CAPBPrnu9adK0mPLyVfimAzBEo7ZH+6HhqtLBRFWAvEA9mEGFfg@mail.gmail.com> (Dan
 Johnson's message of "Wed, 12 Sep 2012 16:08:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BC64F97C-FD23-11E1-B6D4-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205343>

Dan Johnson <computerdruid@gmail.com> writes:

> I was thinking about this earlier. I wondered if it might even be
> worth it just to CC the authors of all topics whose status has changed
> since the last what's cooking, to make sure that they see updates
> pertinent to them. I know that I at least have filters which catch
> emails which CC me and promote them to my inbox, so I would see them
> more readily.

I've done that a few times per release cycle, usually before we go
into the pre-release freeze, but doing so manually is very time
consuming.  It's the kind of bureaucratic overhead I'd rather avoid.
If somebody volunteers to write a script that takes something like

    git diff whats-cooking.txt

in a checkout of the 'todo' branch and figure out whom to Cc, and do
so reliably, it may be an option.

Thanks.
