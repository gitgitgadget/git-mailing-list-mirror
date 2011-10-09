From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Recovering Committed Changes in a Detached Head?
Date: Sun, 09 Oct 2011 16:22:46 -0700
Message-ID: <7vfwj1px6h.fsf@alter.siamese.dyndns.org>
References: <1318107488.5865.46.camel@R0b0ty>
 <20111008213741.GA24409@goldbirke>
 <ab706826-75df-4410-941e-6b40ec92713c@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Daly Gutierrez <daly.gutierrez@gmail.com>, git@vger.kernel.org
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Mon Oct 10 01:22:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RD2hp-00007a-3Y
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 01:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612Ab1JIXWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Oct 2011 19:22:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61418 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751394Ab1JIXWs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Oct 2011 19:22:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0F886D34;
	Sun,  9 Oct 2011 19:22:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=JysKBO/j7X0jZimX4NqSwGy9E2k=; b=KdFLlKqqzHAbcTtSBSqq
	C9L0HOl8rLiXz9xtALf+RWN9aP98qe6vDA9JY8MgkUPMx28RpcHOhkPc3W8p2ocA
	9bQ7O0najhatpcQlA55kCxw9EhAinx9wCagd1Oq0ZdpfD/3gbUE+4eRfFuAi0v6S
	PBMSg//XAktPXxh8j35zLX8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Qvh5mOp7QPoh1eY56sVqsdO7Psdp6aNkBGGk+6qpIWRRbT
	hz3UlUUU20iExdHkbrnIaEsECw2e16GeYeNDaDk/q5MOg3BLXb+DO8UdUrCs4kUA
	R53/AMRoFvHtz8us8KMBikwAsy+gEII90jxlAAMAVr/pxNZ5dpJnsfzELGoeM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7B036D33;
	Sun,  9 Oct 2011 19:22:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7854E6D32; Sun,  9 Oct 2011
 19:22:47 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9949265E-F2CD-11E0-8EED-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183217>

Martin Fick <mfick@codeaurora.org> writes:

> While rflog is cool,...
>
> First, maybe git could create refs for these automatically, perhaps with a name like orphans/1?  Maybe these refs would only be visible via git branch --orphans.

Instead of spelling them orphans/$n, you already have @{$n}.
