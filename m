From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2015, #07; Fri, 20)
Date: Sun, 22 Mar 2015 12:08:08 -0700
Message-ID: <xmqqegogdf53.fsf@gitster.dls.corp.google.com>
References: <xmqqr3sjcopt.fsf@gitster.dls.corp.google.com>
	<423416FC-1048-4D3A-B997-F1F796627242@gmail.com>
	<xmqqegojc9yd.fsf@gitster.dls.corp.google.com>
	<20150321201530.GM612775@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sun Mar 22 20:08:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZlEU-0006Tg-3v
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 20:08:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbbCVTIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 15:08:17 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50322 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751832AbbCVTIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 15:08:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 99B48419AE;
	Sun, 22 Mar 2015 15:08:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VXZBUR2nyyxtYY5mN3SIOE+G/9c=; b=bgTIdo
	mkGTraVVLqWyiFFnmOrxkD3cwxx1wQiTjMaMEKRrdXh1ZCJeJQxqcmNL9aTE6FmG
	X38qykEsuMtQytzj5nhZFut1FjWRtmzXkQNlSj0ZbpxcBn7a4eDoZVoDAt2/a+Bl
	JMjgx5xs02IfEEFeOLZHA8FpMxu+KIYgnBsSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wR418LKb+AEvoAjOzc6L1sNjp4811JZa
	70HMQTpHEEi/FCndHPrsALyqHw2SJ8Ty7ToJ+0vkfUQ3pCwmAj7xcIqLpxTczQKB
	g7fe4eieUbK5KtZ5ZdJWtWoZHOzOzPhLigLwtNIr62+94VIQykmia+G+AOI/IAf8
	6/qUEol+cXA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9279E419AD;
	Sun, 22 Mar 2015 15:08:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 198E2419AA;
	Sun, 22 Mar 2015 15:08:10 -0400 (EDT)
In-Reply-To: <20150321201530.GM612775@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Sat, 21 Mar 2015 20:15:30 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C7BE4430-D0C6-11E4-AD21-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266082>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Fri, Mar 20, 2015 at 08:20:58PM -0700, Junio C Hamano wrote:
>> I had an impression that the series may see at least one reroll to
>> polish it further before it gets ready for 'next', as I only saw
>> discussions on the tangent (e.g. possible futures) and didn't see
>> serious reviews of the code that we will actually be using.
>
> If people have suggestions on how to improve it, I'm eager to hear them
> and submit a reroll or follow-up patches, as appropriate.  Making
> changes now would be much better than having to do it down the line.

Yeah, agreed on the last point, and that is why I kept it out of 'next'
before people have enough time to think about it.

Thanks.
