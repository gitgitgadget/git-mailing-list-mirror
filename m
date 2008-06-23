From: Jeff King <peff@peff.net>
Subject: Re: linux-x86-tip: pilot error?
Date: Mon, 23 Jun 2008 11:12:58 -0400
Message-ID: <20080623151257.GC20902@sigill.intra.peff.net>
References: <20080622123620.GA9328@linux.vnet.ibm.com> <237967ef0806220548t3fd73211v354071efe2db22e4@mail.gmail.com> <20080622132105.GD22569@linux.vnet.ibm.com> <20080623071441.GA28887@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Mikael Magnusson <mikachu@gmail.com>, git@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Mon Jun 23 17:14:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAnkX-00010h-7W
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 17:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755074AbYFWPNB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 11:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756564AbYFWPNA
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 11:13:00 -0400
Received: from peff.net ([208.65.91.99]:2942 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755074AbYFWPNA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 11:13:00 -0400
Received: (qmail 26748 invoked by uid 111); 23 Jun 2008 15:12:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 23 Jun 2008 11:12:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jun 2008 11:12:58 -0400
Content-Disposition: inline
In-Reply-To: <20080623071441.GA28887@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85870>

On Mon, Jun 23, 2008 at 09:14:41AM +0200, Ingo Molnar wrote:

> Is there a Git way of finding the common ancestor of a topic branch, 
> when compared to upstream?

Try:

  git merge-base topic upstream

-Peff
