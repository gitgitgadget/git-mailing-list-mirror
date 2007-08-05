From: Jeff King <peff@peff.net>
Subject: Re: git-gui console app ?
Date: Sun, 5 Aug 2007 06:19:53 -0400
Message-ID: <20070805101953.GI12507@coredump.intra.peff.net>
References: <20070804101058.GA520@Mac2.local> <Pine.LNX.4.64.0708041225520.14781@racer.site> <20070804115331.GA2962@Mac2.local> <20070804120342.GC9716@coredump.intra.peff.net> <20070804123834.GA3036@Mac2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
To: Erik Colson <eco@ecocode.net>
X-From: git-owner@vger.kernel.org Sun Aug 05 12:20:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHdDf-00058K-SZ
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 12:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755366AbXHEKT4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 06:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754792AbXHEKT4
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 06:19:56 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3682 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754770AbXHEKTz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 06:19:55 -0400
Received: (qmail 16729 invoked from network); 5 Aug 2007 10:19:58 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 5 Aug 2007 10:19:58 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Aug 2007 06:19:53 -0400
Content-Disposition: inline
In-Reply-To: <20070804123834.GA3036@Mac2.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54985>

On Sat, Aug 04, 2007 at 02:38:34PM +0200, Erik Colson wrote:

> > By default, it will show the changes between your working tree and the
> > index (i.e., changed but not updated). You can show the diff of "updated
> > but not commited" with "git-diff --cached".
> 
> yep that is the info I would like to browse in a way git-gui does it...
> showing a list of the files in the diff, and letting the user select a
> file to show the part of the diff for that file.

Ah, I see. There is a status mode for tig (tig -S), but you can't jump
to the diff of a particular file. It shouldn't be that difficult to add
for somebody familiar with the tig codebase, but I am not such a
somebody.

Jonas, am I right that this should be a one-liner? If you can point me
in the right direction, I can try to take a closer look, but I'm having
trouble following the code.

-Peff
