From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] Documentation: fix linkgit references
Date: Wed, 04 May 2016 16:28:31 -0700
Message-ID: <xmqqfutxcsio.fsf@gitster.mtv.corp.google.com>
References: <xmqqd1p1ivfw.fsf@gitster.mtv.corp.google.com>
	<xmqqvb2thczf.fsf@gitster.mtv.corp.google.com>
	<20160504192516.GD21259@sigill.intra.peff.net>
	<xmqq7ff9h9zo.fsf@gitster.mtv.corp.google.com>
	<20160504200635.GA22787@sigill.intra.peff.net>
	<xmqq8tzpfrt0.fsf@gitster.mtv.corp.google.com>
	<20160504213149.GA22828@sigill.intra.peff.net>
	<xmqq4madfqxs.fsf@gitster.mtv.corp.google.com>
	<20160504214412.GA25237@sigill.intra.peff.net>
	<xmqqk2j9ebj8.fsf@gitster.mtv.corp.google.com>
	<20160504220935.GA26339@sigill.intra.peff.net>
	<xmqq60uteacx.fsf@gitster.mtv.corp.google.com>
	<xmqq1t5he9we.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	sbeller@google.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 05 01:28:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay6Df-0000q3-4z
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 01:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754558AbcEDX2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 19:28:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59851 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753952AbcEDX2f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 19:28:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C5C11181AF;
	Wed,  4 May 2016 19:28:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sa84mka+rf6knPUQQDu+ockRS5c=; b=LKW9Ft
	sDX3hlStztkMz8LrN3hwUz4H00y+pqnFS1+NULc4T/IghvxMqGeS6FjDOGyH8UEF
	ZS5UzEJW45ZoMj9Kp/mRPQGlTIflFdt9Umyq70WnXzWbfTGMK26reVrp7gOoYJ8Q
	Iz/7FGsqUwgQjXjja5LDEZo/XDAv4YSLQcYTI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l/0LfoSwKeHl6pjV+J5I9nY4S1XwMh38
	UdVzPy1cLFFsB1uo2bbRGANoajm67EDe6Oc08ngO86GRuVmfIXOviiyAGUl+Ko5o
	+wTEnUqqOV3jZrTkYfmCggESArWQSFZNCl7chL+Mlq8sgp9mSW4ax+oDt3ug0QtN
	7ihheGXS/So=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BC2E9181AE;
	Wed,  4 May 2016 19:28:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 38202181AD;
	Wed,  4 May 2016 19:28:33 -0400 (EDT)
In-Reply-To: <xmqq1t5he9we.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 04 May 2016 15:27:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EAD7C790-124F-11E6-8392-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293625>

Junio C Hamano <gitster@pobox.com> writes:

> Gaah, the Makefile part of the final patch is wrong; we do not check
> the included sources at all if we only passed the top-level targets'
> sources.

I ended up queuing an enhanced version of File::Find based one on
'pu', but I won't be posting it here today.
