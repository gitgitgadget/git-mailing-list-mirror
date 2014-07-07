From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Test failure in t9814-git-p4-rename.sh - my environment or bad test?
Date: Mon, 07 Jul 2014 14:14:58 -0700
Message-ID: <xmqqwqboc1m5.fsf@gitster.dls.corp.google.com>
References: <CABUJjW-iZU2Dp-yfuf302pNMuMj8NBXTvBW-0UHNxXdSWSk4Zw@mail.gmail.com>
	<20140707011017.GA3802@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christoph Bonitz <ml.christophbonitz@gmail.com>,
	git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 23:15:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4GFs-0006Nm-Od
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 23:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987AbaGGVPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 17:15:08 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59789 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751957AbaGGVPF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 17:15:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 016E926DC4;
	Mon,  7 Jul 2014 17:14:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vkKEEcBfbvwoTuaS8TSV5HYWg8Y=; b=bVyMny
	3ytYI5whpR/QPNrtGsh/2q2a619KSB4C1yWIAv8gM1yDf5ZjKn0mzNe0TfjJwdVk
	UUhGquYEDPBoT+xs6y2Z8GOmOqHjnkTRtIkd6qk4zQQt+RhZ/ubbivCiPwNli4c8
	kvMxDOhEyykI9/WSimaF+9pUdNj9qbHw+G+UE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pkJyybtmSzDekCw9HopHqiVn9tBdu9sv
	RCaLPB5ILwu4PXOPljzdSYQHGWo8S3tBollfiN6J2TNZjt+UFCGgBA2kbo97LbRR
	hYTwMUAgv/KVcQ2ssco206v9NHUBPpjUX9I6LRxbuJ2ZSNHUDYgCYG0XGZrV9inv
	5Q8ZuRozAGw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EB9FB26DC3;
	Mon,  7 Jul 2014 17:14:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AF8C426DB6;
	Mon,  7 Jul 2014 17:14:46 -0400 (EDT)
In-Reply-To: <20140707011017.GA3802@padd.com> (Pete Wyckoff's message of "Sun,
	6 Jul 2014 21:10:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B919C060-061B-11E4-8D2B-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252987>

Pete Wyckoff <pw@padd.com> writes:

> I'm not sure how to robustify this.  At least doing the multiple
> comparisons should make the tests work again.  The goal of this
> series of tests is to make sure that copy detection is working,
> not to verify that the correct copy choice was made.  That should
> be in other (non-p4) tests.

"Choosing any of these as the copy source is fine" is a sensible way
to fix the problem with this test.  Would it be a better solution to
avoid having multiple/ambiguous copy source candidates in the first
place, by the way?

> Do send patches based on Junio's master.  I can ack, and they'll
> show up in a future git release.
>
> Thanks!
>
> 		-- Pete
