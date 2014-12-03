From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 0/4] refs.c: use transactions for the reflog
Date: Wed, 03 Dec 2014 10:05:42 -0800
Message-ID: <xmqqlhmoip6x.fsf@gitster.dls.corp.google.com>
References: <1417506402-24257-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, ronniesahlberg@gmail.com,
	mhagger@alum.mit.edu, jrnieder@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 19:05:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwEJC-0006Rv-54
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 19:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbaLCSFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 13:05:46 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64126 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750815AbaLCSFp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 13:05:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 838E7227D8;
	Wed,  3 Dec 2014 13:05:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GfZYoz3dpDHE4RFl121D0ULwfpg=; b=sehSBE
	qzIE1qIp6HJLX5NcwVN4F41LQHAyvZ1b+HFsAB1ENK2boLHmQuFgC2tYoyMPmYdv
	fGJotkKSyocoilxMg0KUVJ5jx78pko+g6P8/pW0dBANXNnE92s/Cgj4Cco2FvmQ1
	MSf6XBZVw77dQUgNQlAbcMaiWdePFOIJT59mU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ht7THI87ZHZJXYuoGAM7B+UnBWAHCaFQ
	D49k5WYtSh127zmQFiglXM2ZQtNRElcbqPgOg1FahYHAva5Ith2oGNUQBAY6yg1G
	sbcYezI088aoQ9LyMeRYaaZKL/ifYibRl8ywAbp6aru7RkkKWV9KwbKvDoimav8p
	rWGa9wfV0zE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 71F48227D7;
	Wed,  3 Dec 2014 13:05:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E8F4F227D5;
	Wed,  3 Dec 2014 13:05:43 -0500 (EST)
In-Reply-To: <1417506402-24257-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 1 Dec 2014 23:46:38 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FFD65D90-7B16-11E4-8A56-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260673>

Stefan Beller <sbeller@google.com> writes:

> This is the core part of the refs-transactions-reflog series[1],
> which was in discussion for a bit already.

I think what 3/4 attempts to do is very sensible, but I agree with
Jonathan that it needs a bit more polishing.

Am planning to queue only the first two for today's integration
cycle on 'pu'.  Thanks.
