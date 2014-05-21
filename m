From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v2.0.0-rc4
Date: Wed, 21 May 2014 10:05:07 -0700
Message-ID: <xmqqa9abqczg.fsf@gitster.dls.corp.google.com>
References: <xmqqr43oq8q5.fsf@gitster.dls.corp.google.com>
	<537bf50f27417_353e13c330846@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: linux-kernel-owner@vger.kernel.org Wed May 21 19:05:36 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Wn9xP-0007yu-OF
	for glk-linux-kernel-3@plane.gmane.org; Wed, 21 May 2014 19:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701AbaEURFW (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 21 May 2014 13:05:22 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63096 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751336AbaEURFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2014 13:05:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 35B8D18A82;
	Wed, 21 May 2014 13:05:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jHqabM6DQO4k/QHu3n0urBANwoc=; b=MmNIzf
	AebT4B2AO9WbPH9Jv97aiwpiAgiFshkjSbQBGvJgkyjMo3qRbKD5sPaw51IoaidT
	yq2mL5wY1VVARc2+xjzMPFU1EP9lfDDNPM1n7+2/+tiAi0HoKcsEq+cPacWaH0NE
	L5Ct6zJkYTNgqCbFaOFSGD8whUptrTyh8z3UE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v0d2/OWLtacM8+l9elTQlCX8UQ3F0hYf
	gF3cFzu6laUHu3HqIFNV61MLUwDvfoCnhHKgZWIda/7znEYXsQnENsA7xRd29pZT
	02KIhLvj8M0nw3bnKiSzklyLMYurol86hDpue5cjqdiYkYXCNJks58blzDA3Z7vq
	q0uPH1nK71g=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1B99A18A81;
	Wed, 21 May 2014 13:05:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8E35E18A7C;
	Wed, 21 May 2014 13:05:10 -0400 (EDT)
In-Reply-To: <537bf50f27417_353e13c330846@nysa.notmuch> (Felipe Contreras's
	message of "Tue, 20 May 2014 19:36:31 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1136993A-E10A-11E3-BF41-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249812>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>
>>  * The remote-helper interface to fast-import/fast-export via the
>>    transport-helper has been tightened to avoid leaving the import
>>    marks file from a failed/crashed run, as such a file that is out-of-
>>    sync with reality confuses a later invocation of itself.
>
> Really? Where are the patches for that?
>
> I think it's fair to say the way the remote-helpers and transport-helper
> has been handled for v2.0 has been a total disaster.

Thanks for noticing.  The last-minute change of plans in the morning
on the -rc release day did not help.  Will remove.

Anything else I missed?
