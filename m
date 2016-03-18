From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GIT PULL] GPIO bulk changes for kernel v4.6
Date: Fri, 18 Mar 2016 10:16:55 -0700
Message-ID: <xmqqk2kzr9iw.fsf@gitster.mtv.corp.google.com>
References: <CACRpkdbGkfJ9bW1db64msMeQjue+=y+op5EmSx62FWOWDOJwWg@mail.gmail.com>
	<CA+55aFwV4Cq=4zJc6Fw0yAGrTmci_DFAjJKxkk05pjJJf3iYbA@mail.gmail.com>
	<56EB9B0C.4050507@nvidia.com>
	<CA+55aFy=-UAbVo+Xx08tBA7eTPk2B+G3=SbarVxThS57LdakPA@mail.gmail.com>
	<alpine.DEB.2.20.1603181532040.4690@virtualbox>
	<CA+55aFwbRVG-5AW+NnMOFZ_hU5i+i7f3FxgEt9Qm7B6pEd7x0g@mail.gmail.com>
	<xmqqr3f7rbck.fsf@gitster.mtv.corp.google.com>
	<CA+55aFzVqPzEg6zq7sRweE7OCVKMJzM1eZRHXddMG+BabEDeCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-gpio\@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-gpio-owner@vger.kernel.org Fri Mar 18 18:17:01 2016
Return-path: <linux-gpio-owner@vger.kernel.org>
Envelope-to: glg-linux-gpio@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-gpio-owner@vger.kernel.org>)
	id 1agy1D-0004DW-Vx
	for glg-linux-gpio@plane.gmane.org; Fri, 18 Mar 2016 18:17:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755500AbcCRRQ7 (ORCPT <rfc822;glg-linux-gpio@m.gmane.org>);
	Fri, 18 Mar 2016 13:16:59 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60990 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755089AbcCRRQ6 (ORCPT
	<rfc822;linux-gpio@vger.kernel.org>); Fri, 18 Mar 2016 13:16:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EF4934D392;
	Fri, 18 Mar 2016 13:16:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3qtouYfsc9TxrwIEdlZ8w/Qj36s=; b=bmCYIP
	xQRzcWaqzUSMgMQfc57vslqXDYIodV3k3SOSL0PTieyp0/ijTf/WFnHLEAsB+fRO
	XfWZGyXtO7mLjjBznhPD6izrDU+NFm7rQkjtZssU6M8lFUanUgJVKoV3dto2PWua
	StN3p9bRgp5EwjZsgNAgMPEeJTjKk4XcYpu20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uA3qAmrIAF7iDj+mk/Su0kjPJ3uvWlrt
	s4pIQqaIumLe8AbY8UaJWD2Rc4gYfbZBBetcAgZyKkgdJci3OFAS5J7FQFUvLBGd
	4/WAPIyRE7VhvJLfpfz7NDom0Wc5gHn7fIsynlDmmW3o/hhPbFlVMA66ESuwSZ1p
	1P4thq+brFY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E62514D391;
	Fri, 18 Mar 2016 13:16:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5C19C4D390;
	Fri, 18 Mar 2016 13:16:56 -0400 (EDT)
In-Reply-To: <CA+55aFzVqPzEg6zq7sRweE7OCVKMJzM1eZRHXddMG+BabEDeCA@mail.gmail.com>
	(Linus Torvalds's message of "Fri, 18 Mar 2016 10:01:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 377893F6-ED2D-11E5-89C3-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: linux-gpio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-gpio.vger.kernel.org>
X-Mailing-List: linux-gpio@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289233>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> The code in the recursive merge that allows this to happen is this:
> ...
> And I do think that's right, and I think it's clever, and it goes back to 2006:
>
>   934d9a24078e merge-recur: if there is no common ancestor, fake empty one
>
> but I think there should be an option there.

Oh, I think everybody understands that and agrees by now.

