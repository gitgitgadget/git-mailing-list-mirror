From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] commit-queue: LIFO or priority queue of commits
Date: Tue, 11 Jun 2013 10:02:23 -0700
Message-ID: <7vy5agbmxs.fsf@alter.siamese.dyndns.org>
References: <1370581872-31580-1-git-send-email-gitster@pobox.com>
	<1370820277-30158-1-git-send-email-gitster@pobox.com>
	<1370820277-30158-3-git-send-email-gitster@pobox.com>
	<20130610052500.GD3621@sigill.intra.peff.net>
	<7vwqq2l9cz.fsf@alter.siamese.dyndns.org>
	<20130610181557.GA2084@sigill.intra.peff.net>
	<7v1u89iyla.fsf@alter.siamese.dyndns.org>
	<20130610185907.GD2084@sigill.intra.peff.net>
	<7vd2rteej0.fsf@alter.siamese.dyndns.org>
	<20130611063648.GB23650@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Elliott Cable <me@ell.io>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 11 19:02:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmRxn-0005bA-DC
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 19:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755298Ab3FKRC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 13:02:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34096 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754878Ab3FKRC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 13:02:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 264C924841;
	Tue, 11 Jun 2013 17:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BM7VGsNQKglqTOgzOmaJJNBAyPE=; b=rrmpdv
	O3/6TAiGg2wyxlbzg+z/gyiPqaWYCJdNwmETRyTydK5xxo8iOpF+74u8o/sflmkJ
	RRChFLvm9tOA/CES8Y8qPmod3xmFdHQqSrPKErrgo7X9sQsbdCdisONVrJynGWJI
	owDRwDIQd6uvb5MS8PydrFf5b+MvCwFBzm12I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OGWsOGK6P8sHRvj+y9KvleCcibtFHpDg
	XsL1izVX7aghhxnvnIiURWbwpHJJ8dPIMnX68ubTxVBW9bOGcSHyz5VhG1gCZNfp
	McyXk2ItRnQSTLl0j8O7TskUGS4cDiZ2KjaNNgCrHBEsaOblfjpSYeKJ6zyR/Vi3
	DtHcahf6aDo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E30892483F;
	Tue, 11 Jun 2013 17:02:25 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D409424839;
	Tue, 11 Jun 2013 17:02:24 +0000 (UTC)
In-Reply-To: <20130611063648.GB23650@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 11 Jun 2013 02:36:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B05C43A4-D2B8-11E2-B18D-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227464>

Jeff King <peff@peff.net> writes:

> Overall, it looks good for me except for the commit message tweaks I
> mentioned above.

Thanks.  Rerolled; will resend when I have time (and if I do not
forget).
