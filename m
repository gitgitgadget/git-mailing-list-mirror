From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] blame: CRLF in the working tree and LF in the repo
Date: Tue, 28 Apr 2015 12:52:47 -0700
Message-ID: <xmqq7fswuj1s.fsf@gitster.dls.corp.google.com>
References: <553CD3DA.9090700@web.de>
	<xmqqzj5uxhls.fsf@gitster.dls.corp.google.com>
	<20150427061115.GB2766@camelia.ucw.cz> <553E86BD.7030401@kdbg.org>
	<553E91CD.9060205@web.de> <553FD48B.1010608@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Stepan Kasal <kasal@ucw.cz>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	sandals@crustytoothpaste.net
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Apr 28 21:52:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnBYu-0001zZ-Hd
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 21:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030986AbbD1Tww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 15:52:52 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58203 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030888AbbD1Twu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 15:52:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B22C84C0CD;
	Tue, 28 Apr 2015 15:52:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=690uYdE4t91oL/j6TdGNQFg5kIQ=; b=YyBHbN
	10qyhxVgFacIaP7F30t5C/BBa1VlYQLc/lbI4QMO8pP28OQsdcoUZ/wWRHWQy43t
	mu+LkGcRI0erfkCGGZsSj6PnG7BbdOIw0NbgeKFv+6vMaN2Wzn3Hw0kcEj9fF7XL
	CNa8k4qBMDtCD093IjQUQhpfPKnURsdhVvkig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gVr4BdKptnwM4ygXkrjAitgW4nmaLRV1
	pirzH20DCy2rGdZYhdeFKXSmgEAmKuTyNGZ7CnivVGiy05RvNTBinzhwgsilqnyI
	xvcOw4Hv7gkp0xhJMXQSxeZDTXTlb3S0LZ7/qwcXS5Z89cTYZu9enJ7Pgpyy4AAe
	wCe6XT4SAmQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A5F914C0CC;
	Tue, 28 Apr 2015 15:52:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 187424C0C8;
	Tue, 28 Apr 2015 15:52:49 -0400 (EDT)
In-Reply-To: <553FD48B.1010608@kdbg.org> (Johannes Sixt's message of "Tue, 28
	Apr 2015 20:42:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 25DFDB6A-EDE0-11E4-9DEB-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267936>

Johannes Sixt <j6t@kdbg.org> writes:

> I set none of these. But I do commit CRLF and expect to get CRLF
> back. Am I commiting binary files? Am I doing something that "Git does
> not support"? Am I "on [my] own"?

I think these specific sentences are merely uninformed opinions; if
I ignore and re-read what people said in the discussion, I think the
thread as a whole makes sense.
