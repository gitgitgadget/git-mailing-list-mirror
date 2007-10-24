From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: intended use of "git --exec-path"?
Date: Wed, 24 Oct 2007 00:38:19 -0400
Message-ID: <20071024043819.GI14735@spearce.org>
References: <20071024043224.GR16291@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Scott Parish <sRp@srparish.net>
X-From: git-owner@vger.kernel.org Wed Oct 24 06:38:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkY0r-0005wV-80
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 06:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267AbXJXEiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 00:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753023AbXJXEiY
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 00:38:24 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33709 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbXJXEiX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 00:38:23 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IkY0c-0000Li-6c; Wed, 24 Oct 2007 00:38:22 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E277720FBAE; Wed, 24 Oct 2007 00:38:19 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071024043224.GR16291@srparish.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62188>

Scott Parish <sRp@srparish.net> wrote:
> "git --exec-path" presently prints out the highest priority path
> to find executable in. That's a what; i'm curious why and when it
> should be used. Basically i'm wondering if its still useful, and
> what, if anything, it should be printing.

git-gui uses it.  git-gui runs git-* by prefixing it with the
exec path.  It also scans the first line of the file if we are on
Windows and the "executable" doesn't end in ".exe" so it can figure
out what process to run it through.

So it really can't go away.

-- 
Shawn.
