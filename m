From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC update] Sequencer for inclusion v2
Date: Sun, 24 Jul 2011 11:17:33 -0700
Message-ID: <7v62mrwnk2.fsf@alter.siamese.dyndns.org>
References: <1311095876-3098-1-git-send-email-artagnon@gmail.com>
 <7v62mx967w.fsf@alter.siamese.dyndns.org>
 <CALkWK0mXFkAW6dy=aAoWuJp90LshxnWap6PvzE2yOk6YuNJE3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 24 20:17:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ql3FF-0001Lg-QS
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 20:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362Ab1GXSRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 14:17:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61990 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155Ab1GXSRg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 14:17:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7E8D350F;
	Sun, 24 Jul 2011 14:17:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3iilcqE25UIjxvw7RCGAIgHsFLU=; b=YLfVzQ
	HKWS6z4e1h/zBdBk+CzIoJiqjyATE8hDG9hPTLj9JyAKOapBM+EWlfafKw4H79nw
	a9fzVbDEqiWk1nqsvFXZh75cG8nhEbld9+fjgm/3HujYsvVd/Bb14cRDEigc3CTU
	C4z4UJuxVtRUMT7bz9u5eg/8nltYo1wxgBNmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cByCz2S1heMk7KavQy1ar8HKkwUfizFT
	1ZyT8wnfxPL3SQyQB5qPS3P8AKSNakHeBfz56MvHHaOX66zQL/kODRGNtN3JUT92
	MA87VH7bkAoVtJiPqsRvHw6ah+eZyA61cC2eGWZcRs80CpiaE+s+4besSG+pyWVh
	VBY+dHH5Cew=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E2F1350E;
	Sun, 24 Jul 2011 14:17:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 18ADA350D; Sun, 24 Jul 2011
 14:17:35 -0400 (EDT)
In-Reply-To: <CALkWK0mXFkAW6dy=aAoWuJp90LshxnWap6PvzE2yOk6YuNJE3g@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Sun, 24 Jul 2011 15:41:38 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 34757130-B621-11E0-8442-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177768>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> ... convenience shortly.  I've started building my post mid-term work on
> top of it -- if some other minor details come up before it gets
> merged, I can rebase quickly and continue.

Thanks, both for a re-roll and for a heads-up.
