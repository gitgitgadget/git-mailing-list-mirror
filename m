From: Junio C Hamano <gitster@pobox.com>
Subject: Re: My patches
Date: Mon, 14 Oct 2013 10:42:41 -0700
Message-ID: <xmqqtxgjg35a.fsf@gitster.dls.corp.google.com>
References: <20131012072450.GA21165@nysa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 14 19:42:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVmAK-0005oo-5U
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 19:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757063Ab3JNRmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 13:42:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56990 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756699Ab3JNRmn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 13:42:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EB5A4A9AE;
	Mon, 14 Oct 2013 17:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=LCVckORnzVHvLCRvnmXv4MCvl+o=; b=GYzXsBw71PoIhSP19jAS
	GpK/1CQ2BVhJ99rEyW81jlHquhVJlrvEz7hRADWHrCS8V25FtpqHCb5ASLbw6ysU
	C5d3YiC3e77EPu55rKl3KrjaQtBEel9Ytv+crbrJRUzbI1zR7NxeNwHIkajIswgp
	MHGXA8Vo0LK00tB0plYH+PM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=g2hBwBm6gDMMayjvh3TcgVu7SFYPHBPj8VfkYPN7hVV+u9
	vD0Vmi07IJrJANuQpc2xK8Nmyh8qedPnLhmYGsg7060ZEq3dGY9ptLYmORAHYEoH
	tNgjBz8WhzsdqXvrWcF33PNQc6NKm5zZyRrFP/rLqGhNVJ6TdY180GZMSblmM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3344F4A9AD;
	Mon, 14 Oct 2013 17:42:43 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C9E54A9AC;
	Mon, 14 Oct 2013 17:42:42 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 071390CA-34F8-11E3-9EC7-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236109>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Clearly, a lot of my patches have not been reviewed ...

I think the reason for it most likely is because you earned the Bozo
bit ($gmane/227602) in many reviewers' eyes.

I phrased it differently ($gmane/233347) at the beginning of this
cycle, but I'll say it one more time. I'll refrain from responding
to your messages with anything other than "looks good, thanks". A
patch from you that I do not understand the motivation behind it, or
a patch from you that attempts to solve a problem I see better ways
of solving the same, will not see the usual response from me that
requests a clarification (in the resulting code or in its
explanation in the proposed commit log message) or suggests an
improvement or an alternative.

Such a review comment and the discussion that follows it after a
patch is posted is an essential part of the collaborative
development process in this community and it has helped the quality
of our end product. We unfortunately saw time and again that the
process rarely works when the discussion involves your patches. A
review thread tends not to conclude with a useful patch but instead
descends into an unproductive centithread, frustrating reviewers and
discouraging other people from participating, and ends up draining
the energy from everybody involved, which is better spent elsewhere
to do the real work. It may be reviewers' fault (cf. $gmane/235277),
or maybe the blame lies elsewhere, but it does not change the fact
that we end up wasting a lot of energy without going anywhere.

In short, responding to your patch that is not a simple "looks good,
thanks" material wastes time, harming the community and hurting our
users. That was exactly the reason why you earlier were asked to
leave ($gmane/227750). So I'll try not to respond to them.

I haven't caught up with the list traffic yet, but the way the
discussion that followed a recent review ($gmane/235936) progressed
tells me that things haven't improved much, so the assessment above
still seems to hold true, at least to me.
