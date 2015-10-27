From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] remote-http(s): Support SOCKS proxies
Date: Tue, 27 Oct 2015 10:27:06 -0700
Message-ID: <xmqq8u6odxxx.fsf@gitster.mtv.corp.google.com>
References: <cover.1445865176.git.johannes.schindelin@gmx.de>
	<bf218d020e24216f55d1514c4459e645b13ec075.1445865176.git.johannes.schindelin@gmx.de>
	<xmqq7fm9gze2.fsf@gitster.mtv.corp.google.com>
	<20151027012336.GK31271@freya.jamessan.com>
	<xmqqvb9tdr7v.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.1.00.1510271649430.31610@s15462909.onlinehome-server.info>
	<alpine.DEB.1.00.1510271651420.31610@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	James McCoy <vega.james@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 27 18:27:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr81j-0005ut-LO
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 18:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754495AbbJ0R1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 13:27:10 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53873 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754415AbbJ0R1J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 13:27:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7CF9425ED4;
	Tue, 27 Oct 2015 13:27:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HA+6rowh3W1qYUhARN+roNE+X5M=; b=f4aX5x
	MSoCNWfy+A0Dbqa4NuDpB3EDrwy2+MxhILY6s/9MCDuS3XGiA36AqkTevubiT/kF
	2MDGd1m42KvhjqxIrXZ7nUNGy3o8krOs9/ym+qC1BXrTMm/R30wrBquFyEOIdpIf
	0C0toBRTxgiSjwU+2ksFDhFpnAQBjIE9Dho5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OZnXIWDHZx6LqMtKrdtFUfeYRIWWoUQ3
	/t7M4RsZZYDy311q2cnWDYDYQ/L2oOvhl24J/a5z+j5UP/ubWLXXvLQZXuersnLI
	ekz16iFMCYV4nhPcvkHSwaSzbnzQLg8WA0oWjrIUFkwsHY41Y1eS59IBgWIPk83A
	JdGj7qvpLl0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7366125ED3;
	Tue, 27 Oct 2015 13:27:08 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6AF7025ED2;
	Tue, 27 Oct 2015 13:27:07 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.1510271651420.31610@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Tue, 27 Oct 2015 16:53:34 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F29DE38A-7CCF-11E5-A784-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280270>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On second thought... Junio, could you please sanity-check my claim that
> this patch:
>
> -- snip --
> ...
> -- snap --
>
> cannot be copyrighted because it is pretty much the only way to implement
> said functionality?

I am not a lawyer, so...


> Still, Pat, if you find the time, could you please simply relicense your
> patch (I know that you are fine with it, but we need an explicit
> statement)?
>
> Ciao,
> Johannes
