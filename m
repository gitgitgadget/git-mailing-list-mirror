From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sparse: suppress an "using sizeof on a function" warning
Date: Fri, 07 Nov 2014 12:08:45 -0800
Message-ID: <xmqq4muag4du.fsf@gitster.dls.corp.google.com>
References: <545CCE23.5080507@ramsay1.demon.co.uk>
	<20141107210150.Horde.XRUyBUv4Cn9UXSUur_a0avA@webmail.domainplanet.at>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: ockham@raz.or.at
X-From: git-owner@vger.kernel.org Fri Nov 07 21:08:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xmpq0-0008Je-R6
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 21:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254AbaKGUIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 15:08:49 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62304 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753145AbaKGUIs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 15:08:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 94AFC1B296;
	Fri,  7 Nov 2014 15:08:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m8loDfxDaosst14wDpNfsxWlDjo=; b=QkPxb1
	qrs2ZDn3XCMoHJE+Mhpmq3LqmtX83YMOz+uWaH7MoOYz/uIoAqBpwt1HVrp62a6l
	pfaghjnbjnGEagfWAfxz66CllcIrSv8LcpcoKYIrgmT3bugdZd3SYLTVRYRKiDhu
	9VmDEAji9cJQG/Wgd+9LULobC6BYZ/HsUa9JI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JPJcY1fR5uyFHl2Bt55bGn76KROcOaaD
	XdtnIo5F4cMcDD5pwR563rlm485n9mZ51GVzKKp0fnT8CP+AkrnXVmtNziAorLbb
	0FSY+pMCtxzKgEZu9hBfFJI+0IRlCa4KtIPXOEWnUxgh/NrK9hoc8DQekrkxI+l/
	jP/Ftg89KZA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B24E1B295;
	Fri,  7 Nov 2014 15:08:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0FA531B293;
	Fri,  7 Nov 2014 15:08:46 -0500 (EST)
In-Reply-To: <20141107210150.Horde.XRUyBUv4Cn9UXSUur_a0avA@webmail.domainplanet.at>
	(ockham@raz.or.at's message of "Fri, 07 Nov 2014 21:01:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E1C62874-66B9-11E4-906A-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ockham@raz.or.at writes:

> Hi Ramsay,
>
> and thanks for your fix! TBH, I didn't even notice that my patch had
> already been committed and instead posted a refined version earlier
> today [1] (which unfortunately didn't contain your fix, either).
>
> Not sure how to proceed. Maybe Junio can enlighten?

There is no "already committed" ;-)

Your patch is merely queued on 'pu' (proposed updates), which we all
expect to be rerolled.  You can just reroll another round, but you
might want to wait a bit to see if there are more issues spotted by
other people before doing so.
