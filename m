From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/4] Add explicit Cygwin check to guard WIN32 header
 inclusion
Date: Mon, 09 Nov 2009 14:25:09 -0800
Message-ID: <7vd43rpc8q.fsf@alter.siamese.dyndns.org>
References: <4AF86E0C.4080001@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Nov 09 23:25:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7cfy-0002LQ-ID
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 23:25:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754316AbZKIWZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 17:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754240AbZKIWZQ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 17:25:16 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54670 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754134AbZKIWZP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 17:25:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F41E17AEE9;
	Mon,  9 Nov 2009 17:25:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WxyqAoE95c94JliMeD6fF1l3qls=; b=v1vKHz
	10Qi+Utx3s6EL/wBaTZqI6PeEgNH/Rji6HXN7EnJk9a4Y4282f+I1V/VdTJk0zyc
	Zu8XU5mL3PPeeybF+PHHMImycVZqbHKdJltdiS1zuDP17ufG6Q4UN9AwXsNolQqV
	ZWbBM1UuoK/yGvo4tDyj+6LWeT0+bsICUv/Fc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K8BasrRL/NcTxaBkhv0GFhVr2WdylkCt
	THpzL5Wbfv/oaNYiEjscWUiITsPYiWcQT3q0BMbRR+YGmUgR6PdmYi9sbZpNUvco
	ZBDihQBq6ar5cBg5tKqHcAIBhoL0msnF3uw//Nw+vQacPBYEfd9hTzl6udIRWq0I
	JjCJGgUK92g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B4CEE7AEE2;
	Mon,  9 Nov 2009 17:25:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF5BA7AEDB; Mon,  9 Nov
 2009 17:25:11 -0500 (EST)
In-Reply-To: <4AF86E0C.4080001@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Mon\, 09 Nov 2009 19\:31\:24 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C1B4E130-CD7E-11DE-AF9A-7B3EEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132524>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Changes since v2:
>     - removed indentation from the #if-#endif block
>
> I hope you don't mind, but I've only sent this patch, rather than
> re-send the whole series. If you would like a complete re-send, just
> let me know.

No, I don't mind "replace only this one out of the four-patch series" at
all as long as what's being replaced is marked clearly enough (which you
did in this case).

But I thought J6t had problems with what this particular patch does, not
how the patch was indented?  So I'd wait for more comments and hopefully
an Ack from him before touching this one.
