From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] t3900: do not reference numbered arguments from the
 test script
Date: Thu, 11 Aug 2011 14:49:19 -0700
Message-ID: <7v1uwrr540.fsf@alter.siamese.dyndns.org>
References: <20110321105628.GC16334@sigill.intra.peff.net>
 <cover.1300872923.git.git@drmicha.warpmail.net> <20110324082108.GA30196@elie>
 <20110808011341.GA19551@elie.gateway.2wire.net>
 <20110808011709.GC19551@elie.gateway.2wire.net>
 <4E40F3EA.8020406@viscovery.net>
 <20110809153638.GA15687@sigill.intra.peff.net>
 <4E437F4C.4020305@viscovery.net>
 <20110811071155.GA28213@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 11 23:49:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qrd85-0000Zz-CJ
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 23:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312Ab1HKVtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 17:49:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51345 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260Ab1HKVtX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 17:49:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 933B943AD;
	Thu, 11 Aug 2011 17:49:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f1g1PYhgHFRg/vp+W+TY1yapDZI=; b=KIKQrN
	v6k7wWAghBw2vIjRl7hSS8xfzT41bTpI8groOtr1KCLviXZ89xy548r7uA7eM/9y
	Lr3+wglyKeIAKT1QEtirsWR7Ka8DKVFOuxpKHKG8/W+n+82t9F+PquO9W6NozgCe
	BIuWErRf1dUpoFmuFNOZmNxPVcH6Fd6djMc1M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TsZi7UZ5/MbKkG1yNziZc8nrrWvg6mgp
	EMFFWmmld+lbPZw2ZUjUAWtTR0mTwMqHsqByPO/UY/83B7ZVmbrcfSrmKnt8onEp
	J83vFxuJISRNsoZ29tMv+QdqJFMZikiLu8Tmq5am/1UcPFh+WH6Ez8B1i4JTtcn7
	CCX+mxa7mzA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A5A043AC;
	Thu, 11 Aug 2011 17:49:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 044BE43AA; Thu, 11 Aug 2011
 17:49:20 -0400 (EDT)
In-Reply-To: <20110811071155.GA28213@elie.gateway.2wire.net> (Jonathan
 Nieder's message of "Thu, 11 Aug 2011 02:11:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C531DCFE-C463-11E0-90C4-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179145>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Johannes Sixt wrote:
>
>> Remove it because -m is optional and the test case
>> does not check for it. There are tests in t7500 that check combinations of
>> --squash and -m.
>
> That's a comfort.  Looks obviously good to me, fwiw.

Yeah, looks sane. Thanks everybody.
