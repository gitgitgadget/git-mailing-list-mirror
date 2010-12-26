From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2010, #06; Tue, 21)
Date: Sun, 26 Dec 2010 11:28:06 -0800
Message-ID: <7vzkrsxrjt.fsf@alter.siamese.dyndns.org>
References: <7vlj3i5zz9.fsf@alter.siamese.dyndns.org>
 <201012261146.35961.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <ydirson@altern.org>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Dec 26 20:28:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWwGV-0006dn-BB
	for gcvg-git-2@lo.gmane.org; Sun, 26 Dec 2010 20:28:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545Ab0LZT2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Dec 2010 14:28:18 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50755 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447Ab0LZT2R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Dec 2010 14:28:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2F3402933;
	Sun, 26 Dec 2010 14:28:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KP5hQbvwz81vykSc18oXXOckaas=; b=x7GbaG
	/RnJaRkQW8re9EcGekhOkwpkxJpHMuAvV6dgV78MxIrCNmq+dl1c9HPX+Mi+E24z
	LJr7953YraHTngWJlPHozRl3KohVfg2BWLMR5A19sqOvtCXZX2DurwmLjDqU8gKn
	+aL3t2gwBS7qyvJO9x8QywIThKuuB1bLgaPeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QjsGXrbnkaFRjKdpjYwcY6SBhr8nUGR3
	ZFlySgg1VNdAbybWzF8FiAl/2Svg3cDJoAA/CBrhEWVtoh3BwYtR3wRr3c3wKLzx
	AM/TAWtC6zu8cm41trGrRd6Sa7C1MmsZMOUV6zCo1LQrzBqXseh990lxuxILatgN
	yrpaVTgTRa4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EF46E2932;
	Sun, 26 Dec 2010 14:28:42 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D88B9292E; Sun, 26 Dec 2010
 14:28:38 -0500 (EST)
In-Reply-To: <201012261146.35961.trast@student.ethz.ch> (Thomas Rast's
 message of "Sun\, 26 Dec 2010 11\:46\:35 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5983A3C0-1126-11E0-9634-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164199>

Thomas Rast <trast@student.ethz.ch> writes:

> Junio C Hamano wrote:
>> * yd/dir-rename (2010-10-29) 5 commits
>>  - Allow hiding renames of individual files involved in a directory rename.
>>  - Unified diff output format for bulk moves.
>>  - Add testcases for the --detect-bulk-moves diffcore flag.
>>  - Raw diff output format for bulk moves.
>>  - Introduce bulk-move detection in diffcore.
>> 
>> Need to re-queue the reroll.
>
> This BTW does not even compile on OS X because of its use of memrchr.

Thanks for an early warning.  I am planning to do an 1.7.4-rc0 soon
anyway, so in the meantime I'd drop this and wait for a resubmission for
the next round (I think I saw a larger re-roll that I didn't pick up).
