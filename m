From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] push: make non-fast-forward help message
 configurable
Date: Wed, 09 Sep 2009 14:47:21 -0700
Message-ID: <7vocpjpz86.fsf@alter.siamese.dyndns.org>
References: <20090909112623.GA30765@coredump.intra.peff.net>
 <20090909113858.GA31051@coredump.intra.peff.net>
 <7vr5ugszte.fsf@alter.siamese.dyndns.org>
 <20090909203939.GA10438@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 09 23:47:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlV0y-0003KJ-IE
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 23:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754045AbZIIVre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2009 17:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752924AbZIIVre
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 17:47:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42487 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752815AbZIIVrd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2009 17:47:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DECA2C2B6;
	Wed,  9 Sep 2009 17:47:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8EzFDJcmO1i0XThBbawFMZoQBUI=; b=XcduDt
	/l+34c7sa9J8Phm/Nh9xqKinHDPM/a3odjxpC+je8AG29Q/5FcrMrIEtGbgHDJkr
	7qlCQn/Rz4x92P/qnQdl1JHjqSL6jg7lJr7aZ1WlHj7GRSfqdXskYCFODFU02uIw
	im/Zt/1W9tvlD+CkO0UnSdu30RVBJFE8kSfsM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CUeLd2LQ+S0K7jvfDdSKb75Cw+ZP+Kpu
	GFwG3+gbeL2qM63MuskBz09pJNOE6Uf2IzGMpw47bPGDrJK6DhYQLBYHEXWRYeQC
	cTyCokcvBTCUeOMFi7mgg4uLBpsTomySNek9H/XoLqp1U4EBi1Jq9SQ4MVBI3tTs
	FOt7q3Ca9Ng=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C76B02C2B3;
	Wed,  9 Sep 2009 17:47:29 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB8302C2B0; Wed,  9 Sep
 2009 17:47:22 -0400 (EDT)
In-Reply-To: <20090909203939.GA10438@sigill.intra.peff.net> (Jeff King's
 message of "Wed\, 9 Sep 2009 16\:39\:39 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5F50C9BA-9D8A-11DE-9CAF-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128084>

Jeff King <peff@peff.net> writes:

> ... It also turns typo-checking into
> a run-time error rather than a compile-time error, which is IMHO a bad
> idea. And if you care about such things, it is worse for using something
> like ctags to find variable uses.

Fair enough.
