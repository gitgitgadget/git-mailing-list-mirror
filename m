From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Mon, 29 Apr 2013 13:02:31 -0700
Message-ID: <7v61z5hzqg.fsf@alter.siamese.dyndns.org>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 22:02:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWuHW-0007pP-OP
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 22:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759672Ab3D2UCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 16:02:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60713 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758227Ab3D2UCd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 16:02:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A8D21A345;
	Mon, 29 Apr 2013 20:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2DddUW/bDK2RqtebjkwYNEAx+3M=; b=BXm/hP
	IlDXrWrIqnbwttGbuBvOw7fd/8RCqr/+J5vaXmIxkgCESrrRCz0i93VhQ77/v6Sq
	Xm/naFX/jirIRGa2JGlsYaoGBwkf4H0MrGl0QQWYNSE31mg7w+ZNkSVcEQqMfsNi
	0ywgw8KESauRDMSi6vBWUFFiMB4zaC7mju24Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S0DS1+n4fZStayXYRfh81F7kid4r499i
	6aIZWVkwrcoLfd0Zw31sgVT3IIvfxuqKT0ssWZ/rnn4a3SStcyiopZm7e2qlyUN3
	/BSGI1/oi2255wkWvt7U/ZN816FwjPWDWj6rAC57JjdsZYd0jUGvphy56rfGAp2r
	bNt/exad/Wo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1D371A344;
	Mon, 29 Apr 2013 20:02:32 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 766561A340;
	Mon, 29 Apr 2013 20:02:32 +0000 (UTC)
In-Reply-To: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Mon, 29 Apr 2013 14:35:06 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BA6A7B40-B107-11E2-804D-8D009ADAE8A5-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222857>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> So HEAD@{0}~0^0 is too much to type, but we can remove '^0', and we can
> remove '~0', and we can remove 'HEAD', but we can't remove '{0}'?

Another technical issue, even if you have reflogs.

HEAD@{0} and @{0} are referring to two different reflogs, and means
different things, even though they may refer to the same commit.

But the comment in my previous message still stands.
