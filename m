From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.7.7.2
Date: Wed, 02 Nov 2011 15:30:01 -0700
Message-ID: <7v1utqi2dy.fsf@alter.siamese.dyndns.org>
References: <7v7h3jl3kw.fsf@alter.siamese.dyndns.org>
 <20111102214725.GA2860@geminga.roas.networks.roath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
To: Stefan Roas <sroas@roath.org>
X-From: linux-kernel-owner@vger.kernel.org Wed Nov 02 23:30:22 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RLjK9-0006uQ-0y
	for glk-linux-kernel-3@lo.gmane.org; Wed, 02 Nov 2011 23:30:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752935Ab1KBWaJ (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 2 Nov 2011 18:30:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57426 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750786Ab1KBWaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2011 18:30:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8315D6984;
	Wed,  2 Nov 2011 18:30:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HQvKckIwIS+6/sHuiUSbqEFFYFU=; b=V5AscV
	VGbvsSJO9Sl5G95WZ3YJe9nmp6IzxtFN7A/SS7JD2dRiGgY2aguda1h/7iWkn8zj
	1LOGKwCEZyNSvc7CMi5ZgG8niYJTzwjmHmAqp7U5Z/d5u34/rRK7gZYZ965hmj1I
	HPC9VxNiR31mNunsRq+vvSpaLnZD0/s0iXVeA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tt0c6NL5dPy2P0P1bLyeJ3fyfvrWRhov
	X9OBW6S/830lrY5tH9hd2bX1LDrDVgCpEzJGPe4F/z5OggzrhMpydEm6qf52YT+q
	iMrI1dS/ImLlgW+Z4IRQy9rcwdMQODTVONQZ7I0+1wa3ReQXbgsAUgI29gzzXN4I
	QFE0BrzKaHA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 711226983;
	Wed,  2 Nov 2011 18:30:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C91D96980; Wed,  2 Nov 2011
 18:30:03 -0400 (EDT)
In-Reply-To: <20111102214725.GA2860@geminga.roas.networks.roath.org> (Stefan
 Roas's message of "Wed, 2 Nov 2011 22:47:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3581956A-05A2-11E1-9146-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184676>

Stefan Roas <sroas@roath.org> writes:

> is it possible that you forgot to update the GIT-VERSION-GEN with the
> release of 1.7.7.2? I stll get version 1.7.7.1 from the tarball on
> http://git-scm.com/ and when building from the git repository itself.

Probably.
