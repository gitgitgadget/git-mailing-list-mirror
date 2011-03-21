From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] rev-list --min-parents,--max-parents: doc and test
 and completion
Date: Mon, 21 Mar 2011 09:47:00 -0700
Message-ID: <7vei60s9ob.fsf@alter.siamese.dyndns.org>
References: <cover.1300459016.git.git@drmicha.warpmail.net>
 <182c5ece22835559a9762e242adb701547cf6575.1300459017.git.git@drmicha.warpmail.net> <20110318194802.GB27825@sigill.intra.peff.net> <4D871401.6020900@drmicha.warpmail.net> <20110321105431.GB16334@sigill.intra.peff.net> <4D873F56.1060803@drmicha.warpmail.net> <7vbp14ttgu.fsf@alter.siamese.dyndns.org> <4D876714.8040604@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 17:47:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1iGD-0000Wk-0V
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 17:47:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753794Ab1CUQrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 12:47:12 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38775 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512Ab1CUQrL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 12:47:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 77993492C;
	Mon, 21 Mar 2011 12:48:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2Lddjf5F8U8Z1Xq18BYZbpw2NPg=; b=v6KuKX
	/YPKrl1KwQV+uODmt6zCEJ+afTLF6MMqsiUFZHm45PruCwKhtiPpiWrfN3W1RtiV
	HvcPMrA0N5f5mvv2Fno9wZMw5o40fX4DW5Vj4rcPta3XVyUzWmjj3moeEOUkTnIc
	khjkQNjlhDOV0XRQp0AXCgMJp+0i5NsDLCj+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HUXbA1LaJK9pOLJatWvr7vOMY3aLVV3P
	LdyZRww2BWgU2MFfq7vSEd4FmBr44qN7ApIr3RJomJ2lpozjFqBuKv7L1ASkqB7h
	GMrYlZUCf1ahlEX2Ow1EPgJyHI4/zEO+RL+hoJRwI0+5ybjsiohdDvdq+WtPMFgF
	3VFJRqa/esk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 47EB74928;
	Mon, 21 Mar 2011 12:48:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 37B094922; Mon, 21 Mar 2011
 12:48:39 -0400 (EDT)
In-Reply-To: <4D876714.8040604@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Mon, 21 Mar 2011 15:56:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1557E33A-53DB-11E0-880B-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169612>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> I guess you haven't seen v2 yet, where most of these changes are
> incorporated.

Yeah, I think that was before you wrote "resend or squash", so my
automatic reaction was to discard everything you sent on the topic before
the timestamp of that email.  Your v2 does seem to be in a very good shape.

> For the doc, "exactly the same" is clean and simple and understandable
> for both Jeff and myself, I guess ;)

Ok, will tweak v2 and apply.

Thanks.
