From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Documentation/remote-helpers: Clarify "curl" family
 of  remote helpers
Date: Sun, 28 Mar 2010 23:53:32 -0700
Message-ID: <7vy6hb8vpv.fsf@alter.siamese.dyndns.org>
References: <f3271551003282104m1c273450pacc5d5c84125fa54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Gabriel Filion <lelutin@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 08:54:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nw8rJ-0005C1-DB
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 08:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131Ab0C2Gx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 02:53:56 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43559 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753856Ab0C2Gxy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 02:53:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B5C5A6BE3;
	Mon, 29 Mar 2010 02:53:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZBxD8/AHOihUOx753a4XRmNXZXE=; b=gwobN4
	BK+NSHkahe8jnNT9bNZjIZZIMvG4qd4bE21CG7pRb1KDb5UDfg0Fp+itPHl8PTi0
	4qyXizNCpCKUag077ToOZv5c3fWZzO9tPU7plmwaHmTECZ6qx/kjdIUuIuaJuRCq
	eSLNtfu0CnLK3YnL3jRT+6a2Qm5pSuvt1s4yQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IElOHALYK3xngZhbtc35LB6CtzQer+gb
	6qUFrQPSK+IMrYnmml+dC/nK0QV/ksqXscbn3Q15vt98Uc7XsuXQO+3HixARE6Aa
	N3hO2F2jfEqWYoI3B0Akrqx1G/EshF2mly9C5nuoLgD6ZAAGJngdYiROnyY1Zwlg
	hwpOM3GCIWo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 078CEA6BDB;
	Mon, 29 Mar 2010 02:53:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3B37A6BD6; Mon, 29 Mar
 2010 02:53:33 -0400 (EDT)
In-Reply-To: <f3271551003282104m1c273450pacc5d5c84125fa54@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Mon\, 29 Mar 2010 09\:34\:58 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D0E2D4DE-3AFF-11DF-9C37-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143445>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Rewrite paragraph about "curl" family of remote helpers to clarify
> different invocations of the same program.

I don't see anything wrong with "curl family".  Individually they may be
http, https, etc. remote helper, but if you need a name to collectively
call them, you would want to say "curl family of helpers"; "curl helpers"
simply doesn't make sense.

If you want to just say "we ship multiple", we could also say "a family of
helpers" as well.  "curl"-ness is an implementation detail.
