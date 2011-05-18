From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add -i: ignore terminal escape sequences
Date: Tue, 17 May 2011 20:52:08 -0700
Message-ID: <7vipt8fyxj.fsf@alter.siamese.dyndns.org>
References: <05ce7ccdb3f4e07724d430f6ea2a8c9730971c9d.1305645331.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed May 18 05:52:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMXo8-0004xf-Cn
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 05:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932813Ab1ERDwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 23:52:19 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52199 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932778Ab1ERDwS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 23:52:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DEE5C5C1B;
	Tue, 17 May 2011 23:54:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fpnYB1LajLLQQWIWjvjU91ZSGK4=; b=WLq21d
	VMynMItZ/SmpcSinvmHduABr7yWYZxiW5kC5s8eugZ4VE8Jm6bPIUk0Tgf6XAXz2
	itibiMHRX9p+nM9a3njhy0y4xQVIdCOa5bpv9b2tPpdB/341lhn74qN0eMHG9PuQ
	p1aye5jg8upmIqFCx5B8c7bIA69SZNlHpqrfI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yj2aphAStJKNP4QHwfrpKqrJR4OkxXaL
	JgVZ+4ToUlLhjxKdMsQXhYyMi6CMFl6UwpMK/yQ29UA0aKZAqDLvw7JLWLZrEyFI
	cdXcT7JH/d+xt3YblFo/GSWDo6AsY3tUhVHfecaoNEKMpU4Ua/aliNzCuP7tt9vI
	tEkpPZqWrrY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AC9275C1A;
	Tue, 17 May 2011 23:54:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 96A995C19; Tue, 17 May 2011
 23:54:16 -0400 (EDT)
In-Reply-To: <05ce7ccdb3f4e07724d430f6ea2a8c9730971c9d.1305645331.git.trast@student.ethz.ch> (trast@student.ethz.ch's message of "Tue, 17 May 2011 17:19:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82D8418A-8102-11E0-A5DE-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173838>

<trast@student.ethz.ch> writes:

> I nearly managed to lose a bunch of uncommitted work today, but could
> salvage most of it from the pieces of diffs in the terminal
> scrollback.  Sigh.

I think the take-home lesson is that confirmation offered in the default
mode is valuable.  The "single-key" mode is another long rope that I would
not use myself, but the users can choose to hang themselves with.

Jokes aside, it may make sense to offer an extra confirmation for "a" and
possibly "s" in single-key mode. Unlike others, they are destructive when
the changes you are splitting from the working tree is large-ish.

> Oh yeah, PS: I'm alive ;-)

Good to hear.
