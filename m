From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v2.8.2
Date: Mon, 02 May 2016 11:19:57 -0700
Message-ID: <xmqqpot4tj8y.fsf@gitster.mtv.corp.google.com>
References: <xmqq7ffgvzpn.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1604301749590.9313@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, git-for-windows@googlegroups.com,
	Linux Kernel <linux-kernel@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: linux-kernel-owner@vger.kernel.org Mon May 02 20:20:29 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1axISI-0001iV-Kx
	for glk-linux-kernel-3@plane.gmane.org; Mon, 02 May 2016 20:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754924AbcEBSUL (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 2 May 2016 14:20:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53532 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754806AbcEBSUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2016 14:20:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 58FE116944;
	Mon,  2 May 2016 14:19:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oVZkQ7BSxmuzJzpQD/yepYtsGRE=; b=SUusw3
	oUwPPeESefNLSDW1rDn7GyYvU0vHw4BK3ukz6E3ZmCceQf/XsXMAofAuocdDO813
	Xsu7dS4kKE/JYZQstwyF/CniN2wTB4hnNpDi6eGFbY+qrkAfnEBYdbieOQPn8vt+
	TA4atOq+eQNwESQwsSlgCCwjt15NCKR+8P110=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SHziwpJ6Ds69YJTZQ0sISk3kQFZOMKx3
	uwiF25YiVenNOUsiBEoRUpDKN/EofaXOd3JBZec+8yrPAeoEXke8y4SYchcVvKA+
	u80j+uMp1JeEVdyD7Ty9AZeoQd7OJGRDapqbHQlX+4CtJlfUgIBddEC2MNw26Qsb
	E31tD5ZFkuY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 51B3016943;
	Mon,  2 May 2016 14:19:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BEA3416942;
	Mon,  2 May 2016 14:19:58 -0400 (EDT)
Importance: high
In-Reply-To: <alpine.DEB.2.20.1604301749590.9313@virtualbox> (Johannes
	Schindelin's message of "Sat, 30 Apr 2016 18:01:40 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7A811122-1092-11E6-A87B-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293262>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> ... However, I
> decided to delay the release for a couple of days, for a couple of
> reasons:
>
> - I expect an update of the Git Credential Manager in the next few days.
>
> - OpenSSL is slated to receive critical updates on Tuesday and I plan to
>   incorporate these into Git for Windows' next version, too.
>
> I will also use version 2.8.2 as an excuse to ship with support for the
> extra HTTP headers configured via `http.extraheader`, which I hoped to
> get into Git v2.8.2, too, because I'd like the feature to be available on
> Linux and MacOSX, too.

I am not sure if a new feature should go to the maintenance tracks.

> In short: the tentative release date of Git for Windows v2.8.2 is
> Tuesday, May 3rd, 2016.

Thanks.  I do not think there is anything ultra-urgent in 2.8.2
relative to 2.8.1, and synchronizing your release with the need on
the Windows platform side sound very sensible.
