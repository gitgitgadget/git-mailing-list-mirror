From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/4] grep: support to match by line number
Date: Mon, 02 May 2011 12:08:54 -0700
Message-ID: <7vy62oly2h.fsf@alter.siamese.dyndns.org>
References: <cover.1304318972.git.bert.wesarg@googlemail.com>
 <7vfwoxoy5c.fsf@alter.siamese.dyndns.org>
 <BANLkTinVvJgE0+gxm8SdDi30-a11P2HnNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon May 02 21:09:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGyUc-0002pP-Aj
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 21:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157Ab1EBTJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 15:09:09 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64118 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198Ab1EBTJH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 15:09:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E834E41CF;
	Mon,  2 May 2011 15:11:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IJBK9mJDey9X2vplU8rbYJwAQFI=; b=M9T9iA
	4HVe0HeajdzcYaFCgqpYEbolGKEiaoYic96CzJyeAOiUhr6VW+N7Y8oepJuzBWNm
	Ku6I7oWUICVRU5krtCkKqog592dtvPzQ77IBDDtprlf19kBzT3SVsU6adKxsf0w6
	QlRTlRT/3HsCLmda6zrZk+yDdB/+brdjDRMZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FOGqAHjjT1XGivJiQ2voKxmdRVl4Ji5v
	0QhspI4EMtbMEEfgbaSMqfa3y2OvXlhHXV/9CLAbBzn5+iG7fCx3U6UB8+SFJgwl
	2npDR+GR+VQb4iVVGpSmJcqHHkwgOlQematyMZ+9omcB+ioFzIfuAFprQd5Kla2L
	b9ce1LeGVrk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A59CA41CE;
	Mon,  2 May 2011 15:11:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6CC0341C9; Mon,  2 May 2011
 15:10:59 -0400 (EDT)
In-Reply-To: <BANLkTinVvJgE0+gxm8SdDi30-a11P2HnNA@mail.gmail.com> (Bert
 Wesarg's message of "Mon, 2 May 2011 20:54:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EC9018CE-74EF-11E0-9827-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172616>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

>>  - Are there existing non-git "grep" implementations that do this?
>
> I didn't know of any, until Jakub mentioned the ack tool. And I didn't
> look for one. I will answer you 'yes'-questions only in context of my
> proposal.

Thanks, but these questions are simple sanity checks done by contrasting
your design with _existing practices_, if any.  It is not useful to answer
what you did here, only to contrast your design with itself.

Also we can read them from your implementation ;-).

>>   - perhaps people use something like "sed -n -e 25,30p file" and be
>>     happy?
>
> How would you combine this with git grep HEAD or with multiple files?

Now how did you get the compiler error messages from your example from the
files in HEAD commit without checking them out?

Besides, that question is still part of figuring out prior art done in the
git-unaware grep, so it is irrelevant that sed or other people's grep
cannot peek into HEAD.
