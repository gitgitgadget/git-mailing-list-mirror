From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/19] new git check-ignore sub-command
Date: Fri, 28 Dec 2012 13:31:11 -0800
Message-ID: <7vlichhnj4.fsf@alter.siamese.dyndns.org>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
 <7v38yqj9ix.fsf@alter.siamese.dyndns.org>
 <CAOkDyE8gfW9TvyP=iE7gVEXOqCpOqMRjpr=Vnyd_pnummy4Qsg@mail.gmail.com>
 <CALWbr2wEVzjJ_Y+W9BmakvXCwdFR3OjVH+15tPaDeXsrwaO86w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Spiers <git@adamspiers.org>, git list <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 28 22:31:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TohWg-0000q3-Dh
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 22:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754285Ab2L1VbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 16:31:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55117 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754080Ab2L1VbN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 16:31:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E97AAD45;
	Fri, 28 Dec 2012 16:31:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GDZUol9DAJnxlINY/vy39Zue9Dc=; b=Bkd/WY
	Yh5dqY/QaU8BwNiAxf6ZbcNpTreoywTCet0U4dPmBw8TqsOiBUq84A7WOkebADPP
	N1SKONQz2g1k2sPbYTx+PBFSsRc+0uqGDyIy/raSaTH1A5uQlTK1xu3cY4jQjKq3
	60/4UAmPLh6xK/zlD8D9E/WsGxI+FjD/cLqx4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bsUWgoEtBVnP1wtntLOdzXzNCkDgnFcA
	ey7bDdVQyL622drlGlhaG5WEeL8N/VypdSALssuOMV5yerDdKRIc2t+Wap9wYCjj
	SNOorN5IqxHv6UD/FQG1xUGf0gW7iTCSZUZOLAYuw+sZsv/5Ln1DwUH3+lxdRSQU
	U3vw5ONDXQ8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BFB9AD3C;
	Fri, 28 Dec 2012 16:31:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC09AAD3A; Fri, 28 Dec 2012
 16:31:12 -0500 (EST)
In-Reply-To: <CALWbr2wEVzjJ_Y+W9BmakvXCwdFR3OjVH+15tPaDeXsrwaO86w@mail.gmail.com> (Antoine
 Pelisse's message of "Fri, 28 Dec 2012 21:15:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E7317E3A-5135-11E2-B1EA-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212268>

Antoine Pelisse <apelisse@gmail.com> writes:

> I think they will interact, but I need to have a deeper look to Adam's series.
> If it does, do you want me to base my work on the top of his branch ?

Not necessarily.  If it becomes absolutely necessary to introduce
patch dependencies, I would rather see an addition of new command
rebased on a fix.

I just wanted to make sure that parties touching the same area of
the codebase (and me who will be merging their efforts) are aware of
what is going on.
