From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 7/7] update-ref: support multiple simultaneous updates
Date: Thu, 29 Aug 2013 11:34:43 -0700
Message-ID: <xmqqioyo4a7w.fsf@gitster.dls.corp.google.com>
References: <cover.1377784597.git.brad.king@kitware.com>
	<8d323b9c2a71a9bafa8b48caf1d85c1035549b16.1377784597.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 20:34:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF73Y-0006WX-5d
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756704Ab3H2Ses (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:34:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37152 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754405Ab3H2Seq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 14:34:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 679023D2C5;
	Thu, 29 Aug 2013 18:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BVAxkajpPD5GoZKJUORj3mCde90=; b=Zra0eC
	6O7fhXvY3cIsJw9DGVNxDgs8+NikmIBaMcZJkBIGAfDeeZph24PlKpv+w00Jl5Yd
	FgZkA2coQlRL4XKyLX+hE1TlAeIO66dIdi6EZGyjXRP3qI/5E/kPgCXK5wZawpis
	KpBocgiaeCSwxmfgfmM+hK5hlU/wyxmYGRXFA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lOct4xjQLN0Vk9a2uJMynJ6xmi2QLYfg
	5dxev61jFCTbdXrv5KTwTkAEXtbe9VLu8j4NlTlPxMLFVGJoaqRGCD7DnetIHTVL
	83XQTHxL1P3aKtzRaYyvDWfBv8RUoycSvfadnlQuxCuxqEPe3mFUdHsR4sesFShj
	xi7sLITrrCg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C20F3D2C4;
	Thu, 29 Aug 2013 18:34:46 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B537A3D2C1;
	Thu, 29 Aug 2013 18:34:45 +0000 (UTC)
In-Reply-To: <8d323b9c2a71a9bafa8b48caf1d85c1035549b16.1377784597.git.brad.king@kitware.com>
	(Brad King's message of "Thu, 29 Aug 2013 10:11:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AD963332-10D9-11E3-BC37-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233326>

Brad King <brad.king@kitware.com> writes:

> +	const char *c, *s, *oldvalue, *value[2] = {0,0};

This patch has many style issues of the same kind, lack of a SP at
places where there should be between operators and after comma.
