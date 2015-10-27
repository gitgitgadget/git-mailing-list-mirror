From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] remote-http(s): Support SOCKS proxies
Date: Tue, 27 Oct 2015 12:38:39 -0700
Message-ID: <xmqqbnbkp0e8.fsf@gitster.mtv.corp.google.com>
References: <cover.1445865176.git.johannes.schindelin@gmx.de>
	<bf218d020e24216f55d1514c4459e645b13ec075.1445865176.git.johannes.schindelin@gmx.de>
	<xmqq7fm9gze2.fsf@gitster.mtv.corp.google.com>
	<20151027012336.GK31271@freya.jamessan.com>
	<xmqqvb9tdr7v.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.1.00.1510271649430.31610@s15462909.onlinehome-server.info>
	<alpine.DEB.1.00.1510271651420.31610@s15462909.onlinehome-server.info>
	<xmqq8u6odxxx.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	James McCoy <vega.james@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 27 20:38:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrA50-0000CZ-Sw
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 20:38:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754512AbbJ0Tim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 15:38:42 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58233 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754382AbbJ0Til (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 15:38:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0E50126A5C;
	Tue, 27 Oct 2015 15:38:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a+89Dpy3/SA5BKx+HKl7t6FjAnk=; b=f2qVf5
	ekZDV9FfgIdYk8yDjgoiMEy50HKCTWU+5RjqkdvMVdbQi0O5OqQrrit2pNOWuhYk
	HAggi2DDTGBHhBZG570MbOyP105d3wyCOa236K+SiSUdAtq82RHSQ/h/MDlpKbOz
	Eciyq9iTdM65P5/s5gg8UIjIBc/htKjm80XsE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cHO0Ktr/xm1klATaYMtvF8BBffdh9813
	g7SOsPD7gzQfaen6n9Yr6heNzXWXtakeeTkITLqv+bFo05GrfCqxSEUjeszg2CmD
	Qi+JVV4EGB3qqstQuhhdo+5EMTbyy9TmaOt0i1639usK7EidYdt26POjgfcQYlis
	w23tTCpzK+w=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 02BEE26A5B;
	Tue, 27 Oct 2015 15:38:41 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8120326A58;
	Tue, 27 Oct 2015 15:38:40 -0400 (EDT)
In-Reply-To: <xmqq8u6odxxx.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 27 Oct 2015 10:27:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5339BEAA-7CE2-11E5-8642-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280292>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> On second thought... Junio, could you please sanity-check my claim that
>> this patch:
>>
>> -- snip --
>> ...
>> -- snap --
>>
>> cannot be copyrighted because it is pretty much the only way to implement
>> said functionality?
>
> I am not a lawyer, so...
>
>
>> Still, Pat, if you find the time, could you please simply relicense your
>> patch (I know that you are fine with it, but we need an explicit
>> statement)?

So, I talked to our lawyer.

We are very lucky that the original was posted to SO by our friend
Pat, and you did the right thing to ask Pat to relicense.

Analyzing copyrightability is often more costly than the risk.  Even
if you believe it is not copyrightable, you are bearing the risk
that the court may disagree with you.  Finding a different way to
express the same idea, especially for a small patch like this, is
often cheaper than the cost of copyrightability analysis and the
risk of lawsuit.

If the original is from a friendly party, relicensing is clearly
cheaper and cleaner of the possible choices.
