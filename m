From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] read-cache.c: fix timestamp comparison
Date: Mon, 21 Jan 2008 14:02:16 -0800
Message-ID: <7v63xmyh07.fsf@gitster.siamese.dyndns.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	<alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de>
	<7vir1xmazm.fsf@gitster.siamese.dyndns.org>
	<7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org>
	<7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org>
	<7vr6gb3nv1.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801202114580.2957@woody.linux-foundation.org>
	<7vd4rv3ds5.fsf@gitster.siamese.dyndns.org>
	<7vtzl71x1c.fsf@gitster.siamese.dyndns.org>
	<7vprvv1wnu.fsf@gitster.siamese.dyndns.org>
	<7vlk6j1wjj.fsf@gitster.siamese.dyndns.org>
	<7vhch71vvb.fsf@gitster.siamese.dyndns.org>
	<7v8x2j1sul.fsf@gitster.siamese.dyndns.org>
	<7vzluzzhud.fsf_-_@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801211022350.2957@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801211104590.2957@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801211120350.2957@woody.linux-foundation.org>
	<7vabmyykvg.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801211242330.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 23:02:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH4jE-0006HS-Ao
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 23:02:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbYAUWCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 17:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753311AbYAUWCW
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 17:02:22 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33225 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbYAUWCW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 17:02:22 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 96E4C4D46;
	Mon, 21 Jan 2008 17:02:20 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E2F94D45;
	Mon, 21 Jan 2008 17:02:17 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801211242330.2957@woody.linux-foundation.org>
	(Linus Torvalds's message of "Mon, 21 Jan 2008 13:22:15 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71356>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> It's in the same place: branch 'new-lstat' at
>
> 	git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git new-lstat
>
> and I'll continue to maintain it if only because it's what I use myself 
> (until I just switch to 'next' or something).

I'll find time to replace lt/in-core-index branch that is
currently in 'pu' with it, hopefully sometime tonight.  Mine has
these two idiotic stuff you commented on.
