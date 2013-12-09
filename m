From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2013, #02; Fri, 6)
Date: Mon, 09 Dec 2013 14:51:05 -0800
Message-ID: <xmqqtxehvdt2.fsf@gitster.dls.corp.google.com>
References: <xmqqk3fh1qrc.fsf@gitster.dls.corp.google.com>
	<87ppp8h9ut.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
	<20131209223345.GB11677@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <tr@thomasrast.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 09 23:51:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq9fo-0002eE-GP
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 23:51:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754742Ab3LIWvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 17:51:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55195 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752951Ab3LIWvK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 17:51:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77153593FE;
	Mon,  9 Dec 2013 17:51:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JCHUg7YTOo7YxtI49qBYy7PPIeM=; b=tTExw8
	dHQRlPH3yCr1HFq0xSqUdvHE3XNoExXCh3lzam77BoWYMoeAJOF7QQpoQkU2S6VF
	nVk2QHbIEr9G8QW27Wp1obZLsV+MhLYcp+ZkKzOk6SEcQuff6Yz+Ja9tmtkWl6Ax
	h/L4+4wMYMxULEhExZyDpPwjUz/229mXT335U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qR0NmvAwIzwbDq/8Lz63jKuzoPTIy/ON
	PGQQzEUJPuYz0BKgnncf8SgKwm7TtU/LbIJjd+aRTUCbBL0T65y8rWxWJJ6r0ZXC
	oLOaqpcdWr8lGowGT6DX08UK/BJvYC7fg0IuBzm0x9FljC/tab2WkWcMBPjOy59n
	nmQzi2aWg5Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F7B2593FD;
	Mon,  9 Dec 2013 17:51:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76A10593FC;
	Mon,  9 Dec 2013 17:51:08 -0500 (EST)
In-Reply-To: <20131209223345.GB11677@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 10 Dec 2013 06:33:47 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 648D57F6-6124-11E3-B785-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239116>

Jeff King <peff@peff.net> writes:

> On Sat, Dec 07, 2013 at 06:03:22PM +0100, Thomas Rast wrote:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > * jk/pack-bitmap (2013-11-18) 22 commits
>> [...]
>> Peff can decide if he wants to reroll with my nits or not; either way
>> I'm all for moving it forward and aiming for one of the next releases.
>
> I'm going to be a bit slow this week, as I'm traveling in China.
>
> I have at least one more local fix queued up (one of the re-rolls
> introduced a use-after-free). Your comments make sense to me, though
> some of them are "if this is not too hard", and I haven't looked yet to
> see how hard some of the requisite refactoring would be. So expect at
> least one more re-roll, and I'll try to incorporate your comments.
> Thanks for giving it a careful reading.
>
> As an aside, we have been running the last version sent to the list
> (modulo the fix I mentioned above) on github.com for a week or two
> (previously we were running the old, based-on-v1.8.4 version). So it is
> getting exercised.

;-).
