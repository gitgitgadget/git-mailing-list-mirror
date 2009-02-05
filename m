From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: "git revert" feature suggestion: revert the last commit to a
 file
Date: Thu, 5 Feb 2009 21:50:03 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902052145470.7491@intel-tinevez-2-302>
References: <20090205202104.GA11267@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Thu Feb 05 21:51:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVBCB-00004u-7I
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 21:51:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbZBEUuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 15:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751675AbZBEUuI
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 15:50:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:60067 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751341AbZBEUuH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 15:50:07 -0500
Received: (qmail invoked by alias); 05 Feb 2009 20:50:04 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp053) with SMTP; 05 Feb 2009 21:50:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18JvWAeC3oJgS4oXbUEvI9TVxsfFrCHGldRRyml+6
	vShGtlUfbN85nH
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090205202104.GA11267@elte.hu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108614>

Hi,

On Thu, 5 Feb 2009, Ingo Molnar wrote:

> But it would be so much nicer if i could do the intuitive:
> 
>    git revert kernel/softlockup.c

For some people I know, this would intuitively mean that the uncommitted 
changes in kernel/softlockup.c should be reverted.

So I am not convinced that this is an intuitive syntax at all.

Instead, I think that something like

	git revert :/!file=kernel/softlockup.c

would be possible, as it

- does not overload an already overloaded term, and

- is useful for something else than revert, too.

Ciao,
Dscho
