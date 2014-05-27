From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/15] builtin/add.c: rearrange xcalloc arguments
Date: Tue, 27 May 2014 15:41:35 -0700
Message-ID: <xmqqsinueteo.fsf@gitster.dls.corp.google.com>
References: <1401118436-66090-1-git-send-email-modocache@gmail.com>
	<1401118436-66090-2-git-send-email-modocache@gmail.com>
	<CAPig+cRE0LUaNLTJARBCmoDn7cR1bbgi8At0ChgSDWBjDPaNjg@mail.gmail.com>
	<CAN7MxmXVDTiQv5J9cU2E8iS=BNROw3q9NVaBuG7aQP-7=Qo_ZQ@mail.gmail.com>
	<CAPig+cTmyBzroDOnqEb_GWqhcbgbK27pT3=3VCVOnj13=C4CfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gesiak <modocache@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed May 28 00:41:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpQ40-0001QN-Sx
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 00:41:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbaE0Wll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 18:41:41 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61274 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751710AbaE0Wlk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 18:41:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 115601B38A;
	Tue, 27 May 2014 18:41:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fc4eDfm1dJeZiBJEaX/ha54SR2w=; b=L0wA88
	VmjLvUhZV261d+EV+NLmGOn/XyEgEOF7pQ5cbpjRAd1/yS/4bxiMUFJ2vovYXwR7
	SvPrphHncnTQFzWUczAAC2z3ttC9GscBpA1ELSEUYnHwgf6EwPTEsvgwxlpkKYBV
	xoc6nLJynPU4r5KV5CWeZ+kgsrp4Q3XbN3tTM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wjp4cHNfIezNT+H9tXR38Kbx7r24hQSO
	c1VywzoO/wDNnsI4eqkIGXHdXM9/OUYC2I4WDppi3sx9TzQAkejohn/aPB0WpvMo
	v9knx+wRcFuo2rRTEtDV1haqoa23Hr5SqPeLKCAJ3asQXR7vLj8Cgb+HriVnrjQk
	QtAzxINe1OQ=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 067681B389;
	Tue, 27 May 2014 18:41:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B89761B386;
	Tue, 27 May 2014 18:41:36 -0400 (EDT)
In-Reply-To: <CAPig+cTmyBzroDOnqEb_GWqhcbgbK27pT3=3VCVOnj13=C4CfA@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 27 May 2014 17:35:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0F965896-E5F0-11E3-9A5C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250244>

Eric Sunshine <sunshine@sunshineco.com> writes:

> If you do re-roll, perhaps consider simplifying the commit messages.
> The patch itself states concisely and precisely what is being changed;
> the lengthy prose description doesn't really add anything (and makes
> more work for you and the reader of the message). It might be
> sufficient to use a single-line (Subject:) commit message, like this:
>
>     builtin/add.c: fix order of xcalloc arguments

Yeah, I like that.

I do not think it is worth doing this change starting from maint, so
I've dropped this one and a few others that did not apply to master
and queued the remainder to 'pu'.
