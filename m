From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-0.10
Date: Mon, 17 Mar 2008 11:27:43 +0100
Message-ID: <20080317102743.GB6830@diku.dk>
References: <20080317020304.GA19249@diku.dk> <m3r6e9wup2.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 11:28:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbCZu-0006Rb-8k
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 11:28:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbYCQK1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 06:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbYCQK1q
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 06:27:46 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:32899 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751396AbYCQK1q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 06:27:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 3E22F19BB38;
	Mon, 17 Mar 2008 11:27:45 +0100 (CET)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 12809-15; Mon, 17 Mar 2008 11:27:43 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id F111E19BB37;
	Mon, 17 Mar 2008 11:27:43 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 42B886DF894; Mon, 17 Mar 2008 11:26:52 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id D9F751DC4B6; Mon, 17 Mar 2008 11:27:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <m3r6e9wup2.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77424>

Jakub Narebski <jnareb@gmail.com> wrote Mon, Mar 17, 2008:
> Jonas Fonseca <fonseca@diku.dk> writes:
> 
> > A new version of tig is available! It brings many documentation
> > improvements, bug fixes, and some much needed updates to work better
> > with git (e.g. by using --no-color and avoiding to use git-diff).
> 
> It seems like 'g', toggle revision graph visualization, doesn't work.
> Checked with
>   $ tig log --pretty=oneline --abbrev=8 --abbrev-commit

Well, the revgraph visualization only works for the main view, not the
log view (which has been sort of deprecated).

> > On startup, tig will now attempt to first read a system-wide configuration
> > file before loading the user specific configuration file. Cherry picking
> > from inside tig has been generalized, making it possible to wire
> > external commands, which can access information about the current
> > commit, to a keybinding.
> 
> By thw ay, in tig(1), in the "FILES" section, there is 
> 
>        /home/fonseca/etc/tigrc
>            System wide configuration file.
> 
> Is it a bug in code, or just in documentation.

Oops, embarrasing. I will look into fixing it so that documentation
installed from the tarball will insert the local sysconfdir path.

-- 
Jonas Fonseca
