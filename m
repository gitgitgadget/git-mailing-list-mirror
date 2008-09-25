From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH 0/3] [RFC] Support for publishing projects at central
 site
Date: Thu, 25 Sep 2008 09:56:18 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0809250951090.5683@ds9.cixit.se>
References: <20080924235734.697978308@suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, spearce@spearce.org
To: pasky@suse.cz
X-From: git-owner@vger.kernel.org Thu Sep 25 10:57:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KimfG-00043t-UT
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 10:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754316AbYIYI40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 04:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752878AbYIYI40
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 04:56:26 -0400
Received: from ds9.cixit.se ([193.15.169.228]:49366 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754291AbYIYI4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 04:56:25 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m8P8uJY1020757
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 25 Sep 2008 10:56:19 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m8P8uI7C020751;
	Thu, 25 Sep 2008 10:56:18 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <20080924235734.697978308@suse.cz>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Thu, 25 Sep 2008 10:56:19 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96737>

Hi!

pasky@suse.cz:

> This is not really meant for as-is application, of course, but more
> to see if people think it is good idea to have this kind of
> functionality in git-gui at all and how generic it should be. This
> mini-series depends on pretty much all the other patches I have
> submitted tonight.

As long as it is easy to implement the server-side back-end needed to
automatically accept projects that you publish through this hook, then
this is something that would really help out in this conext.

I currently need to perform some "magic" on the server-side to set up
new projects, it would be nice if all the people using it have to do is
to select a menu option saying "publish". Preferrably through the git
protocol, so that I don't have to set up ssh on people's machines
(working in a Windows environment here, so all central repositories are
set up to use the git protocol for both pull and push).


How do you envision discovering the location to publish to? Some kind
of automatic configuration option would be nice. Perhaps be able to
point git gui at some magic URI that would download an XML (or text)
file describing the central server, perhaps?

-- 
\\// Peter - http://www.softwolves.pp.se/
