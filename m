From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/20] Let Git's tests pass on Windows
Date: Thu, 28 Jan 2016 13:37:09 -0800
Message-ID: <xmqq8u39mlmi.fsf@gitster.mtv.corp.google.com>
References: <cover.1453818789.git.johannes.schindelin@gmx.de>
	<cover.1453911367.git.johannes.schindelin@gmx.de>
	<CAPig+cQR11JtTrcHNAWytTRfdWis4qmzODs-Key-8c+8fgKoUQ@mail.gmail.com>
	<alpine.DEB.2.20.1601280957040.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 28 22:37:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOuFj-0000mO-DL
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 22:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967533AbcA1VhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 16:37:14 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52445 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S966022AbcA1VhL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 16:37:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E96093EDBF;
	Thu, 28 Jan 2016 16:37:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1RshZDUdqGgGaahLPxQAD7NgtSk=; b=gomeHG
	sN2de3yoxhs2OkpluWN1GQH2Fxz4bfRKpoEcXwI9FaVWLmusnGIiY4wp6L4SU9zf
	f6lRgSTKdu07Os2Cg5csbkFzbaeTd4lnhGvCKOUbEFhM/Q4mcBm1stNnTHOjXfm0
	E8WYN9kxMUC5FNP4t5yMKmeo9ULi1ZmalPCaw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C23QK+s4U+H3cI9wdblaKHLnShpU2Ghp
	iL0+0DzpY6KaWmTgLqprHEJZHOn7SsgZS6afmY3yFivgpoNIxbn0HV+IkvXwFDTo
	k70H2DuiwSbYgkrWWZiatx0+Q8BdQKoG4NByEC6xtragB/jE3ZR0P/CbbnWag/4h
	8uopnCUVlHM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E199D3EDBE;
	Thu, 28 Jan 2016 16:37:10 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 56B3B3EDBD;
	Thu, 28 Jan 2016 16:37:10 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1601280957040.2964@virtualbox> (Johannes
	Schindelin's message of "Thu, 28 Jan 2016 09:57:58 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 496DBED0-C607-11E5-8E11-B4986AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285035>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> For what it's worth, I ran the test suite on Mac OS X and FreeBSD, as
>> well, with this series applied and didn't run across any problems. I
>> also read through v3 and, other than the micro nit in patch 11/20,
>> didn't find anything upon which to comment.
>
> Thank you so much! I really appreciate your feedback, and I have a lot of
> respect for reviewers that go through a 19 or 20 strong patch series.

Yeah, especially with multiple rerolls.

Thanks, both.  Will requeue.
