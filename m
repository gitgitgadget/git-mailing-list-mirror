From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-commit could allow grouping of short options
Date: Sat, 3 Feb 2007 17:05:59 -0800
Message-ID: <20070204010559.GA3421@localdomain>
References: <20070203224151.19678.qmail@41f6d84bf5aaea.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 04 02:06:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDVpW-0004d7-JZ
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 02:06:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbXBDBGE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 20:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbXBDBGE
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 20:06:04 -0500
Received: from hand.yhbt.net ([66.150.188.102]:51168 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751578AbXBDBGD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 20:06:03 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 01F947DC094;
	Sat,  3 Feb 2007 17:05:59 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 03 Feb 2007 17:05:59 -0800
Content-Disposition: inline
In-Reply-To: <20070203224151.19678.qmail@41f6d84bf5aaea.315fe32.mid.smarden.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38627>

Gerrit Pape <pape@smarden.org> wrote:
> Hi, please see http://bugs.debian.org/407241:
> 
> > git-commit could allow grouping of short options, rather than failing:
> > 
> > $ git commit -avs
> > Usage: /usr/bin/git-commit [-a] [-s] [-v] [--no-verify] ...
> 
> I personally would like this too, not only for git-commit.

I had some patches to implement this a while ago ('gitopt') but I never
got around to cleaning them up and fixing some bugs.  Hopefully I'll
have time in the next weeks.

-- 
Eric Wong
