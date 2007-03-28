From: Jeff King <peff@peff.net>
Subject: Re: Listing of branch creation time?
Date: Tue, 27 Mar 2007 20:01:49 -0400
Message-ID: <20070328000149.GA12808@coredump.intra.peff.net>
References: <17929.37382.984339.742025@lisa.zopyra.com> <20070327233552.GA7186@coredump.intra.peff.net> <17929.45060.6228.797279@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 02:02:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWLbv-0006uv-3b
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 02:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbXC1ABw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 20:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752810AbXC1ABw
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 20:01:52 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3208 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752784AbXC1ABw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 20:01:52 -0400
Received: (qmail 6638 invoked from network); 28 Mar 2007 00:02:22 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 28 Mar 2007 00:02:22 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Mar 2007 20:01:49 -0400
Content-Disposition: inline
In-Reply-To: <17929.45060.6228.797279@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43329>

On Tue, Mar 27, 2007 at 06:00:04PM -0600, Bill Lear wrote:

> Ok, thank you.  I will try this out and keep this in mind as I test
> out the patch Johannes posted.

This is, btw, completely different than what Johannes posted. His patch
shows you the date of the _tip_ of each of the branches. My script shows
the _oldest_ reflog for the branch. So it depends on whether you want
them in order of "last worked on" or "created" (you said "created", but
I wonder if "last worked on" is actually more useful).

-Peff
