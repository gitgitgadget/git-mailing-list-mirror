From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: Importing non-version controlled bits and pieces to Git
Date: Mon, 23 Jun 2008 07:35:14 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0806230732120.31319@ds9.cixit.se>
References: <Pine.LNX.4.64.0806201036440.24013@ds9.cixit.se>
 <20080620115102.GW29404@genesis.frugalware.org> <alpine.DEB.1.00.0806201323390.6439@racer>
 <Pine.LNX.4.64.0806201339330.4004@ds9.cixit.se> <alpine.DEB.1.00.0806201359320.6439@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 23 08:37:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAffg-0005PJ-TC
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 08:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbYFWGfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 02:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754182AbYFWGfr
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 02:35:47 -0400
Received: from ds9.cixit.se ([193.15.169.228]:51655 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751549AbYFWGfq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 02:35:46 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m5N6ZE5e001918
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 23 Jun 2008 08:35:15 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m5N6ZEeE001912;
	Mon, 23 Jun 2008 08:35:14 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <alpine.DEB.1.00.0806201359320.6439@racer>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Mon, 23 Jun 2008 08:35:15 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85839>

Johannes Schindelin:

> Why not import everything with a CR/LF, and then use filter-branch
> with a really simple tree-filter? It is slow, alright, but it is
> safe, too.

That might work. My problem is the non-linearity of the data I want to
import. But I might be able to massage the import-tars output before I
feed it to git-fast-import to describe the history I need it to.

-- 
\\// Peter - http://www.softwolves.pp.se/
