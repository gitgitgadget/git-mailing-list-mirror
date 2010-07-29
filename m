From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase: support -X to pass through strategy options
Date: Thu, 29 Jul 2010 09:10:38 -0700
Message-ID: <7vd3u6uv41.fsf@alter.siamese.dyndns.org>
References: <80763c667fa4685d2b6451838c0f1809e86fe07e.1280354419.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Mike Lundy <mike@fluffypenguin.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jul 29 18:10:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeVh9-0004Ko-Rs
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 18:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758003Ab0G2QKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 12:10:48 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64809 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754591Ab0G2QKq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 12:10:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F828C9766;
	Thu, 29 Jul 2010 12:10:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=p3XCH8blyD2Uj8d1PoW9RWbjGAw=; b=fwXpx9q06JmLwJyZcw32ucL
	rnp6bkT7JcnOnKHAqy4Ql6S3Tt6GcQlknYwYmvRyQ8UYENn/K/ayFCdXgm1BdYzS
	ql5KDHJIB39+YE6OgTS9j1O99x7aNUQt2tNs0NzRKSaOfVRzd/SageKYevmlCmn5
	Z2JhnGNMV8fZmQD8iny0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=EqBsX1JpgXcOEtdH5EUQgobgmXXMzKwtOWJTU1307dULGIifI
	ZDhcmOmExt9mTWSZglpS/WXSO6iNERRf3ISsPbHPDfUoo/LPisEOzlwFezscBnsZ
	dCPr3RQtwYo/qNP/LdO5VUZZAiKTVTBXYQ7rjgCKI89BzIwanFalWBF3hY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E511C9762;
	Thu, 29 Jul 2010 12:10:43 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76B11C9760; Thu, 29 Jul
 2010 12:10:39 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D6A7BED4-9B2B-11DF-AF00-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152184>

Looks good; thanks both.
