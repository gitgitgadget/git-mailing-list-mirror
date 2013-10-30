From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/7] gitk: support -G option from the command line
Date: Wed, 30 Oct 2013 09:42:24 -0700
Message-ID: <xmqqmwlqd827.fsf@gitster.dls.corp.google.com>
References: <21f40508f83a9407986d29f002adf5ad366c8b88.1382287779.git.trast@inf.ethz.ch>
	<72ba9e0cd862a2fb014d0633802f9afbb0bea27d.1383031141.git.tr@thomasrast.ch>
	<xmqqzjprd1ge.fsf@gitster.dls.corp.google.com>
	<8738nji83k.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Thomas Rast <trast@inf.ethz.ch>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Wed Oct 30 17:42:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbYqo-0002qL-As
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 17:42:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852Ab3J3Qm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 12:42:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53107 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751305Ab3J3Qm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 12:42:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E1A04CBB9;
	Wed, 30 Oct 2013 12:42:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PHJ4wq3+ny07ejW3D2p8lp0wPWY=; b=c2sCbp
	EUjyxsICwAxZMrHI8639w2ElvrVuuMz8uxoTZUCyQapexGX7v1g9yC6KiQwBEZZ3
	6uKJXJDhY2B+OcMmwC9ksh4XA0mwm/n5xS3vzJOGmxmRRURveCvVPj911mTN5mHz
	ikdIvbU/4r5C/x7F2DH+JKxLngf2Iwa+YR660=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JhF3Hy0guAndNuuaMXWUwdnMhysfVvCB
	ZKHVW/yJMT9SZSn8uBC2jRQBbvHAX6OXEwkhcrwumT0c61suQRaakBWsyjU/E5bg
	alkOR4HxqfNBxtNeS3ZZPuVZRV9Qr4rWXVjBrGuxjWvVU46Tp1VL7MsC9mrFo6oe
	6pCPv/nKc/w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0BFD4CBB8;
	Wed, 30 Oct 2013 12:42:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3EA424CBB6;
	Wed, 30 Oct 2013 12:42:27 -0400 (EDT)
In-Reply-To: <8738nji83k.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Wed, 30 Oct 2013 07:30:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 42CB1624-4182-11E3-9C76-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237033>

Thomas Rast <tr@thomasrast.ch> writes:

> I figured this was easier on potential testers.  As outlined in the
> cover letter, I'll do the splitting and rebasing later.

Sorry, I should have read 0/7 before responding, but the message
came out of order.
