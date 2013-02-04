From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Fix contrib/credentials/netrc minor issues: exit
 quietly; use 3-parameter open; etc.
Date: Mon, 04 Feb 2013 09:27:46 -0800
Message-ID: <7vfw1c2dm5.fsf@alter.siamese.dyndns.org>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
 <7vvcafojf4.fsf@alter.siamese.dyndns.org>
 <20130130074306.GA17868@sigill.intra.peff.net>
 <7v7gmumzo6.fsf@alter.siamese.dyndns.org> <87pq0l5qbc.fsf@lifelogs.com>
 <20130131193844.GA14460@sigill.intra.peff.net> <87k3qrx712.fsf@lifelogs.com>
 <20130203194148.GA26318@sigill.intra.peff.net>
 <87k3qovxlp.fsf_-_@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 18:28:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2Pq0-0002Oo-R4
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 18:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754136Ab3BDR1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 12:27:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57869 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753654Ab3BDR1t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 12:27:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28A70CFE5;
	Mon,  4 Feb 2013 12:27:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GkFayJFdy2+qEDO50O3TOrvuER0=; b=PtR/t9
	cEvvwx4NEK7THKkAfyw5AwTjO42HqPJwz0AdkVmoU/IboPtuEg0fTWM5A6kGGUJ9
	MHxkoR87HNXQVVTCh8Qj+5t4k4R8j8RZxjZsdQXavI/lTTP8C7F+nJIcBPtRZmp2
	zBwTiYWG35ZjemAPnIfbVbMZsfDzNbOAH7CBg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bDjlqMuGrVRI7ckMVCl+CfIw1DaCdZdC
	+u3TPBMVHvxB1rH2KR9qGVGqgMhKLK0/yKYSf/9qmMkcHx5QGha7Ke0QMWL61fM3
	jDSCTYSwi8IAvhat4LFf6t0xwpz+nMh6LJzNj8lnuHGuP3vGTBK2LmwngoBid//e
	QqV1ZsxTiHM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CB87CFE4;
	Mon,  4 Feb 2013 12:27:49 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 66FCFCFDE; Mon,  4 Feb 2013
 12:27:48 -0500 (EST)
In-Reply-To: <87k3qovxlp.fsf_-_@lifelogs.com> (Ted Zlatanov's message of
 "Mon, 04 Feb 2013 11:43:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 31FBA08A-6EF0-11E2-AB07-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215401>

Ted Zlatanov <tzz@lifelogs.com> writes:

> Signed-off-by: Ted Zlatanov <tzz@lifelogs.com>
> ---
>  contrib/credential/netrc/git-credential-netrc |   38 +++++++++++++------------
>  1 files changed, 20 insertions(+), 18 deletions(-)

Especially because this is an initial submission, please equash
three patches into one, instead of sending three "here is my first
attempt with many problems I know I do not want to be there", "one
small improvement", "another one to fix remaining issues".

Otherwise you will waste reviewers' time, getting distracted by
undesirable details they find in an earlier patch while reviewing,
without realizing that some of them are fixed in a later one.

Thanks.
