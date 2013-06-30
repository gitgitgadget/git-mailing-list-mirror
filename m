From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] perf-lib: fix start/stop of perf tests
Date: Sat, 29 Jun 2013 18:46:04 -0700
Message-ID: <7vbo6ol6ar.fsf@alter.siamese.dyndns.org>
References: <1372513119-27384-1-git-send-email-t.gummerer@gmail.com>
	<87ppv4hnbt.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gummerer <t.gummerer@gmail.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jun 30 03:46:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ut6iS-0003WS-D9
	for gcvg-git-2@plane.gmane.org; Sun, 30 Jun 2013 03:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156Ab3F3BqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Jun 2013 21:46:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34438 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751815Ab3F3BqG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Jun 2013 21:46:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1394B23F26;
	Sun, 30 Jun 2013 01:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PJoXbwtcPGSDiZ/Yj3fLHyqpcQM=; b=XkCBUk
	XBf91F6gNM6gDaSVUzJmNLzWBGz1q+I2RMHERQkI2UxrQrbmLU1uUuWyn0BQCLdW
	q2r9bIjIPNmMbKwwGrUBxNXYvH5kWO8a+H0oT8S186VVvq06kNGFCxb/WVlp6eWj
	osvZCZoqyh4rOB1brjzwkF31aMm75DjtuiKMg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WV9OW/ZsLfF3gjJkHJgqFPKz1qW55eug
	M63gEo3zAWAVX4x2VJxJ0kpcwZV3RQUt68nB7sD7XqAtmUws769mgZHsbi8PUzWT
	vqIBI9waPAkOaJ+YLwexb1K/0CxbGJKTvjRS6GpPlOPxWiUhrpsUIcVym1GmoQQU
	otwsZziIcp8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0785923F25;
	Sun, 30 Jun 2013 01:46:06 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 84ED523F22;
	Sun, 30 Jun 2013 01:46:05 +0000 (UTC)
In-Reply-To: <87ppv4hnbt.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Sat, 29 Jun 2013 09:51:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D3F3FA56-E126-11E2-B64D-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229260>

Thanks, both.  Will queue.
