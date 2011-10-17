From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2011, #05; Fri, 14)
Date: Sun, 16 Oct 2011 21:20:22 -0700
Message-ID: <7v39esp7uh.fsf@alter.siamese.dyndns.org>
References: <7vd3dzximu.fsf@alter.siamese.dyndns.org>
 <20111016165329.GA14226@sigill.intra.peff.net>
 <7vvcrorh49.fsf@alter.siamese.dyndns.org>
 <20111017033706.GA26326@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 17 06:20:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFegg-0004B2-MU
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 06:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286Ab1JQEU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 00:20:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41289 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751105Ab1JQEUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 00:20:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27EA8667F;
	Mon, 17 Oct 2011 00:20:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iobq0IDPVaPOyR8rozeNPGZwHCk=; b=ogwFoF
	mj184qvrIjVmnB/OJkz6nxp9nGt1VJYkTxypWoYUfWomBPPcjqs0sLsnGEcX86xJ
	ojOPmob+n0oMzdVrMJNZkWNkR2GZ3aYiccUWtrLUQNvbVNu9K09yWZ8NwxG1O3Of
	Z3RKH80U0g9K/X2zY4Yf5Qjlpvdv8jMd7uYX0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BXELLn1q/K7rmUsBTLYGf8b6BqKy0MMM
	CN9frOhfYrsTOiHlT/x1XE99mO88OstmeEHkKPVBIXtW72otY/Z3V2yk20w1FMBs
	MGro9OSgLOblpuUTxQlj7MmEHRvrG9xZQZT4vPryoTIgx4mhP8yxghDyv63yH1dL
	kT6dzHNaLbo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E818667E;
	Mon, 17 Oct 2011 00:20:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B2C28667D; Mon, 17 Oct 2011
 00:20:23 -0400 (EDT)
In-Reply-To: <20111017033706.GA26326@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 16 Oct 2011 23:37:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 55532BD4-F877-11E0-A1F4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183765>

Jeff King <peff@peff.net> writes:

> What you queued in d5570f4 looks sane, but the merge into next is
> curious.

Thanks for spotting. I think I had rerere that recorded the conflict
resolution with an older iteration of the topic with looser message
default or something.
