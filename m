From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t0060: loosen overly strict expectations
Date: Fri, 15 Jan 2016 09:26:14 -0800
Message-ID: <xmqq60yukb49.fsf@gitster.mtv.corp.google.com>
References: <eccf149d9557fd9afb591d9411ecb0b3460c9eb0.1452754049.git.johannes.schindelin@gmx.de>
	<CAPig+cRa9mk0U4iPim5GRWzFN-vHEA=rx8bb40oQyCJVZL7t3A@mail.gmail.com>
	<alpine.DEB.2.20.1601150734460.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Michael Blume <blume.mike@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 15 18:26:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK88j-0004kV-I6
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 18:26:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965AbcAOR0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 12:26:17 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60620 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751626AbcAOR0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 12:26:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EAFF139364;
	Fri, 15 Jan 2016 12:26:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=439Y7kpAPur7n5yDgmH8cki+fLI=; b=sq0iO7
	G3yfjyaFegQxK89q5hC+EIYjHtXu8jWuEfBF4MGA7fLSafemTZKDQ6MmQH3p5Nfk
	nOJ8x3Wpoe1s1u/4KxYlfLNMVJCahV8gZlVQ+G/GW7I+y7/Lr+4mr+sAsfz7/eU6
	RRNCqlxP+1QWuAdKshjqZWlPvJrHd8Ud4VLek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nrTdrNn4ZP8UwHsgymH6L3URdnI5YG0h
	tN1/hwXISuLtc+FT9bazxIgkwZXce3tTWIPKPQLizld+K0aC687QKeuedBDSM1dv
	wur6s5IIzp2CiOkzcsjfd0QAeVnBzDiRI6ifB/vxG2H2U1j00atiHJxJfVIUzpq+
	MSF/I74+B38=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D3FCA39362;
	Fri, 15 Jan 2016 12:26:15 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 440F639361;
	Fri, 15 Jan 2016 12:26:15 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1601150734460.2964@virtualbox> (Johannes
	Schindelin's message of "Fri, 15 Jan 2016 07:35:34 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 14931B92-BBAD-11E5-A702-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284188>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > This is not limited to the "//" vs "/" case, of course, other inputs are
>> > also allowed to produce multiple outpus by the POSIX specs.
>> 
>> s/outpus/outputs/
>
> Whoops.
>
> Junio, would you terribly mind adjusting the commit message on your end?

No problem.  Is this the only tweak that is necessary before it can
go to 'next' and then to 'master'?
