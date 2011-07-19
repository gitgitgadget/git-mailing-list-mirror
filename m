From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/18] config: Introduce functions to write non-standard
 file
Date: Tue, 19 Jul 2011 14:26:13 -0700
Message-ID: <7vipqy7yiy.fsf@alter.siamese.dyndns.org>
References: <1311095876-3098-1-git-send-email-artagnon@gmail.com>
 <1311095876-3098-3-git-send-email-artagnon@gmail.com>
 <20110719195504.GA3957@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 19 23:26:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjHo9-0002jx-Tl
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 23:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011Ab1GSV0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 17:26:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53624 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751073Ab1GSV0R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 17:26:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E993B3E24;
	Tue, 19 Jul 2011 17:26:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6uFnOKF/xRhrz707BJXSkCZxY40=; b=teY568
	OQIR7H5Pb0VhdB2u5KxULfsOY0hVL2BVi2cB52jXXO4f0Et89/JssTIMKxH66kXi
	xYJkDTYoha2KLNiztzUcDr8NIL60S06wXNT6wciAEjQf+agbpVU39sU85Ox6FpHf
	uKRNYiuU71IjWXBqhoe6Cdz4slly8+aj8RtgY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MXkQOnB/6F11/5AatVbMfp0MevgdJuMw
	qSQas3divnCMpXGWBu2WRPlzemnrGsxjUpuqPGGRcKuqYVQc64uUp1zkzAcvRfrY
	S8Sy9KlhjY/Iy+Mxdhyxx0sijIYnNEIk3hJRAG2lyhPFdCx8kHBghm0TjCZQeUdp
	ImJWcVXZkX0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0F8D3E23;
	Tue, 19 Jul 2011 17:26:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A5C53E22; Tue, 19 Jul 2011
 17:26:16 -0400 (EDT)
In-Reply-To: <20110719195504.GA3957@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 19 Jul 2011 15:55:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BC6110F4-B24D-11E0-AE3B-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177506>

Jeff King <peff@peff.net> writes:

> Is there a need for this "config_exclusive_filename" hackery at all?
>
> I was thinking the result would look more like:
> ...

Exactly my thought. I think I suggested the same to Ramkumar earlier and
he said he will re-roll but perhaps this is a series before that exchange.
