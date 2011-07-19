From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC update] Sequencer for inclusion v2
Date: Tue, 19 Jul 2011 16:54:43 -0700
Message-ID: <7v62mx967w.fsf@alter.siamese.dyndns.org>
References: <1311095876-3098-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 20 01:54:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjK7o-00032B-Mx
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 01:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432Ab1GSXyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 19:54:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48113 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752262Ab1GSXyq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 19:54:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 610894895;
	Tue, 19 Jul 2011 19:54:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5kgU8GP+XDs9vam13kZo8nBUOW0=; b=W1bt+o
	MutU18V+6yAKMT+SjhiR0RuwPK52+DiKR/2RrDTzeRCZtWlqdbrJb7YP/rB01ne7
	v7sjMwNnDVcC01f8AcV4O+NFzDx/aFRWDR46GIPpR4HPuJNHI6e0Z2GV+l0XPJpy
	5TiS5LZw7+kRt5P0074+RLf3zW85ixXbZF/vc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mfIfKK8Ea0ow6NN+wcqyS8X31aF5z/DG
	Kt4cgxZ01+6woBJHbqK98RzwP6ISiwh1KbRiyx72jVcmSWFoLPmx/dI6scpJ6XYJ
	jnkCJ62COc8ftkREx6Zq8ahOnILjaD5Fmk4sZbSEHIXtZ8XsHXJMuHNG3DNTtcPr
	vsQdYKZFM7A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 582E24894;
	Tue, 19 Jul 2011 19:54:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E493B4893; Tue, 19 Jul 2011
 19:54:44 -0400 (EDT)
In-Reply-To: <1311095876-3098-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Tue, 19 Jul 2011 22:47:38 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7A4C748C-B262-11E0-8039-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177514>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Mid-term is over, and I'm disappointed that I'm behind schedule -- I
> haven't been able to get the Sequencer merged yet.  The reviews have
> been incessant as ever, and I spend most of my time chipping
> everything to prefection.  On a positive note, the series looks like a
> beautiful work of art now; I never imagined that it could be this
> beautiful :)

Applying these to the same base commit as the previous series was queued
and comparing the result does show this round is indeed nicer. Haven't
started nitpicking the log messages, though ;-)

Thanks.
