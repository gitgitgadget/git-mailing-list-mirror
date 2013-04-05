From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] diffcore-pickaxe: remove fill_one()
Date: Thu, 04 Apr 2013 21:43:42 -0700
Message-ID: <7v1uapfuyp.fsf@alter.siamese.dyndns.org>
References: <7vr4iqi2uw.fsf@alter.siamese.dyndns.org>
 <004969e2ef9bb8017ce66e36b60a447ab35068d0.1365105971.git.simon@ruderich.org>
 <20130405000847.GB27775@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon Ruderich <simon@ruderich.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 05 06:44:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNyVb-00068H-LY
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 06:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474Ab3DEEnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 00:43:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53203 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366Ab3DEEnp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 00:43:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F54211AB0;
	Fri,  5 Apr 2013 04:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/orAXdRxXSxJ5tiHx392yJc3ScY=; b=dTJYwv
	l+BNRJupkzfpFmxepHITw1fcY8hnSmUx2ohi/HA/LQ2vla8MnFUP58N/TBwE2+xb
	6BNthGoSGElH9MIA5Wesrooq29OljKCcZxRVIQzsGdKrHgCM4ARKLIyKy2iNm77r
	OAluUcfN9lidFLHCXdvTj94V9kN2tEcziyWAk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N+h54pCS/UC+OEXBvAThVspRi5ukZDq6
	9gm2Ueyqy6QmOkhpDdb+hlm9YeTuJ9kuLuf6oFlSNFW3CLLz0Tg5D/z5gzCBxagZ
	SXqHqa6q33FnI9Ps/AtCoizwuuy5Pg8eYK2kVrXEfJp+XjX835Dguke+hxvSx78Y
	EWiji7PdR8E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0650C11AAF;
	Fri,  5 Apr 2013 04:43:45 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8114211AAB; Fri,  5 Apr
 2013 04:43:44 +0000 (UTC)
In-Reply-To: <20130405000847.GB27775@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 4 Apr 2013 20:08:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 65AD713A-9DAB-11E2-91A6-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220136>

Jeff King <peff@peff.net> writes:

> Thanks. The whole series looks good to me. I think Junio's proposed
> cleanup is a good direction, too, but I don't mind if that comes on top.

I'll send out a three-patch follow-up shortly.
