From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Sharness v1.0.0
Date: Tue, 14 Jun 2016 14:43:19 -0700
Message-ID: <xmqq7fdr8n0o.fsf@gitster.mtv.corp.google.com>
References: <CAP8UFD0uvaB-2_CrXs2ZvoqLRHfCd8efA-S7-tE2Qa6Pn+rAAg@mail.gmail.com>
	<20160614213453.GA21560@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	Mathias Lafeldt <mathias.lafeldt@gmail.com>,
	Alexander Sulfrian <alexander.sulfrian@fu-berlin.de>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	John Keeping <john@keeping.me.uk>,
	Konstantin Koroviev <kkoroviev@gmail.com>,
	"Mark A. Grondona" <mark.grondona@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Maxim Bublis <b@codemonkey.ru>,
	Richard Hansen <rhansen@rhansen.org>,
	Roman Neuhauser <rneuhauser@suse.cz>,
	Simon Chiang <simon.a.chiang@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 14 23:43:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCw7L-0001PT-2m
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 23:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbcFNVnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 17:43:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56206 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751119AbcFNVnW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 17:43:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7809125DF4;
	Tue, 14 Jun 2016 17:43:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=niGAVC/GQv4OIralxCu3BFjlniA=; b=pkEU9g
	kZOICO9ldKKB1MLJGAoQi7kjhe+RiyCs/ySzwiNFTHd61tGPGV9Nc1vZYicMghzp
	49x5XCERoJqiK9J4nOnlLhrcnW9jTvSbX1mYrP+VNifDyJuwAX0hnQj06dGqomQB
	Uy84MmyYifzpNxzpNZA96IAwmmHtcZcMiMPYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h9CqP0fYfENgMcYqJhaX3IZWs6+Xa/XF
	z0udgbkpQ61+Sn0iKify5lrTPyklPMHvc8NyklpFXY8WuMF3ZzrEp/MOeN074Ajr
	vVpFRnN9q2IC7MFcRy8QOTwxdmq2pchGt2b5IzDNR5NwDq6IdI6nKTyHQUHeZsEn
	kwr2Vy9ddkI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7043425DF3;
	Tue, 14 Jun 2016 17:43:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F00A325DF2;
	Tue, 14 Jun 2016 17:43:20 -0400 (EDT)
In-Reply-To: <20160614213453.GA21560@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 14 Jun 2016 17:34:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 03623E3C-3279-11E6-9DE5-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297336>

Jeff King <peff@peff.net> writes:

> I don't think the Git project would ever want to say "sharness is the
> upstream, and we are now just a user of it". But I wonder if we could
> break down test-lib.sh to keep the Git-specific parts separate, which
> would make it easier for sharness to pull the other bits as a whole.

I took a quick look around, and it seems that this is an outdated
fork made without getting much of the improvement from its upstream
since it forked.  It does not seem to have lazy prerequisite, for
example.
