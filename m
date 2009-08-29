From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git clone http://git.savannah.gnu.org/cgit/xboard.git segfaults
Date: Fri, 28 Aug 2009 18:10:48 -0700
Message-ID: <7vprafzap3.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.00.0908171620160.4991@intel-tinevez-2-302>
 <20090817135651.GA4570@harikalardiyari>
 <20090826202053.6e6442a6.rctay89@gmail.com>
 <20090826131235.GF16486@harikalardiyari>
 <be6fef0d0908281707o59fdb0c9h9a5a78864b6ad063@mail.gmail.com>
 <7v8wh35tl8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ali Polatel <polatel@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 29 03:11:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhCTE-0003V4-Fi
	for gcvg-git-2@lo.gmane.org; Sat, 29 Aug 2009 03:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbZH2BK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 21:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbZH2BK7
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 21:10:59 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38643 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbZH2BK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 21:10:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 838DA1CA5C;
	Fri, 28 Aug 2009 21:11:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0k4F16FMaFfDOBJS2M5x1tjunHk=; b=UcXIVt
	gYk1CuGiNW/9/19vFVDVqmeaQER7NJhB1ZTp4OAhmrhSETdSqfzT0HJbWDDHWqlD
	HMcI6ibt1MuT2UhzGsFLdOZ7SCEnoB13hfeVL6PJaZNKEwVoqAkHP1AAJ6suBJI6
	T7wtjomq4NMW13RFL+PoF5+09oQjLbNPSSjKw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h3LgRMbozL8gsdpi4kote1zTQmnFNuPE
	zWu7SkeHxeJbcwix9gNGCmr6ricYm5UTiATuesrmxJFoT4ByRMCZV3ESbItTGZHj
	m0QPZJPSo8TWeV5SV7ySxOLBQ/VZn9X4FwmO5eQG2QU+K8ZFYGhn5V5zOA9L05Dp
	jPrrojYpFqI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 43FE51CA5A;
	Fri, 28 Aug 2009 21:10:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3DD921CA59; Fri, 28 Aug
 2009 21:10:50 -0400 (EDT)
In-Reply-To: <7v8wh35tl8.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 28 Aug 2009 17\:53\:07 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CDF9CFB6-9438-11DE-A46F-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127369>

Junio C Hamano <gitster@pobox.com> writes:

> Nobody can expect me to keep track of everything; the final "Here is the
> good one" would help the process flow smoothly and reduce the chance of
> mistakes.

I forgot to add...

In this case, it is _now_ clear to me that you consider your 

    Subject: Re: git clone http://git.... segfaults
    To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
    Cc: Ali Polatel <polatel@gmail.com>, git@vger.kernel.org
    Date: Wed, 26 Aug 2009 20:20:53 +0800
    Message-ID: <20090826202053.6e6442a6.rctay89@gmail.com>

to be the final version, so I'd just add "noticed by Ali Polatel who later
tested this patch to verify; Dscho helped to identify the problem spot."
at the end of the commit log message in the message and apply.  IOW, no
need to resend.

Ali's original report is about 1.6.4 so I presume this is 'maint'
material, so let's include this in 1.6.4.2.
