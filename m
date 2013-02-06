From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/4] textconv for show and grep
Date: Wed, 06 Feb 2013 08:55:22 -0800
Message-ID: <7vip65mlfp.fsf@alter.siamese.dyndns.org>
References: <20130205201106.GA29248@sigill.intra.peff.net>
 <cover.1360162813.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Feb 06 17:55:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U38Hj-0002Y0-Q2
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 17:55:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296Ab3BFQzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 11:55:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60395 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751216Ab3BFQzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 11:55:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB0FBC219;
	Wed,  6 Feb 2013 11:55:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O6QM+gwXbiJ25BUhGCXJ7u3bmag=; b=T43spT
	HWK6HZkiZjGYVc1iUuptrSKFFtFKgQWPukMr7JxjPP+2pMk20EEn6aqkmeVy/E3V
	bauMPoRWTxZVJ85XWs60BFO0jc47s0B+kgFNRTivLh7dtVh/qNTE7j0G+bRZXa6u
	BBvOMkVQli7oL0kqTWhKnJCtgfYZr4YH8oXKk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qW0A6p+DtSPL7abtJezOzN8eCUsArYNB
	GWWi8jb+A2hAGqIq4Hhtga5eIZlXyFoSSS7dqy5jBqe9oK/wEPiLx79gY4GgxTrh
	DssfOK6/iFxjDnUi7iYeYmIa9zxf44W4hYL7u4C8egg9H+vr06MthWYav9aAEwJC
	F4YYRz/W48k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FC90C218;
	Wed,  6 Feb 2013 11:55:24 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 22CADC213; Wed,  6 Feb 2013
 11:55:24 -0500 (EST)
In-Reply-To: <cover.1360162813.git.git@drmicha.warpmail.net> (Michael J.
 Gruber's message of "Wed, 6 Feb 2013 16:08:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FFED352E-707D-11E2-881A-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215600>

The parts for "grep" in the series makes tons of sense to me.  I am
not yet convinced about the other two, though.

Thanks.
