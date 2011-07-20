From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/14] docs: end-user documentation for the credential
 subsystem
Date: Wed, 20 Jul 2011 15:17:12 -0700
Message-ID: <7vk4bc4mxj.fsf@alter.siamese.dyndns.org>
References: <20110718074642.GA11678@sigill.intra.peff.net>
 <20110718075247.GK12341@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 21 00:17:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qjf4x-0005ZY-9s
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 00:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200Ab1GTWRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 18:17:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40513 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691Ab1GTWRP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 18:17:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 99C245864;
	Wed, 20 Jul 2011 18:17:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=LilqMOxo699fB398M/ZO215ADHo=; b=u1XSexGB92sgTE7tszZC
	E3MFtVxz/pzMoykPpKRKv2BEgZJqFG6TDDoe+INJns9Oj/5DnAEZPdUYkXQuyU27
	8+YFmJNpRiZXO3Q99cUN8WFLxcJ86eDrMejZXuIraHCBKOCuwkUYfeV1KmbLPvCK
	jyQ1KVFlXMOFWXo6mjLnTyc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Jts963bX+tWy8jXvWKsWn5TwhVCNX5FS9OdKoWPwiYqxeC
	tPJRQyM6XYPxkfm/RqwT4TMmJ6f0OvBH5Tw0Z6QOsq0eVXmLjVzsRPrH1AYL6KBm
	+Mgx25mC1w6m6srwXBDUOTLjnNMbg5+GEmbXEurgqAXs6vz5CUFw9gwXXRKB0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 91F935863;
	Wed, 20 Jul 2011 18:17:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 26B9F5862; Wed, 20 Jul 2011
 18:17:14 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 055FFF4C-B31E-11E0-9EC5-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177555>

I've read up to this one, and felt that you must have had a lot of fun
while working on these ;-)  In general all of them looked good.
