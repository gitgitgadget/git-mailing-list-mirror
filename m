From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2013, #01; Sun, 2)
Date: Mon, 03 Jun 2013 08:29:57 -0700
Message-ID: <7vobbnjjpm.fsf@alter.siamese.dyndns.org>
References: <7vfvx0kqtn.fsf@alter.siamese.dyndns.org>
	<CACsJy8DBLkU4h3-YAiXz-18YMmTChnRmPJFpEAEJEHhk4b-Uaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 17:30:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjWhx-0002zw-Qg
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 17:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758041Ab3FCPaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 11:30:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57031 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756694Ab3FCP37 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 11:29:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4772124F46;
	Mon,  3 Jun 2013 15:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6yT14p4/auMNWywltzbuiAcCb10=; b=iSSwNC
	s5sINvZv8l8FywB4G4nW12ES/npn/8agmtVMLinzCktnOBNrX2Hw90ZIEA1Z8e73
	XnB9zc5kGuPNMonl7jBtWwA9+w/054RrnJVEgsLeOWNXfht1yO9PjsVFrP+SX30+
	SXsJDoh7QlnpVQMG/ShOo85pLKrjJhcdXAfBs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PWdITcMcN7c2zCio6jBOIAo2PhHVH+gj
	6/2B9MU0ysKCorxZK6R+pIXO6G0yvlYSZuZ6g1u9rge0UpL1UAK0q1/5tDfuas8I
	xJV/s1P8WNk+uKnGS/8RPV+CMtwdFwZTzguUNSqCEc+mlnfdNpbCO4fl7T9l2Nbo
	Tl5ML3YHo7M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C3AD24F45;
	Mon,  3 Jun 2013 15:29:59 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AFF0824F43;
	Mon,  3 Jun 2013 15:29:58 +0000 (UTC)
In-Reply-To: <CACsJy8DBLkU4h3-YAiXz-18YMmTChnRmPJFpEAEJEHhk4b-Uaw@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 3 Jun 2013 20:23:20 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7344B246-CC62-11E2-865C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226222>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Jun 3, 2013 at 6:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> [Graduated to "master"]
>> * tr/line-log (2013-04-22) 13 commits
>>   (merged to 'next' on 2013-04-22 at 8f2c1de)
>
> Should I resend nd/magic-pathspecs again now that all three topics
> that cause a lot of conflicts with it have graduated? Some conflicts
> (again) with pu but should be easy to resolve. The biggest one is
> jc/add-2.0-ignore-removal but that's basically a code deletion, I
> think you can handle it.

Sounds good, thanks.  I have a bit of backlog so I may not be able
to get around to it for a few days, though.
