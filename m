From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] diff: resurrect the traditional empty "diff --git" behaviour
Date: Mon, 03 Sep 2007 10:09:03 +0200
Message-ID: <vpqveasmaqo.fsf@bauges.imag.fr>
References: <20070830063810.GD16312@mellanox.co.il>
	<7v7inda5ar.fsf@gitster.siamese.dyndns.org>
	<20070830072748.GF16312@mellanox.co.il>
	<7vmyw85uml.fsf@gitster.siamese.dyndns.org>
	<20070831080651.GA17637@mellanox.co.il>
	<7vabs82kcq.fsf@gitster.siamese.dyndns.org>
	<20070831081517.GB17637@mellanox.co.il>
	<7v4pig2j91.fsf@gitster.siamese.dyndns.org>
	<20070831152120.GC17637@mellanox.co.il>
	<7vr6lj1zg3.fsf@gitster.siamese.dyndns.org>
	<20070831160335.GA17761@coredump.intra.peff.net>
	<7vtzqfzcll.fsf_-_@gitster.siamese.dyndns.org>
	<46D89844.8050605@midwinter.com>
	<7vir6vw4x2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org,
	"Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 10:10:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS70u-0007H7-JS
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 10:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438AbXICIKW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 04:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753354AbXICIKV
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 04:10:21 -0400
Received: from imag.imag.fr ([129.88.30.1]:54357 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753280AbXICIKT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 04:10:19 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l83898pa020275
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 3 Sep 2007 10:09:08 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IS6zX-0000Y1-3p; Mon, 03 Sep 2007 10:09:03 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IS6zX-0005od-1V; Mon, 03 Sep 2007 10:09:03 +0200
In-Reply-To: <7vir6vw4x2.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Fri\, 31 Aug 2007 18\:27\:53 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 03 Sep 2007 10:09:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57439>

I fully agree with the two patches (that's what I've been arguing for
hours last time we talked about it, so no big surprise ;-) ).

One documentation nitpick :

Junio C Hamano <gitster@pobox.com> writes:

> +diff.autorefreshindex::
> +	When using `git diff` to compare with work tree
> +	files, do not consider stat-only change as changed.
> +	Instead, silently run `git update-index --refresh`

I'd rather avoid talking about plumbing in the documentation of
porcelain, so I'd say "silently refreshes the index's stat
information".

But I'm arguably wrong on that point, I let you decide.

Thanks,

-- 
Matthieu
