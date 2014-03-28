From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] MSVC: link in invalidcontinue.obj for better POSIX compatibility
Date: Fri, 28 Mar 2014 12:06:06 -0700
Message-ID: <xmqqlhvu9m8x.fsf@gitster.dls.corp.google.com>
References: <53354EE3.2050908@viscovery.net>
	<1396005570-948-1-git-send-email-marat@slonopotamus.org>
	<xmqqy4zu9o0j.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Fri Mar 28 20:06:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTc6b-0006ki-Sv
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 20:06:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274AbaC1TGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 15:06:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57479 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751680AbaC1TGK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 15:06:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AB8B7888B;
	Fri, 28 Mar 2014 15:06:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TjmPoATfoUf3JVf559mT1opA6pw=; b=H5cvOr
	IRTSQfg48x8MWTpuT7Qg0IG1b3tMqgSn75Ni5HIlT4OIMubpaf+rN7MqaDD2JPx7
	T3H23a9pgNMHkc+1lwq4Lh+sGZEe69PQ0nJC4NqeXltJgvq+A/8M1PGAuJwRFhgN
	H2RWhfVXMPU8MLZ4aE90G8SirGxcnPLSlSe7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gsDjs9vrdAV2xc1AE6bMfCRmwqDQGaiy
	kSQHGlkYqGZugw1D+dhAxMIYVfIAo+7N+lrMmIGkG9BeGqLcGLZVMKKgbCPiK+iF
	FHjzNglfqy7fcuM1292RXGvQXj6tX21JZdCsqFyX2YfbzRW/99QJ9AEre8UkVUe3
	LeRyj0pWNuY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0144A78888;
	Fri, 28 Mar 2014 15:06:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3BF6B78872;
	Fri, 28 Mar 2014 15:06:08 -0400 (EDT)
In-Reply-To: <xmqqy4zu9o0j.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 28 Mar 2014 11:27:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 04CF1344-B6AC-11E3-BF29-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245417>

Junio C Hamano <gitster@pobox.com> writes:

> Marat Radchenko <marat@slonopotamus.org> writes:
>
>> This patch fixes crashes caused by quitting from PAGER.
>
> Can you elaborate a bit more on the underlying cause, summarizing
> what you learned from this discussion, so that those who read "git
> log" output two weeks from now do not have to come back to this
> thread in the mail archive in order to figure out why we suddenly
> needs to link with yet another library?
>
> Thanks.

Just to avoid getting misunderstood, I am not asking it to be
explained to me in an e-mail.  I want to see a patch with its
proposed commit log message to explain it to readers of "git log".

Thanks.
