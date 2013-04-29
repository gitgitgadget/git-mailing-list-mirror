From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Mon, 29 Apr 2013 15:50:56 -0700
Message-ID: <7vsj29eysv.fsf@alter.siamese.dyndns.org>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	<7v61z5hzqg.fsf@alter.siamese.dyndns.org>
	<CAMP44s0rT1097=481aSH=Gy465zb2Bd_xLv=Xvte-GHcamWLyA@mail.gmail.com>
	<CAMP44s0mHxv24GtpY2KzmrKQjZo+97FNN_T7tQk_peyWmusMWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 00:51:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWwuZ-0003Mk-P2
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 00:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758794Ab3D2WvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 18:51:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54360 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758190Ab3D2WvB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 18:51:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B79901A97F;
	Mon, 29 Apr 2013 22:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/boaJLVG3xOBE37JwkVva873z3Q=; b=lyrj0/
	0XS5Vy/KOntjUu9bihyb5foULSbNWvpRM2LgCNZ7HtnirbHPlDvlmNAGCj/+Vc0z
	2eVCuFG3cOn0JvcVp1VZR/kANXg1FWtDPw4Sg5b6pq2rHD6cHpxGuhirJz5sr+88
	pAGDAc6Ak7L22TShSefv8OI/88J00XKeS22TQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bprvwywc0NGQFYnqXhQrEtkgUkqQQr75
	DvkiC+KEwjm/KLAaxrw4CJMt4c6vdfR5pe3m/rl1aZR0MX6AMgxKtG3MxYNBtY3T
	V3RcqiVZb1eb68SyaxppK3w0GrNmtw1VdG9JI9AH/xRWWiq8FYFi3kEW+QuW7jjY
	ZUPNUMmgsaU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADAE51A97C;
	Mon, 29 Apr 2013 22:50:58 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 336161A97A;
	Mon, 29 Apr 2013 22:50:58 +0000 (UTC)
In-Reply-To: <CAMP44s0mHxv24GtpY2KzmrKQjZo+97FNN_T7tQk_peyWmusMWA@mail.gmail.com>
	(Felipe Contreras's message of "Mon, 29 Apr 2013 16:36:21 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 41E55B96-B11F-11E2-B587-8D009ADAE8A5-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222874>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Never-mind, now I see the difference, still, I don't think it's
> relevant for this patch.

I don't either. With the precedence of @{u}, @ does not need to have
anything to do with a reflog. It is just a random letter that casts
a magic spell.
