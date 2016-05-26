From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mingw: make isatty() recognize MSYS2's pseudo terminals (/dev/pty*)
Date: Thu, 26 May 2016 10:02:02 -0700
Message-ID: <xmqqvb20wy5x.fsf@gitster.mtv.corp.google.com>
References: <f1408371e14ff10539990ad710681ef17f29fea1.1461770158.git.johannes.schindelin@gmx.de>
	<alpine.DEB.2.20.1605261525400.4449@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karsten Blees <blees@dcon.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 26 19:02:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5yfk-00029M-EK
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 19:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754724AbcEZRCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 13:02:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61748 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752366AbcEZRCH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 13:02:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B9731DFA3;
	Thu, 26 May 2016 13:02:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pp9QUNj97Ngnwl7Du9wygttQ7l0=; b=tWDw/4
	cOWtWoFm8tH0VcchnXerIF/rsjlQdnkVbri/fJo2Rmq6FmoRR2tpvnvcQ+Hp8UTN
	XOaBZDWsnihchiVfRF41u9INvOMau4TUOBahJwxF/B4mzICvjItStndFtWo6TAjW
	xscCuUFfR1RHlEwxWxs9N1BPqSxoTp/7gvOjM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CGG4mCM2qgSEVWRWLmextRI88K2g4Xno
	OBKlhQs0hDjIQpeeZrByVG1dOIGe3ClaA1aX9c50lf1LXS8opqhUb/aR7KdsfoVv
	7VWrZ0xzcytuiZKk5SW1umRhoQRquW2+UMZcs27voqlOCFNsXsuYTCkIJX3HZaDb
	DOReL4CDGV8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 49F4D1DFA2;
	Thu, 26 May 2016 13:02:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 806C21DFA1;
	Thu, 26 May 2016 13:02:04 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1605261525400.4449@virtualbox> (Johannes
	Schindelin's message of "Thu, 26 May 2016 15:28:29 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 925C5052-2363-11E6-82D5-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295673>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I do not see this patch in 'pu'... Anything I can do to get this into
> 'master' eventually?

The reason why I left it in my inbox was because I couldn't tell if
this was a final submission with concensus among Git developers on
Windows, or I should be giving a chance to comment to some folks who
work on Windows port but are not necessarily closely communicating
with you.

If the message were Cc'ed to J6t, I would probably have queued it on
'pu' and marked it as "Will merge after waiting for a few days" in
What's cooking.

Thanks.
