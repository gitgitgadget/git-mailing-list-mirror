From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: Importing non-version controlled bits and pieces to Git
Date: Fri, 20 Jun 2008 13:42:33 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0806201339330.4004@ds9.cixit.se>
References: <Pine.LNX.4.64.0806201036440.24013@ds9.cixit.se>
 <20080620115102.GW29404@genesis.frugalware.org> <alpine.DEB.1.00.0806201323390.6439@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 20 14:43:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9fxu-0002yH-1E
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 14:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014AbYFTMmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 08:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753016AbYFTMmr
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 08:42:47 -0400
Received: from ds9.cixit.se ([193.15.169.228]:44598 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752999AbYFTMmq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 08:42:46 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m5KCgY5e004334
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 Jun 2008 14:42:34 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m5KCgXXg004329;
	Fri, 20 Jun 2008 14:42:33 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <alpine.DEB.1.00.0806201323390.6439@racer>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Fri, 20 Jun 2008 14:42:34 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85630>

Johannes Schindelin:

> On Fri, 20 Jun 2008, Miklos Vajna wrote:
> > Maybe contrib/fast-import/import-tars.perl?

As I noted, I have used that before, and it works best with linear
histories, even if I managed to hack it to create a branch for a
project that had a simple branching structure (an update was created
for version n.x after version n+1.x was released).

> You should be able to use git-fast-import from a simple script
> yourself; if you would like to see an example how to feed
> fast-import, just export a few commits with "git fast-export
> HEAD~5..".

Yeah, that is what I am currently planning on doing. I was just trying
to be lazy and see if someone already had solved the problem for me :-)


One complicating factor is that I am working with DOS/Windows source
code, so all text files have CRLF line-endings, which means converting
before feeding to fast-import, or manually doing "git add" with
core.autocrlf == true. fast-import can't be set up to do CRLF
auto-conversion, can it?

-- 
\\// Peter - http://www.softwolves.pp.se/
