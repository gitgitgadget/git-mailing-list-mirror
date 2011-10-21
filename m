From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/pack-objects.c: Fix a printf format compiler
 warning
Date: Thu, 20 Oct 2011 17:17:31 -0700
Message-ID: <7vr5278ag4.fsf@alter.siamese.dyndns.org>
References: <4E9F20AD.4020209@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dpmcgee@gmail.com, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Oct 21 02:17:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RH2nx-0001ym-F0
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 02:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039Ab1JUARe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Oct 2011 20:17:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55524 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751946Ab1JUARe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2011 20:17:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A7E06ABC;
	Thu, 20 Oct 2011 20:17:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qKzoG9ksdhRYgACVzTNsdmeZQ5o=; b=Yx2csp
	roWXvgdG6o2sBUZXprZkqz4AiPkkZtm9iw//F0JjTlvBooWAqnm2clAiWnkyJQlV
	1GuDyFV4NFSTv5CdgeRsf1E5mVc1VCIYjPed0V4CgkEWUw/mdDUavgvy7O9zmLF8
	hldOeaKm9L3L+4EAB/3Ap1X13GZH51JNxoaxo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ME9gZ4jkLmNQDwgm2HcVxkAE9Mykxk4d
	bStiCq8hYd+GlGBZPYIU8lC7vbH3ZxmneVpVPD35BDf7Dv38PkNCdajr7LJrwPxo
	ETqntAUFgWVnZGSQNn14nPPlT0PfNNuGbVCPWgvX0Ovri8uLnb4vLEWnunHyKmod
	yy8cw3b5jss=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 414AD6ABB;
	Thu, 20 Oct 2011 20:17:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA7026AB7; Thu, 20 Oct 2011
 20:17:32 -0400 (EDT)
In-Reply-To: <4E9F20AD.4020209@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Wed, 19 Oct 2011 20:10:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 120AEB90-FB7A-11E0-890B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184045>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> If you don't need to re-roll, then I'm hoping Junio will notice and squash
> this in before it hits next. ;-)

Will do; thanks, both.
