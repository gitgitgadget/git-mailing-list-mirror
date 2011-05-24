From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff-options.txt: document --[no]-textconv
Date: Mon, 23 May 2011 18:30:22 -0700
Message-ID: <7vlixwanrl.fsf@alter.siamese.dyndns.org>
References: <1306196874-64687-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 24 03:30:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOgSD-00009p-9b
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 03:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754209Ab1EXBac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 21:30:32 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54209 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210Ab1EXBab (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 21:30:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BFE165A6A;
	Mon, 23 May 2011 21:32:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/C5hlbJRQ1hhvAxk6/K5jfPeKI8=; b=afJhwo
	0ONBvyRtNRkj6N/I194FJFexRmmvAz+uC98xVILslCrkmbBUqgmxwJOhMvUI9FSQ
	2nQHTuoQgHYvA4q4o2/fwNohC1KhIrqfCge6aArrRrhK7TXzrHmuCDppVVOjjn3l
	rkKpdGDnoO8MgNED961v6gBVmci2TT+BKCXyM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iEvLoDs5+/PZ3Bu5O1Mk9as/ciQ1mzwJ
	XmYfIf6ak7eArb9mJDOFPD4IbLlhitVO0wr7JinyJQdtxNhMzvTIZ+kbH56KHWju
	2uyHMJndvOlwgYFxeUxDzRHdSnQ9zi1L5mXmPNbo5O7QtDke+3msNRFWH0kg1GYz
	jxL6+rnyyXA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8E89F5A69;
	Mon, 23 May 2011 21:32:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 87E735A68; Mon, 23 May 2011
 21:32:31 -0400 (EDT)
In-Reply-To: <1306196874-64687-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Mon, 23 May 2011 20:27:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B3E028AE-85A5-11E0-BB32-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174310>

Jay Soffian <jaysoffian@gmail.com> writes:

> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> ---
> textconv also seems to be supported by blame, it isn't clear to me whether
> it respects --no-textconv.

I think it would, as it shares the command line parser with the rest of
the commands in the "log" family.
