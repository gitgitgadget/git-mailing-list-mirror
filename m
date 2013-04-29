From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Premerging topics
Date: Mon, 29 Apr 2013 08:08:55 -0700
Message-ID: <7vtxmpl6go.fsf@alter.siamese.dyndns.org>
References: <CALWbr2wocjqs1mpa+yuQ_Zw8m+SX24q6Pby3E3v3-jd-0w1pvQ@mail.gmail.com>
	<CALKQrgfO9fd+EEA=Vwe94tJbxkX89uDmMHm9rj6L=d4x7JJjaQ@mail.gmail.com>
	<CALWbr2x5HDU2t7hpSCkZnuKjTJ1KxYC0v50wsDPT0fm4LyvzWw@mail.gmail.com>
	<CALKQrgeGPo--cYoGZ30nSfASh4CPzqGXQojkG9Ve96NFr+LrjA@mail.gmail.com>
	<7vzjwofpht.fsf@alter.siamese.dyndns.org>
	<CALWbr2xD4i4kipp4XAdbZ7pVKD2vk_UdBdE04oU-8nhTc5Dtbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 17:09:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWphQ-0004cY-6d
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 17:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123Ab3D2PI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 11:08:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52604 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751678Ab3D2PI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 11:08:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1A051A658;
	Mon, 29 Apr 2013 15:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mIsLnzFLAC5B7URp8RqaHI+JlAQ=; b=OB+VEZ
	Rc4cxhDaS56LFyUMCvsH41aGM7exg+Ig1SS79T0rcaG9bg4FIEqy++ZuMjRfOsRp
	ycocIgJaWLB6DlEGJboFxuYDiiVb/C6aNjw++iF5A4YFk7o+NcVaIw60QYnrVr5P
	mv64bvPuFB8q8gSrBNhFDWbBEdG6hk/NwBtcY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YIIIOjgWhOqhk3C1Y3LY6QxwKpwSLTnK
	sBupyoAn73csLemkHhXAWsJATq3t5VBGMJpJUTzKJdmDJ/OMRk4TQsCs13mafB22
	NqqsKYf27YbpVa1woB/+Bvjoqwcg/PLm3AhMgZZm0mjBaEplFuTFhZ5tsfdFjF3l
	pl1MkTH2cFw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9F2A1A657;
	Mon, 29 Apr 2013 15:08:57 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 565891A64E;
	Mon, 29 Apr 2013 15:08:57 +0000 (UTC)
In-Reply-To: <CALWbr2xD4i4kipp4XAdbZ7pVKD2vk_UdBdE04oU-8nhTc5Dtbw@mail.gmail.com>
	(Antoine Pelisse's message of "Mon, 29 Apr 2013 15:04:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B6FAA648-B0DE-11E2-9431-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222801>

Antoine Pelisse <apelisse@gmail.com> writes:

> But, as it looks like you would save F on top of M, it means that M
> would be reachable, and thus rerere would be "recomputable" from
> somewhere else.

Exactly.
