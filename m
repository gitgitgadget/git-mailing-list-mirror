From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] parse_date: fix signedness in timezone calculation
Date: Mon, 05 Jul 2010 19:35:58 -0700
Message-ID: <7vy6dp72wh.fsf@alter.siamese.dyndns.org>
References: <20100704104834.GA23070@sigill.intra.peff.net>
 <20100704110017.GA23121@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 06 04:36:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVy19-0006fH-F5
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 04:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755009Ab0GFCgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 22:36:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46041 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755039Ab0GFCgH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 22:36:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3957DC2B2B;
	Mon,  5 Jul 2010 22:36:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=P7mwOoyAONbNxNa2G9ymNsYDUqE=; b=WMzn1e+T/31TFuOFofceSOf
	bB7uXrdM+5mDG4TG6Nhov16wyJmyHBuGDXh4stqAliFm0efa+kzLumnF4pPmOHaW
	GlD+STU/LwrQlU9iLDbtZfHsOdu7g8h4PFWDEXU50Aepbdp5jEcHFUgF93zyQter
	+KGChYpd9Xq69EVBjjm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=LXsOcinkfKtMzd+yER+ptQCnKNxNsnEB75l4nFM/lLPMYFWsM
	5cyWs025+ENukwaUQwA/syN0u1ySVyEe+J5dnBxWClr4HFLB/dXRZ3gQ/qH4ZNj2
	xp4ofsNSuS7q1nL/9O3C1TcRNOD4QHI/d5gfEgf1l2C+cZt+IdLYJH1Ou0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 15766C2B28;
	Mon,  5 Jul 2010 22:36:04 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50953C2B25; Mon,  5 Jul
 2010 22:36:00 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 38F0A30E-88A7-11DF-80F5-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150308>

Thanks; both patches make sense to me.
