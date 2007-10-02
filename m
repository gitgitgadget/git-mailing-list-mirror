From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 01 Oct 2007 22:01:16 -0700
Message-ID: <7vsl4up0tf.fsf@gitster.siamese.dyndns.org>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org>
	<7v1wd1d0le.fsf@gitster.siamese.dyndns.org>
	<7vfy11yyxk.fsf@gitster.siamese.dyndns.org>
	<20070927023633.GA28902@coredump.intra.peff.net>
	<20071002041652.GA32133@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 02 07:01:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcZsx-0003h8-45
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 07:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbXJBFBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 01:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbXJBFBX
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 01:01:23 -0400
Received: from rune.pobox.com ([208.210.124.79]:38328 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750793AbXJBFBW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 01:01:22 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 20FAD13FC9D;
	Tue,  2 Oct 2007 01:01:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 907EE13FC10;
	Tue,  2 Oct 2007 01:01:40 -0400 (EDT)
In-Reply-To: <20071002041652.GA32133@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 2 Oct 2007 00:16:52 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59656>

Jeff King <peff@peff.net> writes:

> Just to update, I tried using a non-colliding hash for this (at the
> expense of much memory), and I wasn't able to get things much faster
> (and certainly not worth the explosion in memory), short of reducing the
> size of the hash (which is going to reduce the quality of the output).
> So I am giving up for the time being, but if others are interested in
> trying to speed things up, I would be happy to discuss ideas.

Bummer.  You are giving up at the same place I gave up the last
time.  I was somehow hoping that other people are more clever
and determined than I was ;-).

Thanks for trying.
