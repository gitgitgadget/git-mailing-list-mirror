From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] filter-branch: fail gracefully when a filter fails
Date: Fri, 6 Jul 2007 05:31:44 -0400
Message-ID: <20070706093138.GA12737@sigill.intra.peff.net>
References: <Pine.LNX.4.64.0707041535420.4071@racer.site> <20070705135824.GB5493@sigill.intra.peff.net> <Pine.LNX.4.64.0707051636240.9789@racer.site> <468DE9F3.B4489CDE@eudaptics.com> <863b02j6qs.fsf@lola.quinscape.zz> <7vir8yextt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 11:32:17 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6kAe-0007fV-Me
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 11:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760944AbXGFJcH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 05:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759840AbXGFJcG
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 05:32:06 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3777 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758821AbXGFJcD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 05:32:03 -0400
Received: (qmail 6803 invoked from network); 6 Jul 2007 09:32:19 -0000
Received: from unknown (HELO sigill.intra.peff.net) (71.63.4.50)
  by peff.net with (DHE-RSA-AES256-SHA encrypted) SMTP
  (cert postmaster@peff.net); 6 Jul 2007 09:32:19 -0000
Received: (qmail 13341 invoked by uid 1000); 6 Jul 2007 09:31:44 -0000
Content-Disposition: inline
In-Reply-To: <7vir8yextt.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51737>

On Fri, Jul 06, 2007 at 01:33:02AM -0700, Junio C Hamano wrote:

> the purpose of updating this script, I would say a temporary
> file is much better than any of the alternatives around 1>&3.

As the one who originally mentioned the redirection trick, let me say
that I agree. I brought it up more as "yuck, this is the way you have
to do it" than a real suggestion. I think the tempfile, while ugly, is
less ugly.

-Peff
