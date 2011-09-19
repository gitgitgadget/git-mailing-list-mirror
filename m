From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t4014: remove Message-Id/timestamp before comparing
 patches
Date: Mon, 19 Sep 2011 13:15:26 -0700
Message-ID: <7vr53c9tlt.fsf@alter.siamese.dyndns.org>
References: <6b2cb6ebec907342a02d56a36ddc58715efabc00.1316414731.git.trast@student.ethz.ch> <20110919191545.GD26115@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Pang Yan Han <pangyanhan@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 19 22:15:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5kFd-0000hm-Mn
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 22:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755513Ab1ISUPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 16:15:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39119 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754792Ab1ISUPc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 16:15:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65567527A;
	Mon, 19 Sep 2011 16:15:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jp2cxJ3Ehk+QqpU7h09AomAS47E=; b=V+jjR0
	6IrtBMNSIcCopPrY3z9qObc5pjklYO9URb5BqxAKpsPryhECavO4V9usbBJ5vyXy
	oPVHQYUJgjTHJRXvn6vqNTmJDpbXe2CjMySzIjXCxVVNqTwBee4Qg0wl3h5X5H7I
	lLR88/ZcN540tMUERLOjbiPF+QcsfQI4Zr3Ss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xDExSdJyjnPeNluGs6q4AyXBBylpgT70
	WmGLk7EzGWJxpkr+3zPOHMyn44lfYZRCrghVeZdTp1w456WRydc5xJ230KsLCzkc
	m7r7PY5I1KeEfygf0uLVTSRh8DVucMTAK0lBbAVDFiMy/bAItup9iOZ2h62J5LyT
	dOh5B3FC7Vs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BE8C5279;
	Mon, 19 Sep 2011 16:15:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E70C25277; Mon, 19 Sep 2011
 16:15:30 -0400 (EDT)
In-Reply-To: <20110919191545.GD26115@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 19 Sep 2011 15:15:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1F853C76-E2FC-11E0-9008-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181700>

Thanks, your fix makes a lot more sense.
