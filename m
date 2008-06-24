From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: Importing non-version controlled bits and pieces to Git
Date: Tue, 24 Jun 2008 07:46:14 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0806240742240.5039@ds9.cixit.se>
References: <Pine.LNX.4.64.0806201036440.24013@ds9.cixit.se>
 <20080620115102.GW29404@genesis.frugalware.org> <alpine.DEB.1.00.0806201323390.6439@racer>
 <Pine.LNX.4.64.0806201339330.4004@ds9.cixit.se> <alpine.DEB.1.00.0806201359320.6439@racer>
 <Pine.LNX.4.64.0806230732120.31319@ds9.cixit.se> <Pine.LNX.4.64.0806231543580.31319@ds9.cixit.se>
 <20080624051204.GA1760@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 08:47:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB2J9-0002Zo-J7
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 08:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048AbYFXGqU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Jun 2008 02:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754001AbYFXGqU
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 02:46:20 -0400
Received: from ds9.cixit.se ([193.15.169.228]:54434 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753820AbYFXGqS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 02:46:18 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m5O6kF5e009122
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 24 Jun 2008 08:46:15 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m5O6kFRp009117;
	Tue, 24 Jun 2008 08:46:15 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <20080624051204.GA1760@diana.vm.bytemark.co.uk>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Tue, 24 Jun 2008 08:46:15 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85999>

Karl Hasselstr=F6m:

> A bit too late now, but ...

Not really, I'm on to the next project to import :-)

> another thing you could have done is make a straight linear import =E0
> la import-tars, and then modified the parentage with grafts until it
> looked good; and then finally use filter-branch to make the grafts
> part of the "real" history.

Yeah, I was considering this approach, but then I was half-way
designing the script in my head, plus that the import is so quick that
it was easy enough to re-write the configuration file and re-import to
try something else. I love that aspect of Git -- the preparing of the
file to import takes longer than the actual git-fast-import call...

> The advantage of this approach is that you can edit the parentage
> almost interactively, which should be the best approach given that
> you have a small number of commits and have to guess their
> relationships.

"Almost" being the magic word :-) I achieved more or less the same by
re-importing. Plus that the job of preparing tarballs of everything
would have been some work as well, since I had to choose which files to
import from each directory (and do CRLF transform).

--=20
\\// Peter - http://www.softwolves.pp.se/
