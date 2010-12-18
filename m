From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/4] --word-regex sanity checking and such
Date: Sat, 18 Dec 2010 12:48:44 -0800
Message-ID: <7v4oaahknn.fsf@alter.siamese.dyndns.org>
References: <254678.14296.qm@web110704.mail.gq1.yahoo.com>
 <cover.1292688058.git.trast@student.ethz.ch>
 <201012181724.29916.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Johnson <scottj75074@yahoo.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthijs Kooijman <matthijs@stdin.nl>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Dec 18 21:49:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PU3iB-0003ji-0g
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 21:49:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199Ab0LRUs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 15:48:59 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62462 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932108Ab0LRUs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 15:48:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4E7112E34;
	Sat, 18 Dec 2010 15:49:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1dur6m/TsTI40v4ho8vtE76hYSM=; b=RxRi0z
	mXju8iDBwES6bdL7y+CYlGOx9N10zUc1vJbJt4ZT0kU5iixe0XB1+lch9wntUoPS
	oldalmHRpEe5Fj7sliaeO+m5dgRspDKnv6N49Srm4whu6NTjRNl6bvwEUa1dZ15v
	HZUmMw52ZLSTPkIwyXnXp/Qr+nnipB4ibeU5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WvfMFnmMwTnTbNmvxXUghedUKncsfBI5
	l3/6hBNIcby3fmkrkQSH7vcpwTeQtIv2YIH0hJvfQsdJcMDy4Z4YXfscAxhyONx4
	BO4WvGUK4avgF/m93K78HSID+ElaEKAy8GJUm71DoGiNRdmemYuylUjJbHwVt0F9
	LMRLUeBrwr4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F25692E33;
	Sat, 18 Dec 2010 15:49:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 711792E32; Sat, 18 Dec 2010
 15:49:13 -0500 (EST)
In-Reply-To: <201012181724.29916.trast@student.ethz.ch> (Thomas Rast's
 message of "Sat\, 18 Dec 2010 17\:24\:29 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 494C3588-0AE8-11E0-86C1-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163932>

Thomas Rast <trast@student.ethz.ch> writes:

> I wrote:
>>   diff.c: pass struct diff_words into find_word_boundaries
>>   diff.c: implement a sanity check for word regexes
>>   userdiff: fix typo in ruby and python word regexes
>>   t4034: bulk verify builtin word regex sanity
>
> BTW, Junio, you could move the third patch to the front and merge it
> to maint.  I think it's an obvious fix to a real bug, and it does not
> depend on the other patches except that the test in 4/4 will fail
> without the fix.

Makes sense; thanks.
