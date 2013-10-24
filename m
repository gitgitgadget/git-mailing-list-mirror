From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/19] pack bitmaps
Date: Thu, 24 Oct 2013 13:25:35 -0700
Message-ID: <xmqqvc0mmn5s.fsf@gitster.dls.corp.google.com>
References: <20131024175915.GA23398@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Vicent Marti <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 24 22:25:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZRTS-00033S-HJ
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 22:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754997Ab3JXUZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 16:25:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58682 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754665Ab3JXUZi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 16:25:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 755004D4CC;
	Thu, 24 Oct 2013 20:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=stKdC9Y2Qx13ENF4O8NwdWQJzN0=; b=UZGg5E
	kL4OLh6Q2akPbp9v1kdDA+gf35fC8s5pjZe7bc7WaoNMVY1zF6hFSRyeolR2kh9R
	D4G9uhy5lNy9Qi04J/zVRlr0BIsG6NNDQdspBTH0wPZ4N3gD7s95hQDOh+91dHLA
	XO28vRZzRmkzMw7CTBv60fWIZRsw025IM/G7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aMBSFX5LVlCoMnsvWgZbTPvaMuOk1Wc1
	1YFG+ZoF/+986IKcPuLpkaslVoVV4rDW3YZBKOK10SThLcp3qsb50NKyX8sIQbQS
	+sHuf3adih7O98ZX60dZUq9OGwLX18puM7auPpFg+d3cuCTJcMCr8VPXPKTRFZg2
	uBeaOlzr5+E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 643814D4CA;
	Thu, 24 Oct 2013 20:25:37 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF6AC4D4C3;
	Thu, 24 Oct 2013 20:25:36 +0000 (UTC)
In-Reply-To: <20131024175915.GA23398@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 24 Oct 2013 13:59:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7102FC4C-3CEA-11E3-A456-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236617>

Jeff King <peff@peff.net> writes:

> A similar series has been running on github.com for the past couple of
> months, though not every repository has had bitmaps turned on (but some
> very busy ones have).  We've hopefully squeezed out all of the bugs and
> corner cases over that time. However, I did rebase this on a more modern
> version of "master"; among other conflicts, this required porting the
> git-repack changes from shell to C. So it's entirely possible I've
> introduced new bugs. :)
>
> The idea and original implementation for bitmaps comes from Shawn and
> Colby, of course. The hard work in this series was done by Vicent Marti,
> and he is credited as the author in most of the patches. I've added some
> window dressing and helped a little with debugging and review. But along
> with Vicent, I should be able to help with answering questions for
> review, and as time goes on, I'm familiar enough with the code to deal
> with bugs and reviewing future changes.

Woo-hoo.
