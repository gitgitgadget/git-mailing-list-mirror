From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] format-patch: introduce format.defaultTo
Date: Tue, 07 Jan 2014 14:06:12 -0800
Message-ID: <xmqqr48jbg6j.fsf@gitster.dls.corp.google.com>
References: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
	<1389028732-27760-3-git-send-email-artagnon@gmail.com>
	<xmqqlhythrzq.fsf@gitster.dls.corp.google.com>
	<CALkWK0kZn44x98td9YXNT5VfhVs=ueeSty9M7Vh08bdoGjGQYg@mail.gmail.com>
	<xmqqa9f8j2n8.fsf@gitster.dls.corp.google.com>
	<20140106201854.GA28162@sigill.intra.peff.net>
	<CALkWK0k21W4gz9Rm8CyLMwjXq2A9wvm=XCVDsqs06oeW3VUg6w@mail.gmail.com>
	<20140107205618.GA28102@sigill.intra.peff.net>
	<xmqqvbxvbiwz.fsf@gitster.dls.corp.google.com>
	<20140107212432.GD28102@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 07 23:06:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0en1-0005Xm-3W
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 23:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754191AbaAGWGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 17:06:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62400 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753515AbaAGWGS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 17:06:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63E4A61F4F;
	Tue,  7 Jan 2014 17:06:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nGTByOVZ4WdzMgLVmHK4Wm0gsiM=; b=GdECiW
	hPE/8T/C/I4g3hdVp5AwoSnlH+jphPNRP3/6FUah/rbvAOTRpEpb5g9EfZf3O1Gm
	+ZsRV+sihLKQsYv2/bRDyfWtoIQhQDbpVyo21mNbH1wUz5ln7J7hVq4z2nCJ/2Zr
	/WqsCRfFWSZ6I0AOQbgNYobZNQrENhZsgMs80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G91jaHjCAKZmhUpFko1lGCX2dVTT1UNY
	6DHgiwUM8m+qzCAaXGpy9KnKMzTUPF8cymV+k5yz3+F/z3VQuH4Uu1i8gaKu/IEa
	x5/aTe8rbpgFNtjJtvjyQzskMOg85NCwlshP5U9Y2/lj24rfqNuGX2wDN8/BcmeO
	t53OzpzEU2M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 261BE61F4D;
	Tue,  7 Jan 2014 17:06:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0CA5061F4B;
	Tue,  7 Jan 2014 17:06:15 -0500 (EST)
In-Reply-To: <20140107212432.GD28102@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 7 Jan 2014 16:24:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EDB750FC-77E7-11E3-BE46-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240167>

Jeff King <peff@peff.net> writes:

> I think that is sensible, and only heightens my sense of the "upstream"
> push.default as useless. :)

Yes, it only is good for centralized world (it was designed back in
the centralized days after all, wasn't it?).
