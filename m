From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add test case for ls-files --with-head
Date: Wed, 03 Oct 2007 14:47:01 -0700
Message-ID: <7vodffdg6i.fsf@gitster.siamese.dyndns.org>
References: <1191390255.16292.2.camel@koto.keithp.com>
	<7vtzp8g2s2.fsf@gitster.siamese.dyndns.org>
	<87y7ekr86e.wl%cworth@cworth.org> <47038669.30302@viscovery.net>
	<Pine.LNX.4.64.0710031634300.28395@racer.site>
	<87myv0qj2u.wl%cworth@cworth.org> <85ejgcrx6r.fsf@lola.goethe.zz>
	<20071003202157.GA28043@coredump.intra.peff.net>
	<Pine.LNX.4.64.0710032238080.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Carl Worth <cworth@cworth.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Keith Packard <keithp@keithp.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 03 23:48:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdC4O-0008Gz-CG
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 23:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754904AbXJCVrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 17:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755318AbXJCVrM
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 17:47:12 -0400
Received: from rune.pobox.com ([208.210.124.79]:55035 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753584AbXJCVrK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 17:47:10 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id A8B1D141327;
	Wed,  3 Oct 2007 17:47:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id B9AC614130B;
	Wed,  3 Oct 2007 17:47:24 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0710032238080.28395@racer.site> (Johannes
	Schindelin's message of "Wed, 3 Oct 2007 22:39:48 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59897>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> $ for i in {1,2,3,4,5}{0,1,2,3,4,5,6,7,8,9}; do echo $i; done
>> {1,2,3,4,5}{0,1,2,3,4,5,6,7,8,9}
>> $
>
> AFAIK this is the same as bash (I thought I was the last one to make that 
> mistake 10 years ago).  As long as you do not have _files_ matching the 
> pattern, it does not expand.  And besides, this is too complicated anyway: 
> [1-5] is much shorter than {1,2,3,4,5}.

AFAIK, you are wrong ;-)

{1,2,3,4,5} expands regardless of what's on the filesystem but I
do not think it is POSIX.

[1-5] matches if any of the {1,2,3,4,5} is found on the
filesystem.
