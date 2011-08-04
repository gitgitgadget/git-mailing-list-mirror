From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-archive's wrong documentation: really write pax rather than
 tar
Date: Thu, 04 Aug 2011 15:51:09 -0700
Message-ID: <7vei104wpu.fsf@alter.siamese.dyndns.org>
References: <1312409879.97173.YahooMailClassic@web29501.mail.ird.yahoo.com>
 <20110804014143.GA32579@sigill.intra.peff.net>
 <20110804021329.GB32579@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hin-Tak Leung <htl10@users.sourceforge.net>, git@vger.kernel.org,
	rene.scharfe@lsrfire.ath.cx
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 05 00:51:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qp6l2-00018L-IU
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 00:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089Ab1HDWvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 18:51:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57572 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751644Ab1HDWvM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 18:51:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 236FC4E79;
	Thu,  4 Aug 2011 18:51:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+xVJiDe8ClSxp/wou9762kqdhvI=; b=LxM3Xb
	P0OS48U/7viFEZlK4Rg7vNY705RsZ+fB+x+z8A8CuDyREoYjtWSgfMIUUK1mPDg3
	BSFbi3XojOLHv0f8o5eCIWPRvAKzywNjZcOJYOT/vgO/ekhhL+fh4WrWHioUZRem
	e1oyGrsxm2wMZHoH2kOc4Fbjoi0iIuYh0aBag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wLF4b40LByOQc/z6u2bCRxB792n/L6Sq
	S8ueizCqPAsKuP+yys1s20W5RSfb/3CVeaTAx0W72rqzQKftWUMz6ZcMDeu5NNWX
	/pAhdCXGMkrzUVHPu3Jr5SnB0iJ1Kfzhrq35tRS3qghenJevj/KDW6QffUYd7mZ3
	WOQZvy9Il0o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A20B4E78;
	Thu,  4 Aug 2011 18:51:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A5C554E77; Thu,  4 Aug 2011
 18:51:10 -0400 (EDT)
In-Reply-To: <20110804021329.GB32579@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 3 Aug 2011 20:13:29 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3F6EDCCE-BEEC-11E0-8911-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178776>

Jeff King <peff@peff.net> writes:

> As a bonus, this also fixes an example in the git-push manpage, in which
> "git push origin :::" was accidentally considered a newly-indented list,
> and not a list item with "git push origin :" in it.

Thanks. That "happens to have colon at the end" one is nasty.
