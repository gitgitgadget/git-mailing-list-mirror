From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Difference between --date-order and reverse chronological order?
Date: Wed, 27 Apr 2011 10:36:24 -0700
Message-ID: <7v7haf8ulj.fsf@alter.siamese.dyndns.org>
References: <12e0244a-313e-4d67-9b91-c0d443276cff@k7g2000yqj.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 19:36:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF8fI-0005td-CA
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 19:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756633Ab1D0Rgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 13:36:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64584 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275Ab1D0Rgf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 13:36:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B7CFA4B56;
	Wed, 27 Apr 2011 13:38:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QT84GJrA4ROHtvcoiR3WK3WFjkc=; b=gssFTz
	n7CW8l+CM1SvfyuLIG0kr8RMkOsJXY8cWBrDmynhnC4KXqJuMYFQpbAF53keaHur
	kmrtGZP54ClXw7KRzlNK7d96v/HMYKo4A8oM9fuT1nXe/8qUlTZ1wfLJRZMGm35J
	+buNI/ZNqbVaWG5JhnfgVFV/i3T7p8l1xUxGU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O17PsphScc0B/6cne1l0dktpaVbLDs/o
	sLoXjDJKZ3GgLvsAtRHeqlLBN3KJwBksswOYSNw3CMtSTcb9cZ8fmnTwx1H4OkP7
	bkjsAFgyqHZVjhyaz0anrA8WMAAC9tdFC1UzCHj6jX2T8b0uZS4Aud5sSuJhebRW
	b3UOrgO46mY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 972B04B54;
	Wed, 27 Apr 2011 13:38:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B78A04B48; Wed, 27 Apr 2011
 13:38:28 -0400 (EDT)
In-Reply-To: <12e0244a-313e-4d67-9b91-c0d443276cff@k7g2000yqj.googlegroups.com> (Dun
 Peal's message of "Wed, 27 Apr 2011 08:15:06 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2B366BAE-70F5-11E0-8628-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172253>

Dun Peal <dunpealer@gmail.com> writes:

> But by Git's definition, for a child commit to be created, its parent
> must already exist. So even in reverse chronological order, all
> parents should come after all their children, no?

I think "distributed" and "your clock may be skewed" would solve that
puzzlement ;-)
