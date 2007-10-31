From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: Recording merges after repo conversion
Date: Wed, 31 Oct 2007 13:17:13 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0710311315250.16298@ds9.cixit.se>
References: <Pine.LNX.4.64.0710090807060.26773@ds9.cixit.se>
 <13D1D3DD-9652-4097-8364-DEF4F26540D3@lrde.epita.fr>
 <Pine.LNX.4.62.0710301433150.652@perkele.intern.softwolves.pp.se>
 <Pine.LNX.4.64.0710301504270.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Benoit SIGOURE <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 31 13:17:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InCW6-0000i1-Kr
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 13:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755558AbXJaMRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 08:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755516AbXJaMRU
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 08:17:20 -0400
Received: from ds9.cixit.se ([193.15.169.228]:39607 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755385AbXJaMRT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 08:17:19 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id l9VCHEnQ025228
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 31 Oct 2007 13:17:14 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id l9VCHDlr025223;
	Wed, 31 Oct 2007 13:17:13 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <Pine.LNX.4.64.0710301504270.4362@racer.site>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Wed, 31 Oct 2007 13:17:14 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62817>

Johannes Schindelin:

> No.  Use filter-branch, and publish the cleaned up history (possibly as a 
> new branch/repo).

I'm considering doing this, and just replace the published repository
with the "fixed" one (and fix-up all my clonings of it). I'm having
some problems digesting the git-filter-branch manual page though--is
there an easy way of automating the process, given that I now have a
"grafts" file that expresses what I would like git-filter-branch to do
(I guess it would have to work backwards changing the merge points, to
be able to find all the revisions under the names I've used in the
grafts file)?

-- 
\\// Peter - http://www.softwolves.pp.se/
