From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Merge made by recursive?
Date: Wed, 25 May 2011 13:17:54 -0700
Message-ID: <7vei3m3571.fsf@alter.siamese.dyndns.org>
References: <loom.20110525T192418-887@post.gmane.org>
 <7vvcwy37de.fsf@alter.siamese.dyndns.org>
 <20110525195032.GC27260@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Ligocki <sligocki@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 25 22:18:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPKWx-0007GJ-4U
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 22:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754806Ab1EYUSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 16:18:05 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54154 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545Ab1EYUSE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 16:18:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A820850C3;
	Wed, 25 May 2011 16:20:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bNeYvmYRY0WYUPa5By864NUNHWg=; b=Q+wAD5
	gmPlKPkMbi8/vauj3yZYHOpnW4VbkACdFgbGohPMQAStT0SA5Q0pRXJWU3Q6ORXp
	4OiY8g9bML7cwKO5GAugIfaB9Tr4thmlt/PHMLoRqk3xDOpF9RWGf+Dqu6lx33Ln
	9Wm6upn0coDBpVOYB2xPFvq+AfmO4y1U+vF7A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IVe7eA0u8mQwYErYAP8e1XL8GcfPRFpH
	cghW+6H5lyT35SeixwIaDN3oP+Il5+oSFyMjWr8X8mauD9sJBaIoabCafUwJ05cD
	CDQjurAj6OTP2Kagdgak05u+HqbYbEFFFMvoTSSU9ukfcux+QSmlFHN9iA1gbp8R
	u5Kh6ijOao8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 76F3250BD;
	Wed, 25 May 2011 16:20:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5E4FA50B6; Wed, 25 May 2011
 16:20:03 -0400 (EDT)
In-Reply-To: <20110525195032.GC27260@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 25 May 2011 15:50:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 61F3586E-870C-11E0-A0D1-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174460>

Jeff King <peff@peff.net> writes:

> Also, most of the rest of the merge output has been gettext-ized, but
> not this message. If we are going to declare it not parseable, should we
> also be internationalizing it?

Heh, great minds think alike. I was wondering about that while I took a
brief walk after sending it out.
