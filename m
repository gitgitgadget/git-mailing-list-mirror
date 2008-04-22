From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git remote update -> rejected
Date: Tue, 22 Apr 2008 10:00:48 -0700
Message-ID: <7vtzhtygcf.fsf@gitster.siamese.dyndns.org>
References: <1208857733.4695.37.camel@marge.simson.net>
 <20080422103458.GA14751@sigio.intra.peff.net>
 <1208861703.18689.2.camel@marge.simson.net>
 <20080422111113.GB11238@sigill.intra.peff.net>
 <alpine.DEB.1.00.0804221250010.4460@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Mike Galbraith <efault@gmx.de>,
	git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 22 19:01:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoLsG-0000Q2-Jx
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 19:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755718AbYDVRA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 13:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755625AbYDVRA5
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 13:00:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60739 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755430AbYDVRA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 13:00:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BE7FE1010;
	Tue, 22 Apr 2008 13:00:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 1AE73100D; Tue, 22 Apr 2008 13:00:50 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0804221250010.4460@eeepc-johanness> (Johannes
 Schindelin's message of "Tue, 22 Apr 2008 12:58:07 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80139>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Dscho, is this a bug, or was there a conscious decision that I missed?
> ...
> But as I said, my rationale may very well be wrong.

Whatever the rationale was, it is very wrong if the series was about
rewriting the scripted version in another language.  That is an
independent behaviour change.

And I do think the fix should be applied to --mirror case as well.  If it
does not "mirror" as it is told, what use would there be?
