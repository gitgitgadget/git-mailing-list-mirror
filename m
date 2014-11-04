From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] fetch, reflogs, and bare repositories
Date: Tue, 04 Nov 2014 11:40:53 -0800
Message-ID: <xmqqy4rqpxdm.fsf@gitster.dls.corp.google.com>
References: <20141104131006.GA1077@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 04 20:41:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XljyQ-0005sc-57
	for gcvg-git-2@plane.gmane.org; Tue, 04 Nov 2014 20:41:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbaKDTk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2014 14:40:58 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59647 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752507AbaKDTk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2014 14:40:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 122D71AC2B;
	Tue,  4 Nov 2014 14:40:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k5ckKhvsiZptd/95N7XvBj/fE4k=; b=FOmrvH
	EIyRak1O99cs/shN+Le/ywzfD6K6qEIPSuratln9U6ZJ5dU0ehmnre0OLhGyHbGb
	5dIMMMcRHMUw4juHZU2+sLM5a6o0YjHFZpTp99ncasWj9ocOO5CvNexhDO9pp9uU
	Vb/jxuk9Z+3l95dWzYHhhYRUFNwTwH4hodTNY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NWi9WtrOe0HWSuAzlPdA8IXZkw7HEdq+
	tZn0lY57+WI95mW7Y4KWSU/eE2vMs2luhOxoIX1AfBmao2jBd3STYQQ4cRs/J+hU
	pivA/aj/aiqidjdAbR8I/3cjMiaQb/L4fU1d2DQgG+wLRfl0vT5BPfQtcdd75qYa
	NFQd4by/7JI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 08A7C1AC29;
	Tue,  4 Nov 2014 14:40:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3B5451AC28;
	Tue,  4 Nov 2014 14:40:55 -0500 (EST)
In-Reply-To: <20141104131006.GA1077@peff.net> (Jeff King's message of "Tue, 4
	Nov 2014 08:10:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7E0C2254-645A-11E4-9A74-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I ran into a rather confusing case of fetching into a bare repository
> with reflogs turned on:
> ...
> This turns out to be caused by two subtle bugs: one that makes "git
> fetch" use reflogs inconsistently, and the other that causes some ref
> updates to fail when reflogs are turned on and off. Details are in the
> fixes themselves.
>
>   [1/2]: fetch: load all default config at startup
>   [2/2]: ignore stale directories when checking reflog existence

Must have been painful and fun at the same time to diagnose these
;-)  Both patches looked very sensible.

Thanks.
