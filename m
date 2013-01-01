From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2012, #08; Mon, 31)
Date: Tue, 01 Jan 2013 11:51:59 -0800
Message-ID: <7vbod8bs0w.fsf@alter.siamese.dyndns.org>
References: <7vk3rxd9yo.fsf@alter.siamese.dyndns.org>
 <CALWbr2y6M7fZgQb2dizgcBZHTL=TudSc6c-DUOicKHvwahtm9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 20:52:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tq7st-0006aP-7L
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 20:52:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440Ab3AATwD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 14:52:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34780 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752400Ab3AATwC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 14:52:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A62AAAEE4;
	Tue,  1 Jan 2013 14:52:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6XZhj3hkcZGQnMfjNYBcPBOYJh4=; b=wD0SYS
	qEc2DkeMhQXfvKV1IuA63IiYGctBVgOy2bXAfs8N3RczqmddPLCkKmSoatZtexxo
	bu+vx7SYNCQ8gUhKYtAjdtbUy2KnxNnm8u2uZDeg81y29+2IlT9QaBPETdut/paP
	yu0djKWccl6r9dADQyWifwJUnt+rl3XXwTSvs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rRCW0VdzUewXYJ9otWSqzn2UPxORsdbr
	Xnm1CXriSbwW8pGFUy+DrCO4/aZdYvRQSGWakG659v7uNs+ki92O+FyjUBhg/eF3
	nsyu+ra4HIWMIZm7Wy3Ku5exLWj+RT9+0LQgLgiP83XeKGrOUFiIkTd+SDu7Smmz
	f5gXMnlrC2s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9801FAEE2;
	Tue,  1 Jan 2013 14:52:01 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E21E2AEE1; Tue,  1 Jan 2013
 14:52:00 -0500 (EST)
In-Reply-To: <CALWbr2y6M7fZgQb2dizgcBZHTL=TudSc6c-DUOicKHvwahtm9g@mail.gmail.com> (Antoine
 Pelisse's message of "Tue, 1 Jan 2013 16:29:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B53B010C-544C-11E2-8B8C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212434>

Antoine Pelisse <apelisse@gmail.com> writes:

>> * ap/status-ignored-in-ignored-directory (2012-12-26) 1 commit
>>  - wt-status: Show ignored files in untracked dirs
>>
>>  A topic still in flux; will be redone.
>
> I've already redone this part sending two patches (one with the fix,
> and one with some tests for each individual use-case) that you
> probably missed.

It was more like "waiting for the discussion to come to conclusion
and dust to settle".

> Here are the message ids:
>  - <1356878341-12942-1-git-send-email-apelisse@gmail.com>
>  - <1356878341-12942-2-git-send-email-apelisse@gmail.com>

Thanks.

>
>> * ap/log-mailmap (2012-12-27) 10 commits
>>  - ...
>>  Clean up various codepaths around mailmap and teach the "log"
>>  machinery to use it.
>>
>>  Will merge to 'next'.
>
> I'm not sure that should be merged to next yet.

I am sure it is not ready ;-) after discussing the strbuf_grow()
with you.  Thanks for reminding.
