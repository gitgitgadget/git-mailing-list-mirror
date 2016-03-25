From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] api-parse-options.txt: document OPT_CMDMODE()
Date: Fri, 25 Mar 2016 14:24:43 -0700
Message-ID: <xmqqvb4a1c9w.fsf@gitster.mtv.corp.google.com>
References: <01020153a7e08100-cf66fc9f-7293-4d8c-98c6-f322721c741f-000000@eu-west-1.amazonses.com>
	<01020153af24cfbc-a145ad2b-0cc2-4378-bce9-6b1f68251ce8-000000@eu-west-1.amazonses.com>
	<CAFZEwPOaqZmE4oUy7PWDNv_Qvz+hPgZH2YO6VKk5XUtGYL-ziQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 22:24:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajZDw-00058A-2h
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 22:24:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754489AbcCYVYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 17:24:47 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:64713 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754381AbcCYVYq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 17:24:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3A1DD4ED95;
	Fri, 25 Mar 2016 17:24:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KWxi7Jhs7vuAA5VLeV+LzkoL3eY=; b=pVo3cS
	wjpbf1bZT0We8+aBk/nE/Qaham/hBNAdY2aMvS8eE/Ya6epDjqT3vxK4KWQQM7HC
	FExGjV/XVhc0Ut8uwSvSNwFJJbvGoPyTt57dqIokPSJRTfmodMkSvyoNKWU+rYTe
	wzIyiAad7qZb+5nrJekEguo3bYl4k7u470yuM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vo2tiJc8vxu+ERRkEXDaADLLzlziTTR3
	ekI0YCjtjtbrkarqB9ORCtTWzfLRQAg1MqBQ+AZGeDwk8JehjAxEHTQ6mOgxgdjN
	8yFsr/OTwbF5UcZmmJTyPfIIoOd2u+Z/y6rZJJkh9wnJKd0eVCK/eYQYYVfGhYSH
	ZVecienjnAw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 315B34ED94;
	Fri, 25 Mar 2016 17:24:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A35954ED92;
	Fri, 25 Mar 2016 17:24:44 -0400 (EDT)
In-Reply-To: <CAFZEwPOaqZmE4oUy7PWDNv_Qvz+hPgZH2YO6VKk5XUtGYL-ziQ@mail.gmail.com>
	(Pranit Bauva's message of "Sat, 26 Mar 2016 00:38:44 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FE8383F0-F2CF-11E5-84AB-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289954>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> I have used bits from your email. I forgot to add "Helped-by: Junio C
> Hamano <gitster@pobox.com>" . Could you squash it in?

It's OK to omit such a credit for a patch this small.  After
understanding the issues, you would have written essentially the
same thing yourself.

Thanks, queued v2 already.
