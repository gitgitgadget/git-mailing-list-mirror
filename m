From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: resurrect the traditional empty "diff --git" behaviour
Date: Mon, 03 Sep 2007 01:36:32 -0700
Message-ID: <7vbqckm9gv.fsf@gitster.siamese.dyndns.org>
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
	<vpqveasmaqo.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org,
	"Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Sep 03 10:36:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS7QN-0003tc-AS
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 10:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588AbXICIgk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 04:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752537AbXICIgk
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 04:36:40 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:47303 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493AbXICIgj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 04:36:39 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 4F01112D862;
	Mon,  3 Sep 2007 04:36:56 -0400 (EDT)
In-Reply-To: <vpqveasmaqo.fsf@bauges.imag.fr> (Matthieu Moy's message of "Mon,
	03 Sep 2007 10:09:03 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57448>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> I'd rather avoid talking about plumbing in the documentation of
> porcelain, so I'd say "silently refreshes the index's stat
> information".

Sounds like a much better wording.
