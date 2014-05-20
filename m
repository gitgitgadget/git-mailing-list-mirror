From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Tue, 20 May 2014 14:11:35 -0700
Message-ID: <xmqqy4xwrw8o.fsf@gitster.dls.corp.google.com>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
	<20140516084126.GB21468@sigill.intra.peff.net>
	<xmqq8uq1br9c.fsf@gitster.dls.corp.google.com>
	<20140516225228.GA3988@sigill.intra.peff.net>
	<5376f2ca5c90d_65b915db2f877@nysa.notmuch>
	<20140517062413.GA13003@sigill.intra.peff.net>
	<xmqq1tvq4r43.fsf@gitster.dls.corp.google.com>
	<53795ef8e4023_10da88d30825@nysa.notmuch>
	<xmqqegzp1tl7.fsf@gitster.dls.corp.google.com>
	<537bbd6c1daf_a6f166b308b0@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 23:11:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmrK4-0001QW-Pa
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 23:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbaETVLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 17:11:41 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51344 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750834AbaETVLk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 17:11:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D82D3196AA;
	Tue, 20 May 2014 17:11:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vhae/dFPMKG8mYwysW5OFPIRYVI=; b=tCn7HN
	JKuIzXcNbBtAy4EwqYmoj42F/N2CnlUEDLAY8tMhA5XxAiDZLNQX0VC8hGf1xz49
	xXhy/lqWpEd6ewTnaDBtM/RW6esoSVG0AeG/Wdpr3FJXoz4xs8z5+giU99bKlFid
	jXCzTSPPUO2h90G6WRZ17EQ+1cB8ORAlqgudA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qnuq4n1zDuLqioAA+EnFJ7Hgr2TL1ABR
	TbS0W1Sm7agXySlX0BHH86QdUJsI6/SdujRWCSOrlqDLGiC36w/6vpIvT0x7p5QT
	YUCUkFE9MbmwRYkJeThM933mTUUXnBc+nB6WqvWPHIf52Kbl2XfgT2ooJJ5lEAsR
	cxNN/UAqeAA=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CF099196A8;
	Tue, 20 May 2014 17:11:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CAA5D196A2;
	Tue, 20 May 2014 17:11:36 -0400 (EDT)
In-Reply-To: <537bbd6c1daf_a6f166b308b0@nysa.notmuch> (Felipe Contreras's
	message of "Tue, 20 May 2014 15:39:08 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 54170F02-E063-11E3-B5B0-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249744>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> Let's try this in a different way, as I sense there is a
>> misunderstanding somewhere about your "wish".
>> ...
> No, I already said I do not want the code removed from v2.0, that's why
> I sent patches that simply added a warning, and I specifically said
> those were for 2.0.

Yeah, I think there are mails crossing.  I sent that "different way"
way before I read your "already said" happened.

> So to make it clear, I now request that you do:
>
>  1) Remove all the code.
>
>     Since my patches were removed from the list, here's an updated patch
>     that applies on top of 'master'
>
>     https://github.com/felipec/git/commits/up/remote/remove

I'll do that, but just one thing to make sure---do you want the
helper to exit with status 0?

>  4) Re-add the following release note:
>
>     * "git push" via transport-helper interface (e.g. remote-hg) has
>       been updated to allow forced ref updates in a way similar to the
>       natively supported transports

I am not sure if this one is consistent with 1), as remote-hg will
no longer be with the release.
