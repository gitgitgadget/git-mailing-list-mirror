From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-archive documentation: .gitattributes must be
 committed
Date: Wed, 10 Feb 2010 11:33:06 -0800
Message-ID: <7vocjw998t.fsf@alter.siamese.dyndns.org>
References: <1265770284-14830-1-git-send-email-fmarier@gmail.com>
 <4B7303FC.6070701@lsrfire.ath.cx> <7v1vgsao21.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Francois Marier <fmarier@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Feb 10 20:33:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfIJN-0002qW-Rp
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 20:33:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755107Ab0BJTdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 14:33:17 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51818 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031Ab0BJTdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 14:33:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 39DA998CB5;
	Wed, 10 Feb 2010 14:33:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R6NK80qoPkxLaq9D/pcHyCoIq6k=; b=BYZXxi
	sGHy27CFAufBk/mmICMrLfE4FQ/SlJlhJxMRglNY/5Xf3qdoyp5pnM9mK9Txy6ux
	SQM4lcxI+gHc2S6NAxZRXnbCWC6sSyFiT0/PiTSFndaDEFE8A9mEaX4x6Vur6ffn
	23PS2+4KnjO4UQyvWI6Vs9C7jjbo+TbqW2+10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rS5gWhxARcSxZBEBqM5GfXUNEgudii0/
	hDE12R0RnkL3OhIrzAQAbij6VtERCtgog6xNsaBdK/XMvwXk5KfblmVJZUm1OTB8
	hRuGfHOYggJTankLU5fitXgzxjZmTI6JyhcN4lnGlY1pr842ruBliwTlEeCINoyo
	GHKJko2/Dns=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E877898CB0;
	Wed, 10 Feb 2010 14:33:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2508C98CAF; Wed, 10 Feb
 2010 14:33:07 -0500 (EST)
In-Reply-To: <7v1vgsao21.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 10 Feb 2010 11\:27\:50 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 201024AC-167B-11DF-BBC0-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139536>

Junio C Hamano <gitster@pobox.com> writes:

> By the way, if you commit the attributes file, then commit the removal of
> that attributes file, would that removed attributes file take effect when
> you archive HEAD^ (which still had the attribues file)?  That's how I read
> what the added description claims, but I somehow suspect that is not what
> actually happens.

Scratch this part, please.  You do read the tree into the index to make
it happen.
