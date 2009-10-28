From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Add '--bisect' revision machinery argument
Date: Wed, 28 Oct 2009 00:18:20 -0700
Message-ID: <7vhbtkt29v.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.01.0910271124110.31845@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 28 08:18:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N32nh-0007yl-8g
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 08:18:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbZJ1HSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 03:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbZJ1HSX
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 03:18:23 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47559 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932268AbZJ1HSW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 03:18:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C787269DDC;
	Wed, 28 Oct 2009 03:18:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=UOrTVjEtPvPBtAopFIfqcH4
	e93ikfS2soTEp07Pzq8d2pJjRpDWymiIT/WWkei13zbfMToK0SXkRcxCxF8182Jl
	Yqi39Aq7UkoKkmWsCjq0fp/oKkPTqcyhgKqsrw/+b++qJv2VSjc5WrcK0xFco9Xs
	HHOMF2LUsKt+CrWjjeIk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=DoO9LIwO0rDsSOQ68vjuQQMLCdL9OCVwwUacbsBATqdKkJ+/V
	rMjNafW5xn1HkFUBaxiltZLolBQgwq2+r04NRIFWHeLhJ5ER8yzTZlPUnYa6pMaZ
	9JXpv4dpEdZvIuBo1cczljQYMZ36iCm7RGNnK5BK/RyrS+SliEpkPk6D+o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A7DB769DDB;
	Wed, 28 Oct 2009 03:18:25 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0910769DD5; Wed, 28 Oct
 2009 03:18:21 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 153C2DDC-C392-11DE-9DF8-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131419>

Thanks.
