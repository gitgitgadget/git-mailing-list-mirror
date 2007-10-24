From: Scott Parish <sRp@srparish.net>
Subject: Re: intended use of "git --exec-path"?
Date: Tue, 23 Oct 2007 22:47:49 -0700
Message-ID: <20071024054749.GT16291@srparish.net>
References: <20071024043224.GR16291@srparish.net> <20071024043819.GI14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 24 07:48:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkZ63-00032a-B7
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 07:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753725AbXJXFru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 01:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753516AbXJXFru
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 01:47:50 -0400
Received: from smtp-gw5.mailanyone.net ([208.70.128.56]:43528 "EHLO
	smtp-gw5.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbXJXFru (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 01:47:50 -0400
Received: from mailanyone.net
	by smtp-gw5.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP srp)
	id 1IkZ5m-0005dZ-Mv; Wed, 24 Oct 2007 00:47:49 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 502
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Tue, 23 Oct 2007 22:47:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20071024043819.GI14735@spearce.org>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62193>

On Wed, Oct 24, 2007 at 12:38:19AM -0400, Shawn O. Pearce wrote:

> Scott Parish <sRp@srparish.net> wrote:
> > "git --exec-path" presently prints out the highest priority path
> > to find executable in. That's a what; i'm curious why and when it
> > should be used. Basically i'm wondering if its still useful, and
> > what, if anything, it should be printing.
> 
> git-gui uses it.  git-gui runs git-* by prefixing it with the
> exec path.  It also scans the first line of the file if we are on
> Windows and the "executable" doesn't end in ".exe" so it can figure
> out what process to run it through.
> 
> So it really can't go away.

So it sounds like it might be more helpful for git to return its
PATH, so other programs can set their PATH or search for executables
accordingly.

sRp

-- 
Scott Parish
http://srparish.net/
