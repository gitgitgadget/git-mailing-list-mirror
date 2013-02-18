From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v1.8.2-rc0
Date: Mon, 18 Feb 2013 15:09:11 -0800
Message-ID: <7vobfh8bjc.fsf@alter.siamese.dyndns.org>
References: <7vk3q6e94s.fsf@alter.siamese.dyndns.org>
 <vpq4nh9v5an.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: linux-kernel-owner@vger.kernel.org Tue Feb 19 00:09:48 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1U7ZqF-0002LV-MU
	for glk-linux-kernel-3@plane.gmane.org; Tue, 19 Feb 2013 00:09:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757600Ab3BRXJQ (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 18 Feb 2013 18:09:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37212 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753601Ab3BRXJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Feb 2013 18:09:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C951BBF52;
	Mon, 18 Feb 2013 18:09:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/DKBmTlEH60JG7tUC3MlZJAhm0U=; b=FKlZ4S
	1jaQzopXOdBDqM6kk0d/BK3Uu1BfHIHYWf0stxkdUuBDjxJ3HG8z8cF4bB8MOr4s
	yDx1mnhuVYP1HiFIdjhFeOXp8ilzd5bvZbXdTIQ97lyE8lPUI8ck0HrcS/7awezk
	qKP1pA89SG7ENPTAh94kP4vE4HdH4wMoLk05c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yT55V2ZHwO8EhvwJUom/HFBBxXBs27ON
	9CjLoq1NNOeZdrayBnmosTsqlPqoESCR3mLYF9nM+VbZ6gPAwExioZBGPunpwbk6
	N+j5Gw7K9n/FTu6zWGp18qiZloYIr6gCBBbf2TfluKHHf4D/K/9McsVrCFTo49Ck
	r7QahefA0nY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BDE69BF51;
	Mon, 18 Feb 2013 18:09:14 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 36D22BF4F; Mon, 18 Feb 2013
 18:09:13 -0500 (EST)
In-Reply-To: <vpq4nh9v5an.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Mon, 18 Feb 2013 19:35:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3641256C-7A20-11E2-9827-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216549>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Git v1.8.2 Release Notes (draft)
>> ========================
>>
>> Backward compatibility notes
>> ----------------------------
>>
>> In the upcoming major release (tentatively called 1.8.2), we will
>> change the behavior of the "git push" command.
>>
>> When "git push [$there]" does not say what to push, we have used the
>> traditional "matching" semantics so far (all your branches were sent
>> to the remote as long as there already are branches of the same name
>> over there).  We will use the "simple" semantics
>
> I don't understand: wasn't this supposed to happen in Git 2.0? Did you
> mean "In the upcoming major release (tentatively called *2.0*)"?

Thanks.  I am not sure what I was thinking.  Perhaps when we started
this cycle we did want to merge the push-2.0-default-to-simple series

Will update.

> Also, you may want to mention the argumentless "git add -u" change too.
> It currently has an item below, but this is a future
> backward-incompatible change so it may deserve to appear in this section
> too.

Quite right.  Care to do the honors as the proposer to the new
direction?
