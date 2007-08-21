From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-stash segfaults ...
Date: Mon, 20 Aug 2007 23:54:24 -0700
Message-ID: <7v6439pecf.fsf@gitster.siamese.dyndns.org>
References: <20070820174427.GC7206@artemis.corp>
	<20070820200255.GD5544@steel.home>
	<20070821060510.GA7323@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 21 08:55:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INNdp-0005P3-3g
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 08:55:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761271AbXHUGyb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 02:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760889AbXHUGya
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 02:54:30 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:45969 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760416AbXHUGy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 02:54:29 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 2764C124BE3;
	Tue, 21 Aug 2007 02:54:48 -0400 (EDT)
In-Reply-To: <20070821060510.GA7323@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 21 Aug 2007 02:05:10 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56282>

Jeff King <peff@peff.net> writes:

> I posted the exact same patch almost a month ago, but apparently nobody
> was interested in applying it:
>
>   http://mid.gmane.org/20070726050726.GC32617@coredump.intra.peff.net

I think you were told that your patch was a band-aid for the
symptom, and was not the real fix, in the thread you quoted.

The real fix would be to make merge-recursive operable from
subdirectory (perhaps just the matter of cd-up, but I am not
supposed to be looking at anything other than regression and
documentation fixes this late in the 1.5.3 cycle).
