From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] rebase: implement --[no-]autostash and rebase.autostash
Date: Mon, 13 May 2013 06:49:23 -0700
Message-ID: <7v4ne7q9b0.fsf@alter.siamese.dyndns.org>
References: <1368359801-28121-1-git-send-email-artagnon@gmail.com>
	<1368359801-28121-8-git-send-email-artagnon@gmail.com>
	<7vd2svqtqd.fsf@alter.siamese.dyndns.org>
	<CALkWK0nP=RmJHjcFUG2u4pz1ORtPhR7bzi3VvTE=7ggnKbjaQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 13 15:49:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubt87-0001Y2-7q
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 15:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101Ab3EMNt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 09:49:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52746 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752064Ab3EMNt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 09:49:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F29CC1DD3C;
	Mon, 13 May 2013 13:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q7KS2Grzt4rrPu0DxvQjVI0sZ3o=; b=CARKsA
	LG5kGJyn2R2aIGzsK3nAMOsEp5TqK96OoL7l+dV70bB9aJKbU9dXxN4OII/3sFYb
	naSMVwxfxUjJkWKfhz6k8pDRIknAlK4mJz/TOqsxGDuhXTCkQb00IKWYefWMBkT4
	YL0H3tonRIknyP700ajOGYlNuIxDjMOvivu7A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nS2yqUoZu2bWVRaTTz6w8qjZiymQPB4V
	SKbQPjFfoT9tvux58I2P7NHPILv2JcBZlVSazpvmqtw1kjLJcMmhkqqrfuhxqMAL
	wXwyfnaaB6ly0C4zAgwXbHc6uBtya4Rn/yOjbrX7KRqcv9C9dMWNwuKUSSxtx7lF
	u7m9NEzoh4k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8FB01DD3B;
	Mon, 13 May 2013 13:49:25 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F4401DD3A;
	Mon, 13 May 2013 13:49:25 +0000 (UTC)
In-Reply-To: <CALkWK0nP=RmJHjcFUG2u4pz1ORtPhR7bzi3VvTE=7ggnKbjaQA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 13 May 2013 13:33:50 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EC6921EC-BBD3-11E2-8B0F-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224140>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> Writing it like this:
>> [...]
>> with a blank line before the next "echo", it would be more readable.
>
>> This feels funny.  Why not
>> [...]
>> without an extra command substitution with an echo?
>
> I'll re-roll if there are more comments.  Otherwise, can you fix these
> up locally?  Thanks.

No, thanks.  I won't be even taking the patch right now, so you have
plenty of time ;-).
