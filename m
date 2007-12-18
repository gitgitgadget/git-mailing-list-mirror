From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] provide advance warning of some future pack default changes
Date: Tue, 18 Dec 2007 12:24:27 -0800
Message-ID: <7v4pefzr7o.fsf@gitster.siamese.dyndns.org>
References: <20071215004230.GF7300@mail.oracle.com>
	<alpine.LFD.0.999999.0712142114400.8467@xanadu.home>
	<20071217200920.GB19816@mail.oracle.com>
	<alpine.LFD.0.999999.0712171517320.8467@xanadu.home>
	<7v3au16myj.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999999.0712171641460.8467@xanadu.home>
	<7vbq8o4yxc.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999999.0712172212110.8467@xanadu.home>
	<46a038f90712171952i4f53876fv55b0e6993d5f4b0a@mail.gmail.com>
	<7vlk7s38aq.fsf@gitster.siamese.dyndns.org>
	<20071218111136.GA6266@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Nicolas Pitre <nico@cam.org>,
	Joel Becker <Joel.Becker@oracle.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 18 21:25:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4j0H-0002CD-Un
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 21:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251AbXLRUY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 15:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbXLRUY4
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 15:24:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57302 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbXLRUYz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 15:24:55 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CA7B9616F;
	Tue, 18 Dec 2007 15:24:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B9B5616E;
	Tue, 18 Dec 2007 15:24:40 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68805>

Jeff King <peff@peff.net> writes:

> I can think of two other user-visible changes which have been discussed
> that might warrant such a version bump:
>
>   - option parsing tweaks (hopefully these should be minor, but it is
>     clear that we cannot be 100% consistent while retaining the
>     identical previous behavior)

This could have a fallout, like *-default disambiguation which scripts
did not have to implement.

>   - moving dashed forms out of paths

This is already planned for 1.5.5 and it is not among "other
user-visible changes".  Technically the use of git-foo form without
preparing the environment has not been supported for quite some time,
but people have come to rely on it and I'd agree this warrants a 1.6.0.
