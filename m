From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/CommunityGuidelines
Date: Tue, 11 Jun 2013 13:55:48 -0700
Message-ID: <7va9mw9xkb.fsf@alter.siamese.dyndns.org>
References: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com>
	<51B6AA7F.1060505@alum.mit.edu>
	<7v38sod1kn.fsf@alter.siamese.dyndns.org>
	<20130611203303.GA14907@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	A Large Angry SCM <gitzilla@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 11 22:55:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmVbf-0000RG-WF
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 22:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695Ab3FKUzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 16:55:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33979 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752160Ab3FKUzv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 16:55:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1624B2753A;
	Tue, 11 Jun 2013 20:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4EMm7/ayfGIp5F+swtPLbLSMcZ4=; b=X8WsXX
	2UoLNtaC69ailmO2B0HmdVineCNKPPBnckfg3RSdMJHClpe5CT731amkKZzYkwwg
	MPhv88raE/GlbASKIjG083eg6bbDww/6YLXHjTUkiu7srlMd+hRhvFO7S/2AFIYL
	ERiNEjKjEjwvn/qG4D5i1/1SX+p9MX0fHxhjM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GQ6CBo6GEk9XFbqXk6gJY6T8w6xPiANi
	T6GY84PjE4Qmm2tKTARRjKfpmirYUOY6jDQ61LLYusDln9zvNVBwKkAPBnA3LALs
	cNS8YMv5ChTPskTu83tNw7f1Q2tEED0KzmfJEdPGkE4JNU3ZRTjSiUr1glrzhMG3
	p6FI+2HfIIM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0988B27539;
	Tue, 11 Jun 2013 20:55:50 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 79D0427538;
	Tue, 11 Jun 2013 20:55:49 +0000 (UTC)
In-Reply-To: <20130611203303.GA14907@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 11 Jun 2013 16:33:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4BBF4A92-D2D9-11E2-8A2F-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227514>

Jeff King <peff@peff.net> writes:

> So there are no hard rules, and this is not a democracy[1]. For the most
> part the community runs itself in an open and collective fashion, and
> the dictator's job is easy; but ultimately, he or she is in charge of
> what gets applied and what doesn't. Rules like "break ties in favor of
> reviewers" are just a guideline for the dictator to use in making
> decisions.
>
> I do not think any of that is news to you, but I think the point needs
> to be made, as it applies to any concrete rules.

My original draft had "I am hoping we do not have to come to that"
after "(I heard some communities break ties this way)", but I
removed it by mistake.

And I think you are right. I also am hoping that I am being fair to
dictate ;-)


> -Peff
>
> [1] Note that I think a benevolent dictator is a _terrible_ way to run a
>     real government, but it works in an open source project. I think the
>     difference is that dictatorship is open to abuse of power. In the
>     real world, there is a lot of power to abuse, and it is hard for
>     people to opt out of it. In the open source world, there is not that
>     much power, and if there is a bad dictator everyone can go somewhere
>     else (another project, or even a fork). So while a dictator _can_
>     play favorites, or start deciding which patches to take based on
>     what they had for breakfast, there is a real incentive to remain
>     fair and reasonable.
