From: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: project wide: git config entry for [diff] renames=true
Date: Thu, 25 Sep 2014 11:53:38 -0700
Message-ID: <xmqqy4t7a5vx.fsf@gitster.dls.corp.google.com>
References: <Pine.LNX.4.44L0.1409241106100.1580-100000@iolanthe.rowland.org>
	<1411591401-5874-1-git-send-email-sojka@merica.cz>
	<1411591401-5874-4-git-send-email-sojka@merica.cz>
	<20140925150353.GA15325@kroah.com>
	<1411660111.4026.24.camel@joe-AO725> <20140925180005.GA11755@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>,
	Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Michal Sojka <sojka-Knnw/vAvyUalVyrhU4qvOw@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>,
	Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>,
	Linux LED Subsystem <linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, michal.vokac-veUE7cmDK2A@public.gmane.org,
	git <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>
X-From: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org Thu Sep 25 20:53:58 2014
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Envelope-to: glug-linux-usb-wOFGN7rlS/M9smdsby/KFg@public.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>)
	id 1XXEAv-00036k-3Z
	for glug-linux-usb-wOFGN7rlS/M9smdsby/KFg@public.gmane.org; Thu, 25 Sep 2014 20:53:57 +0200
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org via listexpand
	id S1752437AbaIYSxn (ORCPT <rfc822;glug-linux-usb@m.gmane.org>);
	Thu, 25 Sep 2014 14:53:43 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56414 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752386AbaIYSxl (ORCPT <rfc822;linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>);
	Thu, 25 Sep 2014 14:53:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8B77F3C27F;
	Thu, 25 Sep 2014 14:53:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LPklC9aeG43qR+Iq8TUwQzew4O0=; b=Jyo11N
	c2ck9/BkCn8w4AK8VEz1PqlHf8VPKQp/Oj80f+yrj12SyHOyiZvD+eMk6CDPIIQ4
	IK5o/2OhJnazoTbsh/Qev4iGBvgxmz61SecAgJyZ0FORa3MczpU7hI81jcTgNbHv
	HKA72nB/w8C4uYG4s8EoR3AB/2YgEf+BHrUuc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AriPtrgvl9YeNDkGJ2RJPUbt+zR3Hn0u
	B/OaAuhU3OsFMYckgmF35c+o6CpBDXjsGtNbyJRo8Bh9tiTn2Kf/UCv3BQbcXW+D
	EhKrTZPpclKfDIVlli9HB8sBkgNvDEauPD/PSi2IMReLNEbOxUaa92hzCc3qY3/h
	zZ354GARLRw=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8077C3C27E;
	Thu, 25 Sep 2014 14:53:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EA7033C27D;
	Thu, 25 Sep 2014 14:53:39 -0400 (EDT)
In-Reply-To: <20140925180005.GA11755-AdEPDUrAXsQ@public.gmane.org> (Jeff King's message of "Thu,
	25 Sep 2014 14:00:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 439BD69E-44E5-11E4-8663-D931C4D60FE0-77302942!pb-smtp0.pobox.com
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Precedence: bulk
List-ID: <linux-usb.vger.kernel.org>
X-Mailing-List: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257492>

Jeff King <peff-AdEPDUrAXsQ@public.gmane.org> writes:

> There is no such mechanism within git. We've resisted adding one because
> of the danger of something like:
>
>   [diff]
>     external = rm -rf /
>
> diff.renames is probably safe, but any config-sharing mechanism would
> have to deal with either whitelisting, or providing some mechanism for
> the puller to review changes before blindly following them.

It might be useful to add a "safe include" feature, perhaps?  We
ship a small set of hardcoded default whitelist (diff.renames may be
included in there), and allow the user who do not want to be
affected to override it with

    [include]
        safe = !diff.renames

or even

    [config]
    	safe = !*

at the same time allow them to add what we do not hardcode to it
using the same mechanism, e.g.

    [config]
    	safe = merge.*

Then

    [include]
	safe
    	path = ../project.gitconfig

    [include]
    	path = $HOME/.gitconfig-variant1

would only allow the variables include.safe deems safe to affect
us from the in-tree file, and use everything from my personal set in
my home directory.



    	
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
