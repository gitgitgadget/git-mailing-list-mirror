From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git ticket / issue tracking ERA: Git shouldn't allow to push a
 new branch called HEAD
Date: Tue, 22 Nov 2011 11:46:54 -0800
Message-ID: <7v8vn8djo1.fsf@alter.siamese.dyndns.org>
References: <1321970646.3289.19.camel@mastroc3.mobc3.local>
 <CAH5451==iXuB=QPW7bQvahB-jMnKC2axJYnW2OfFq=UNO9U6mg@mail.gmail.com>
 <1321977372.3289.38.camel@mastroc3.mobc3.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 22 20:47:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSwJ5-0003cp-Bm
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 20:47:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757117Ab1KVTq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Nov 2011 14:46:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44130 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757066Ab1KVTq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2011 14:46:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 619AE6FA0;
	Tue, 22 Nov 2011 14:46:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vXyJxXmxyzXI3CJlFjNqKsjLGAA=; b=ezIcac
	bmaGh88+0SM0R9MnGQapece+1uLIVgZywK18z2NN5N2Bs6GYLQXFgkixDQ0Z7mS4
	2fJopD/GMrG6+u8KyoScva1ZSWvg8hTQb1Ul5NyRXOOpZbldc+MK+PVqK/XSp6NB
	to6gIrybAlSweJsmgpsk9o/Ve2GlvFjVBg44E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qOdCPpuY5Ag+ALbhi/FN3HEFIE9riU/9
	bQImfyrW/605wvVc7Secd4nMCPDaGGnwstO1U28ZP9PNE4WJqj2sqOmTnevQv/E9
	gYy/wbLc7IXlsIQjC/h1VLB+yK6ceX9dR4chmuRNyvbvQopXN8j2YH3hqaKdfreW
	DynC65suZxs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 542A96F9F;
	Tue, 22 Nov 2011 14:46:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C6C1C6F9E; Tue, 22 Nov 2011
 14:46:55 -0500 (EST)
In-Reply-To: <1321977372.3289.38.camel@mastroc3.mobc3.local> (Daniele
 Segato's message of "Tue, 22 Nov 2011 16:56:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BBA8E29C-1542-11E1-94A4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185808>

Daniele Segato <daniele.bilug@gmail.com> writes:

> Let me explain my idea with an example:
>
> An issue is discussed, a bug is acknowledged and a proposed solution is
> discussed, this all happen in the mailing list, like it always has.
>
> Someone in the "git management" (the one that usually choose how git
> should evolve) open a ticket, copy the relevant part of the mailing list
> (or link to the discussion in the archive) and (optionally) place the
> bug / feature / enhancement into a roadmap / milestone

This step I wouldn't buy, if you count me as part of "management".

But I suspect that curation of issues, prodding parties involved and
closing inactive/stale ones can be done by volunteer project secretaries
without requiring an authority to choose how git should evolve.

cf. http://thread.gmane.org/gmane.comp.version-control.git/110117/focus=110129
