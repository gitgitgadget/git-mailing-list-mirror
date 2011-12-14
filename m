From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Makefile: optionally exclude code that needs Unix
 sockets
Date: Tue, 13 Dec 2011 16:14:02 -0800
Message-ID: <7vhb14t3g5.fsf@alter.siamese.dyndns.org>
References: <20111210103943.GA16478@sigill.intra.peff.net>
 <20111210104130.GI16648@sigill.intra.peff.net> <4EE66DAB.5070407@kdbg.org>
 <4EE66E58.6040404@kdbg.org> <20111212213951.GB9754@sigill.intra.peff.net>
 <7vzkexwb7m.fsf@alter.siamese.dyndns.org> <4EE7AEDA.6090509@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 01:14:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RacU8-0005Ye-Au
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 01:14:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755962Ab1LNAOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 19:14:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42308 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753329Ab1LNAOF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 19:14:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88DB0625F;
	Tue, 13 Dec 2011 19:14:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ek6zHPcUL+VbPuyhQC7LtH4BEJk=; b=wAIuRm
	CHEQOvyf5lblJT/ow4nltidex4PBM1OW7YlWjJdNcZ8vuelgA7M4h7K5c34XOyVC
	rUjl3C74gYzifnLpLrf3StY/+UhtbYh5qMGKxJ+sY46KReAAaBOFuBU01TAMlndU
	dbYJy832e5CQaSUtUuUBXRYt0A9Wy5DMOSj24=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MNPd7msldks8w5S2bpWHA0rej6vej3NJ
	9pXqQ8Vo7d0EN4Npl7xhYhB05PrkB/G7ZnBgqF5gGKXSzRYOFP+mZXhdhxBjwN6G
	OkB6OliI6NQm/BRTBqRxXXDLOgmCWhF2JthHAlA9RD79baIQQQE1fVtByotw4SU2
	Y844wd64BZ4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 812EF625D;
	Tue, 13 Dec 2011 19:14:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 17CD8625C; Tue, 13 Dec 2011
 19:14:03 -0500 (EST)
In-Reply-To: <4EE7AEDA.6090509@kdbg.org> (Johannes Sixt's message of "Tue, 13
 Dec 2011 21:00:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 87EF7B8A-25E8-11E1-9427-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187083>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 13.12.2011 01:45, schrieb Junio C Hamano:
>> I'll queue a single patch that is a squash between 2/2 and Peff's test
>> updates between "credentials: add "cache" helper" and "strbuf: add
>> strbuf_add*_urlencode" in the series.
>
> Thanks. The resulting series builds fine on Windows and passes/skips the
> new tests in the expected manner.

Thanks. Let's advance the topic forward then.
