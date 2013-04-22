From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Patch-to-mail notes resurrected
Date: Mon, 22 Apr 2013 08:20:04 -0700
Message-ID: <7v1ua2r3rv.fsf@alter.siamese.dyndns.org>
References: <87bo96rivt.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Apr 22 17:20:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUIXO-0000jK-T4
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 17:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753659Ab3DVPUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 11:20:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64420 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753485Ab3DVPUH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 11:20:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A749816885;
	Mon, 22 Apr 2013 15:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=12QbIdIay+wkguXRzYN4gr5aUsQ=; b=Y/K3bW
	EquCQgYlRvRDkL9L0yLeuFxBxtfLfIEJsc6dSR4YD67U5gBwrb2yFl5Y8zlowUAm
	3CJ0HFWzsBbLfH8v+SEtzkijtwBHrI8zLWjZsgawi1N+Vhf+hIFGFbUGngKTRDFR
	p7QfJewTluDyGIA0KFArShZuHD9D9nnf+oCFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QfxMHTL9rf4IyY/mzVgTdT5OXZ53XVSz
	TVPuzOpLxpFrw5sbL4yuF3wjRPlgq7l6Q+zTjbHYaS59z5cnoyRe+bB9A1Uh2ZYr
	Pb/Tnv1GtRV5oUAUJXmByUbBwpL6q4f39po6cYwhqFdYbFnheP1Etyh2UhQ0C1Ak
	7vy+QDBqUkM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F68716884;
	Mon, 22 Apr 2013 15:20:06 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 261D616883;
	Mon, 22 Apr 2013 15:20:06 +0000 (UTC)
In-Reply-To: <87bo96rivt.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Mon, 22 Apr 2013 11:53:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1CB93046-AB60-11E2-937E-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222024>

Thomas Rast <trast@student.ethz.ch> writes:

> As some might remember, I made a script that writes notes (as in
> git-notes) linking patches to emails back in 2009:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/109074
>
> I resurrected this idea the other week, using a faster implementation
> (the N command in fast-import is great!) and generating better links.
> I am regularly pushing the results to
>
>   git://github.com/trast/git.git
>   git://repo.or.cz/git/trast.git
>
> branches
>
>   notes/gmane        a link to the gmane thread view, focused on this patch
>   notes/message-id   the raw message-id
>
> Point your notes.displayRef at one or both to use them.
>
> It still fails to match some commits, so consider this WIP, but I think
> it's quite useful already.

Thanks ;-)
