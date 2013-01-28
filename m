From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/4] Auto-generate mergetool lists
Date: Sun, 27 Jan 2013 18:27:04 -0800
Message-ID: <7vr4l6yrd3.fsf@alter.siamese.dyndns.org>
References: <1359334346-5879-1-git-send-email-davvid@gmail.com>
 <7v38xm12kk.fsf@alter.siamese.dyndns.org>
 <CAJDDKr7sQKDNPpaFJi+en479TF=aLXL2pvXODeo6CC3xD1KMGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 03:27:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzeRX-0001Vh-Jj
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 03:27:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645Ab3A1C1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 21:27:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42832 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751143Ab3A1C1H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 21:27:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D351AB185;
	Sun, 27 Jan 2013 21:27:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6s4PYWWAavnktxm1sqLYFspAQXE=; b=rmoO0d
	mqVSjogcOE0YbTilYj03UzOfp4+ZyXmDtS770ey6BNU39lqj/CX3jGFr2QuR2itp
	24tANZZmfFQx8GGF5gBiRdO85pvL184XdybwLy5IDRhfrFg7Wv7uK0yguv+sLzgM
	aEnN/MZYvvqGgYiT2pvnUa3RjiXzmxcku70xQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gQwtxvBCJf0wrvNIqrE6/cNXtQeEEXpN
	1ieL1sgoUeZI4Z1Ic3UdzYKVBD3aWXgmod0uT+WY3gIKWFHCWe5Ne4v2etf0B8eO
	rLrJVcFaT5Jw0pTlzahRZ5YZNLsAPAdwkK47nFjZFu6Fjj4Y5GEO6MXnrrX7Lz3+
	rE2EF7ha5e8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C79EFB184;
	Sun, 27 Jan 2013 21:27:06 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 53845B183; Sun, 27 Jan 2013
 21:27:06 -0500 (EST)
In-Reply-To: <CAJDDKr7sQKDNPpaFJi+en479TF=aLXL2pvXODeo6CC3xD1KMGw@mail.gmail.com> (David
 Aguilar's message of "Sun, 27 Jan 2013 18:21:00 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3580425A-68F2-11E2-8A49-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214789>

David Aguilar <davvid@gmail.com> writes:

> On Sun, Jan 27, 2013 at 6:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> I think our works crossed, while I was tweaking the previous series
>> to push out as part of 'pu' you were already rerolling.  Could you
>> compare this series with what I pushed out and see if anything you
>> missed?  I think I fixed the (a && b || c && d) issue in the version
>> I pushed out, but it is still there in this series.
>
> Ah, I see.
>
> I can add the addition of preamble for use by show_tool_help()
> as a follow up along with using a here-doc when printing.

I think the progression of the series is just fine as-is with the
new series you posted (I didn't amend the old one with all the
suggestions I made in the review, just only with the more important
ones that would affect correctness, so please consider that the
changes you have in this new round that I didn't have in 'pu' are
good ones to keep.
