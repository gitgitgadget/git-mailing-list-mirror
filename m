From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git remote update -> rejected
Date: Tue, 22 Apr 2008 09:50:57 -0700
Message-ID: <7vd4ohzvda.fsf@gitster.siamese.dyndns.org>
References: <1208857733.4695.37.camel@marge.simson.net>
 <20080422103458.GA14751@sigio.intra.peff.net>
 <1208861703.18689.2.camel@marge.simson.net>
 <20080422111113.GB11238@sigill.intra.peff.net>
 <20080422124118.GA3098@mithlond.arda.local>
 <alpine.DEB.1.00.0804221354180.4460@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Teemu Likonen <tlikonen@iki.fi>, Jeff King <peff@peff.net>,
	Mike Galbraith <efault@gmx.de>, git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 22 18:53:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoLio-0004RC-UX
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 18:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754296AbYDVQvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 12:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753975AbYDVQvK
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 12:51:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59072 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343AbYDVQvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 12:51:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CC6DB24B4;
	Tue, 22 Apr 2008 12:51:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0290324B2; Tue, 22 Apr 2008 12:51:00 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80135>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> For your benefit, I just assume that you did not yet read my reply to 
> Peff's mail.
>
> With the --mirror mode, you can no longer discern clearly between local 
> and remote branches.  This is basically what we had in the beginning, 
> before the "separate remotes layout".
>
> So your point is not valid, an update will interfer with "local" branches.

I personally do not think _your_ point is valid.  Doesn't --mirror mean
you do not have local branches?

At least that was my understanding of the intention of the --mirror
option.  You give control away to the other end on the ref namespace, so
that you can treat it as a, eh, "mirror".  Perhaps you would want to have
a single such repository behind a firewall or this side of slow link and
use it as a feeder repository to serve many other clones on this side.

I personally do not think --mirror option makes sense with --track, nor
it makes sense in a non-bare repository for that matter.
