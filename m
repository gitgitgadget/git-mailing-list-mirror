From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Confusing git pull error message
Date: Fri, 09 Oct 2009 17:57:04 -0700
Message-ID: <7vbpkgf4m7.fsf@alter.siamese.dyndns.org>
References: <43d8ce650909121301i4450489dhf475ff6894394a5f@mail.gmail.com>
 <20090912211119.GA30966@coredump.intra.peff.net>
 <7v1vmar353.fsf@alter.siamese.dyndns.org> <4AC9D952.3050108@viscovery.net>
 <20091005115308.GA2122@coredump.intra.peff.net>
 <7vljjpacax.fsf@alter.siamese.dyndns.org>
 <20091005191257.GA24305@coredump.intra.peff.net>
 <20091005193516.GB20078@coredump.intra.peff.net>
 <20091009070122.6117@nanako3.lavabit.com>
 <7vy6nl10fg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	John Tapsell <johnflux@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 10 03:02:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwQLd-0005GI-LB
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 03:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934733AbZJJA57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 20:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934731AbZJJA57
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 20:57:59 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61974 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933867AbZJJA56 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 20:57:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A107E71E47;
	Fri,  9 Oct 2009 20:57:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=QF63NJ9VV88aLEFSivhFkd71Pwk=; b=AoZ8WG8899zge0OvDoNs7fj
	OZ+AZfZM9BlludPLa1rB1s4Z/hAq3Er4dUBjU0f72BeJcdGuhQXrm3sY5pgyOrnf
	tM3LCiu4wUftM71bUpbQBbdDwRnivPrJmy6QzEiYai3n0dhigFo6DpIX3AeotKIO
	1csbJcwh5wyW1+c0nxh4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=l8pyMNkwnkXYlQQNkQD0TJclyvuJECby97ly2wisxIVivX8Ef
	9cpwA6enLnrwrYfnJdleVEEAtcWSA0QO7GOVx0Uz2+1QY1QuOLrQywaHbSKo69Fb
	tzPXSWzzmc7fkMXWhzBaSKuAcIsI5nNiJfnz7Y2Fr3d4IgXTsY8e0gO8lk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6094C71E45;
	Fri,  9 Oct 2009 20:57:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8930571E42; Fri,  9 Oct 2009
 20:57:05 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D83E6D04-B537-11DE-B17D-1000076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129860>

Junio C Hamano <gitster@pobox.com> writes:

> Nanako Shiraishi <nanako3@lavabit.com> writes:
>
>> Quoting Jeff King <peff@peff.net>
>>
>>> Subject: [PATCH] pull: improve advice for unconfigured error case
>>> ...
>> Junio, may I ask what happened to this patch?
>
> Thanks for prodding.  Unfortunately I lost track.  Will look at it again
> but probably not tonight.

Applied the patch as-is, as it looked quite good.

Thanks.
