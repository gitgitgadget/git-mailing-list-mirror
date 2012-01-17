From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Signed tags in octopus merge..
Date: Mon, 16 Jan 2012 19:31:19 -0800
Message-ID: <7vfwfft37c.fsf@alter.siamese.dyndns.org>
References: <CA+55aFzRN2F5PZDZPRmbj9occZwA6E6Pi+S+M_Qq2EfS6sctyA@mail.gmail.com>
 <7vobu3uusw.fsf@alter.siamese.dyndns.org>
 <CAJ8aY1Hi47uyYSjAmtXfDEqgyc8T21WqXdEA0kGS7SQKxQ5b5g@mail.gmail.com>
 <CA+55aFzZXSCt1AwOotMZJ+GcNcJKL2OcsPOtaZ3=cvraJ=PD+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jacob Helwig <jacob@technosorcery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 17 04:31:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rmzlf-0006Fa-2F
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 04:31:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206Ab2AQDbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 22:31:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44497 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758Ab2AQDbV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 22:31:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 418CC65CC;
	Mon, 16 Jan 2012 22:31:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=30CzrX5wDxlHPbfsT2Wd+0xKSnk=; b=yj4TVg
	Evi7B6WMavUe/otRxs9ULZ/wVzj80+mqBIYj2aZSfNQ2A0qdYKMWOGhoZ3EALZQX
	lcFUTww83Y7b/jqpKiqUpDXL4yBxyfpNqwRmN/ydrp1Cl8CQzasFFnXDgzoXxbyw
	fSorSXmHgIJfXLGG/3lg1VB6Tnl3GG+zp5H6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K81C8swLBfGJw+90RjW84k5GDozb5A22
	vxlO9PbQCrFu5tLWqqqbChisMazD/0vSEd+GwTadRzk5AXy8PIl40spmKJskpLIz
	++64y60hTkx665ZQSXlz3r6fNKYQBX1rCJ5Bixh4p3yc/0u53jmeUovHKnX4S1AT
	SxEGTCWpn40=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3928865CB;
	Mon, 16 Jan 2012 22:31:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C235065C8; Mon, 16 Jan 2012
 22:31:20 -0500 (EST)
In-Reply-To: <CA+55aFzZXSCt1AwOotMZJ+GcNcJKL2OcsPOtaZ3=cvraJ=PD+Q@mail.gmail.com> (Linus
 Torvalds's message of "Mon, 16 Jan 2012 15:06:41 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B933CC12-40BB-11E1-A888-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188683>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Jan 16, 2012 at 2:58 PM, Jacob Helwig <jacob@technosorcery.net> wrote:
>>
>> My immediate thought regarding the "side branch #1" version is not
>> wanting to have to do the math (even though it's a simple n+1)
>
> "Math is hard, let's go shopping".
>
> But I think even barbie could do the "add one" thing. That said, I
> think the current thing is already more than good enough, and I don't
> think it's at all confusing to talk about "parent #2". In fact, I
> think it's more obvious than "side branch #1".

I think Jacob is correct to point out that mice are even dumber than
Barbie and cannot do the "add one" thing, so let's leave the output as is.

Thanks for an amusing response.
