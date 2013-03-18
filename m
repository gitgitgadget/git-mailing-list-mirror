From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/4] pack-refs: add fully-peeled trait
Date: Mon, 18 Mar 2013 09:26:48 -0700
Message-ID: <7vzjy0oerb.fsf@alter.siamese.dyndns.org>
References: <20130317082139.GA29505@sigill.intra.peff.net>
 <20130317082829.GD29550@sigill.intra.peff.net>
 <7vli9lre1j.fsf@alter.siamese.dyndns.org>
 <20130318113732.GA14789@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 18 17:27:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHcuC-0005kX-HF
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 17:27:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402Ab3CRQ0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 12:26:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44958 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752886Ab3CRQ0v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 12:26:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 808A3B8ED;
	Mon, 18 Mar 2013 12:26:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AX7aiKqFDcmAUgffGXEucsrSOH4=; b=duyJod
	Sjf7CRu3Biqc1eXAO9yODAesKRsglvtYxANZxap7C1anKSciRUapDR7cmw0MYmfm
	jWaFSJRdjOaTsOeapxUcy5ee0zOT8rQnSTROEfkqyYPNvekJ99WjjY/dbLkL0oDJ
	lkJpru8Mh4lX5WDWZPj4O48txH7URMrxNmRhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=baDeGVbix4rhiSU9p594QZ7w9qFVutvN
	MeQUN0iRLe2a7v2u9xGQ4BVSKMctJb/UY+iJfRQhXpsfNnGlIxyNrI9S8KVmg1rd
	xMOxVjtQn+kn40UGZQibhnUHkfgrm59KucsT65/8QGUCEfjkJQgeZTuJbLpmpVr4
	QgImwM6p+ug=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 760DAB8EC;
	Mon, 18 Mar 2013 12:26:50 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 081D0B8E9; Mon, 18 Mar 2013
 12:26:49 -0400 (EDT)
In-Reply-To: <20130318113732.GA14789@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 18 Mar 2013 07:37:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A2C2FB74-8FE8-11E2-93C4-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218426>

Jeff King <peff@peff.net> writes:

> Here's the re-roll.

Above reasoning (elided) look sensible.  Thanks; will replace.
