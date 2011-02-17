From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] Introduce CHERRY_PICK_HEAD
Date: Thu, 17 Feb 2011 13:56:00 -0800
Message-ID: <7v39nm9vgv.fsf@alter.siamese.dyndns.org>
References: <1297916325-89688-1-git-send-email-jaysoffian@gmail.com>
 <1297916325-89688-2-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 22:56:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqBpn-0007Bc-KX
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 22:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756749Ab1BQV4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 16:56:14 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35500 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634Ab1BQV4N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 16:56:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5D6FF415B;
	Thu, 17 Feb 2011 16:57:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j6JgQ718duRxq8l8AZtZMYeYfqs=; b=twbAng
	5w9ar1p0DcXCmhvrmOuHGeJPBNljwFoe2x24015tbG1qzv1aMMxcHE2WU49W0W+b
	2+8xTop25UO2lYJBbUDDwCb883u7mK8s+TWNv2Sx0cZrMUuBWnnwCM2YaIlIk2jV
	6kHQFd7feDEaHaL9ZLiuscgAE1WVNzi9qLDHI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QMbzmg/3j1DQ+NnbBYVygehDSfdOWyK4
	v67t16BP7Ux6UZqTyCOaR1MwcaLA/sOQTJ+8+MspMSKe8Zs/wj2BLFf8EjqYM8FO
	mWuZ3KxRooMx+zx9IsuIScW0quq5TNy4Kj0ng4+oOo+S3VbW0UuZDjutT/gVYpLd
	ooYb9WV88eg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 05153415A;
	Thu, 17 Feb 2011 16:57:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CE6764159; Thu, 17 Feb 2011
 16:57:08 -0500 (EST)
In-Reply-To: <1297916325-89688-2-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Wed\, 16 Feb 2011 23\:18\:42 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E165624A-3AE0-11E0-8D71-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167127>

This series in 'pu' seems to break t3404#16.
