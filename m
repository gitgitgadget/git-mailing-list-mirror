From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] remote-curl: let users turn off smart http
Date: Thu, 20 Sep 2012 14:15:20 -0700
Message-ID: <7vd31g9z13.fsf@alter.siamese.dyndns.org>
References: <20120920165938.GB18655@sigill.intra.peff.net>
 <20120920170517.GB18981@sigill.intra.peff.net>
 <7va9wkbmyc.fsf@alter.siamese.dyndns.org>
 <20120920181231.GA19204@sigill.intra.peff.net>
 <7vzk4ka6dp.fsf@alter.siamese.dyndns.org>
 <20120920205107.GB22284@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 20 23:15:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEo63-0000cB-EZ
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 23:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755877Ab2ITVP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 17:15:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39133 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755847Ab2ITVPW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 17:15:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 263638658;
	Thu, 20 Sep 2012 17:15:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I2rPRKXFMCT6HLaaD3WmrcihSMY=; b=ScWZve
	o3c/7aMRFGNrN0QxVOeS/kU2DN4QpWA/O9PwBJDSkyXldtYSiY86P9swQzEwVYnk
	BNsr4nOc1Y8/2KkwfCnPglFVV5W9dCyNgTR3CBuF8A7jvy4u5xvtM6oeiMBPd80Y
	/QGkel9jtQUqSctN5hXcU2sIvG0tDOLFn7Cbs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dFLm3VEpUQ1RqWEzY/ZjPs+XcwWcIKc4
	3ae7JIDzd8IMt5Qh0x7Fr96Jyk7wcWuyJd2AV+l/mwnODmxlwVvMRv2MjYCFu4zd
	y+4Se+isA2cXyV+p0axWuqNgqyZa2G2JwUYjzmHWTLoTV0M2lfe8I21eSJSXNZ0y
	oXPh+Cm7jBI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13F578657;
	Thu, 20 Sep 2012 17:15:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 86AA08656; Thu, 20 Sep 2012
 17:15:21 -0400 (EDT)
In-Reply-To: <20120920205107.GB22284@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 20 Sep 2012 16:51:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4949F85C-0368-11E2-A149-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206093>

Jeff King <peff@peff.net> writes:

> I'm half-tempted to just drop the config entirely, leave
> GIT_SMART_HTTP=false as an escape hatch, and see if anybody even cares.

Sounds like a very attractive minimalistic way to go forward.  We
can always add per-remote configuration when we find it necessary,
but once we add support, we cannot easily yank it out.
