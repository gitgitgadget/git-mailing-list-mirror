From: Junio C Hamano <gitster@pobox.com>
Subject: Re: avoid duplicate patches from git log ?
Date: Wed, 04 May 2016 12:15:51 -0700
Message-ID: <xmqqinythbx4.fsf@gitster.mtv.corp.google.com>
References: <712E44CFAD1A41A982AEF1540C1F9F80@PhilipOakley>
	<20160503220039.GB25133@sigill.intra.peff.net>
	<xmqqbn4mlrk2.fsf@gitster.mtv.corp.google.com>
	<E735FEEE2908434F874CAD1874307E38@PhilipOakley>
	<alpine.DEB.2.20.1605041347170.9313@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philip Oakley <philipoakley@iee.org>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 04 21:16:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay2H8-0003Ix-MY
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 21:15:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231AbcEDTPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 15:15:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51400 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752492AbcEDTPy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 15:15:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 083BE17016;
	Wed,  4 May 2016 15:15:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2YORuYHZwwPTRxDGB/VsII+RtcA=; b=D1Y13I
	FE48rNFTLxL1d3npaHonmaY3MKxxUAT2QtgjDgA+9J6MK8weluB6c6c18xwj6yeY
	xSvqoANm5iIB+nn/ug6QfN66WvfTss1TiuOTlYLW/WiZ4Mwt0XXTkxmtzjy+UgnM
	b+AjTOK4U2Ctw+YT+87VhEWuC0HAac2HKqtGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LLtuG+rGguTFm472zC5St5CJ8mklR2nc
	0Ipq1+s8CUauE6yrQYxlL1pzT6YZ4/K1E/sKCl2wOL/BR0V3LkrWEk0XOwiL6u1v
	nl22+13yAiib5jy0TEiIVhg80I+th+RxEe924jXVZ7+BGi5Itup1Q/MAK2NkVSOR
	IzYGu8+p0CE=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 00AC117015;
	Wed,  4 May 2016 15:15:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7EC9817014;
	Wed,  4 May 2016 15:15:52 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1605041347170.9313@virtualbox> (Johannes
	Schindelin's message of "Wed, 4 May 2016 13:58:57 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9E506AC6-122C-11E6-909A-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293572>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Please note that I do drop some patches from time to time, so what Junio
> fears is actually not a time bomb, but rather the intended benefit.

OK.  As long as all the dropped patches are intentional, by
definition nothing is lost ;-)
