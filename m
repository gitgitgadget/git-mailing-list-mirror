From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Signed-off-by vs Reviewed-by
Date: Thu, 31 Mar 2016 10:23:21 -0700
Message-ID: <xmqqziteo92u.fsf@gitster.mtv.corp.google.com>
References: <20160331123507.GC19857@collabora.co.uk>
	<CAFZEwPMzcqrd8NEP6MH5saXL2KdUKAyN51uuoS5=aeU0aPWjJQ@mail.gmail.com>
	<20160331143501.GE19857@collabora.co.uk>
	<xmqqtwjmpq6b.fsf@gitster.mtv.corp.google.com>
	<20160331172104.GA1623@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Miklos Vajna <vmiklos@collabora.co.uk>,
	Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 31 19:23:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1algJd-0008O7-Ds
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 19:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbcCaRXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 13:23:25 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:64236 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750751AbcCaRXY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 13:23:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C7DC151C89;
	Thu, 31 Mar 2016 13:23:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lA/6KUwNTqBFbNg7Og8zsgtxYrw=; b=hqRzb8
	AQ6QXYRDM+vkZ9RTKfBzV0o0IKo9Juj8Wg9xfW3EcYSm/clW2NmmP3ZodvztibP7
	KOt6chXgFToxvYQl3IKSCOo6/eAwXsV3pmLjFtc5H/u6W/FJvC1LmeCfyVLT7vyL
	yFA/YMRMb20aLF4V8F9euujoM4SFNooPXzSCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=trvCaYfRw2LCqEt25Jmgduslrv7t6Zof
	ql8aX06eL72+nlW7a5+opl/a4FHdidQbpJvSXBUlAXzFu8JNXWlpy6ttBTnw+JJ8
	6jOzd+2k7mbibMxVi7SSKAmDjMEBEftoS5Ln8XvZHtK1HmKoxmZhWH5BQnlA5LQN
	o1oXgBjyn+E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BD18751C88;
	Thu, 31 Mar 2016 13:23:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 267A951C87;
	Thu, 31 Mar 2016 13:23:23 -0400 (EDT)
In-Reply-To: <20160331172104.GA1623@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 31 Mar 2016 13:21:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4556B8A8-F765-11E5-816A-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290427>

Jeff King <peff@peff.net> writes:

> On Thu, Mar 31, 2016 at 09:28:44AM -0700, Junio C Hamano wrote:
>
>> As to the last step of "integration", we cannot use short-and-sweet
>> single letter options like '-s' (for sign-off) for each and every
>> custom trailer different projects use for their own purpose (as
>> there are only 26 of the lowercase ASCII alphabet letters), so the
>> most general syntax for the option has to become "--trailer <arg>"
>> or some variation of it, and at that point "-s" would look like a
>> short-hand for "--trailer signed-off-by".
>
> I can imagine it would be useful to give one short-and-sweet to "add my
> standard trailers", where that standard set is defined in the config
> file. But that is just a guess; I do not personally have a workflow
> where such standard trailers exist, beyond the normal s-o-b.

Yup, I agree; I meant by "some variation of it" to cover such an
arrangement ;-)
