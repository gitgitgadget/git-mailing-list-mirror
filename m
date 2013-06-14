From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unpack_entry: do not die when we fail to apply a delta
Date: Fri, 14 Jun 2013 07:53:42 -0700
Message-ID: <7vy5acrbex.fsf@alter.siamese.dyndns.org>
References: <20130613232608.GA9844@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 14 16:53:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnVNt-0003Mv-HP
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 16:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752664Ab3FNOxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 10:53:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39360 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751706Ab3FNOxp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 10:53:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8566527E5F;
	Fri, 14 Jun 2013 14:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1QaURSrpOLZmSw54LlVRbqwpizU=; b=Nox0j3
	7wl2zAsfCDjCPce+KVxqyIansLHqYyaZoE+vhJbPiTQAasSF7wmXv6LSSBQ1uIwc
	7rtWh+Fgm1oPDJ2wlgheNWp1pE0JZomDZNv6xbf8MJBG7vQogI140gjJCgg/S6+C
	pSQ//UfAtfr8fFiBx7oqk1nsqmLHZUxp/rO+0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s7E396tk8musHg+Ri27xhWFXkx6FV0Tx
	8PovGl0Qzj/jYlTWmJkbU2Y+W52K74nOOiq+8oI+iT8LinoS+hLw796ec4m2mWC5
	XBTpgeEpEeaZY2Lt5QMA3ljMnT0gnWqqLLLSf167L2091CD4nOc6AUfht0yHvCw5
	uSpj9ghkGSg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BA5527E5E;
	Fri, 14 Jun 2013 14:53:44 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F36A827E57;
	Fri, 14 Jun 2013 14:53:43 +0000 (UTC)
In-Reply-To: <20130613232608.GA9844@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 13 Jun 2013 19:26:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3593B69C-D502-11E2-BEC8-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227876>

Makes sense.  Thanks, will queue.
