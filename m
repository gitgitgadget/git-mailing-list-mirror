From: Junio C Hamano <gitster@pobox.com>
Subject: Re: libreoffice merge issue ...
Date: Tue, 15 Feb 2011 10:46:03 -0800
Message-ID: <7vaahxp250.fsf@alter.siamese.dyndns.org>
References: <1297699635.31477.253.camel@lenovo-w500>
 <20110215094546.GA25530@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Meeks <michael.meeks@novell.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Norbert Thiebaud <nthiebaud@gmail.com>,
	kendy <kendy@novell.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 15 19:46:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpPus-0004eI-9l
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 19:46:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755441Ab1BOSqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 13:46:21 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40927 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755214Ab1BOSqU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 13:46:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 203682E20;
	Tue, 15 Feb 2011 13:47:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0Aazl/TiVgGSjfAsqUI3dZUkMAo=; b=qWchTt
	Lxl/yhiLANoJT7eYtFpsQPXnw8wLtGkQBunMMeAdjc6mq6KNyzaI+PlwOUg9+Gxu
	KTKh822vQRVPYsj+rGPCT0ozYtN9CfkAImVtS49L8yfKYArWEvIB29eM6Pj32H1R
	FkfSJU3L7+beB1aSEMuswJv74DbOInJ1XBxBk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qzaynbUQG9yJ4VdgWCNSuPjf14vfB3qi
	eovEMx2Gf7V82smqNqRRw/ut5ZG1XR3D64nQ5TtMCcrbggfDigenNgIkaHNGj9ts
	7CrLhx/+v+2NbHg2lAXdJZ8LOe1Y6By+tkdScYfDWaoQhFstZquD4dBBtxfdKRnU
	r7gaMBZnQqA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C49B02E1C;
	Tue, 15 Feb 2011 13:47:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0C34A2E18; Tue, 15 Feb 2011
 13:47:11 -0500 (EST)
In-Reply-To: <20110215094546.GA25530@sigill.intra.peff.net> (Jeff King's
 message of "Tue\, 15 Feb 2011 04\:45\:46 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 047F474A-3934-11E0-8AF7-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166865>

Jeff King <peff@peff.net> writes:

> Interesting. I looked at both sides of the merge and the merge base, and
> there definitely should not be a conflict there. The regression bisects
> to 83c9031 (unpack_trees(): skip trees that are the same in all input,
> 2010-12-22). Reverting that commit makes the problem go away.

Thanks; I was wondering about this myself but you bisected it faster.

Will revert.
