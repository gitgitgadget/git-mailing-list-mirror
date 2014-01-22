From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v1.9-rc0
Date: Wed, 22 Jan 2014 07:42:12 -0800
Message-ID: <xmqqk3dsyqej.fsf@gitster.dls.corp.google.com>
References: <xmqq61pjzljn.fsf@gitster.dls.corp.google.com>
	<xmqqha8xt22p.fsf@gitster.dls.corp.google.com>
	<CALZVapmqcFjjKeURHdP4chkB+T2--caJZYiJBzdwq7Ou=HzO5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
To: Javier Domingo Cansino <javierdo1@gmail.com>
X-From: linux-kernel-owner@vger.kernel.org Wed Jan 22 16:42:41 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1W5zwt-0005J4-Cv
	for glk-linux-kernel-3@plane.gmane.org; Wed, 22 Jan 2014 16:42:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756012AbaAVPmW (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 22 Jan 2014 10:42:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59734 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753148AbaAVPmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jan 2014 10:42:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7110662963;
	Wed, 22 Jan 2014 10:42:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=792Y2a/Ps757CfluKzjktusKwXU=; b=vcX8Rn
	iH77r0A9C8XMF7UvN9YBY+olUbuQRoa2XImeek1CRMDsVuSRQ+smE9g9Rh0dRb5L
	Bn4zLOklMAlSUO7ru7PpLuwI63dQuP90uA1F9oQKsTakerOWAUpr3+LSzcYEwsJ2
	DUrNNCArsbzabH1s5Ze5ZymN6IpM3vq8WVw9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p/nLHAFa5HavCXucX21tYqSgzsQYiRCt
	QmNVyNnQsXJtDl+7DppRs2xt0UhiKNwrq2COvFgG4meFukwF/+Hk/tGxPxsnl3oD
	1u4LofecasG8Z4FjE23l8tSqHHVWPRdtJqa81MmDSQj+DWpO3H/ZolkHkqd1tgmK
	sBmRKsVj/yo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F1C462961;
	Wed, 22 Jan 2014 10:42:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D2A662960;
	Wed, 22 Jan 2014 10:42:14 -0500 (EST)
In-Reply-To: <CALZVapmqcFjjKeURHdP4chkB+T2--caJZYiJBzdwq7Ou=HzO5w@mail.gmail.com>
	(Javier Domingo Cansino's message of "Wed, 22 Jan 2014 13:53:26
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C429E156-837B-11E3-B748-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240831>

Javier Domingo Cansino <javierdo1@gmail.com> writes:

> Will there be any change on how tarballs are distributed, taking into
> account that Google will be shutting down Google Code Downloads
> section[1][2]?

Aside from the obvious "we won't be able to use something that is no
longer offered"?  They are not the only download site even now, so...
