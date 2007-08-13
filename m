From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Mon, 13 Aug 2007 11:50:39 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708130122200.7037@racer.site>
References: <f99cem$4a4$1@sea.gmane.org> <30e4a070708080650j5de7ee92p4acd7e82de7d9dff@mail.gmail.com>
 <A2397231-1B81-4AD4-87CB-8FF8FB9BA89C@zib.de>
 <30e4a070708080941j49b3d58cxc39bbe65f2fee9d5@mail.gmail.com>
 <Pine.LNX.4.64.0708081810130.14781@racer.site> <75EB313E-807D-44FB-A186-A151F182B47B@zib.de>
 <Pine.LNX.4.64.0708082228520.21857@racer.site> <76795DDC-29A5-4C7E-B56E-A6316A183C75@zib.de>
 <e7bda7770708092307g49fa9976l5f9972592129fc8e@mail.gmail.com>
 <2383328F-300E-459C-A299-90242DA230F7@zib.de>
 <e7bda7770708101531n782118e9qb9c6de4e934940ea@mail.gmail.com>
 <EF7DFA5A-9C3A-4D0B-9533-D1D60AE4A44C@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Torgil Svensson <torgil.svensson@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Aug 13 12:51:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKXWf-00055O-FP
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 12:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S941864AbXHMKvl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 06:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1775070AbXHMKvk
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 06:51:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:34213 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S941674AbXHMKvh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 06:51:37 -0400
Received: (qmail invoked by alias); 13 Aug 2007 10:51:34 -0000
Received: from R3460.r.pppool.de (EHLO noname) [89.54.52.96]
  by mail.gmx.net (mp039) with SMTP; 13 Aug 2007 12:51:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ziV1ZjTOzCUILvM0FrpyO4juGcuXQPs8TfmcfxU
	nFEW33V7OXBStc
X-X-Sender: gene099@racer.site
In-Reply-To: <EF7DFA5A-9C3A-4D0B-9533-D1D60AE4A44C@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55759>

Hi,

On Sat, 11 Aug 2007, Steffen Prohaska wrote:

> I'm impressed. Pretty much everything I tried today worked for me. After 
> I got git gui running, and learned how to avoid pitfalls of git 
> submodule, development went smoothly.

Thanks!

> I could also think of a fail safe update, that allows to upgrade an 
> existing msysgit to a specific tag (maybe after stashing the current 
> installation and reverting in case of problems).

It's pretty early to think about stable releases, let alone upgrades ;-)

> Maybe git gui could be integrated with the Windows Explorer and be 
> launched on a directory. Maybe this is one of your evil plans. But this 
> is already more than I need.

That is already in the works.  An alpha version is already working.

> What do you think is needed to merge changes back to git.git? I counted 
> approximately 20k diff lines (incl. context) between msysgit's git 
> master and git.git's master. At a first glance much of them seem to be 
> compatibility stuff.

It is _all_ compatibility stuff.

Basically, it all boils down to grabbing a specific part of the diff 
related to a certain concept (such as NO_IPV6), and whip the patch 
(series) into shape.

Submit it to git.git.  Work on it until it is part of the official 
distribution.

Continue with the next part of the diff.

Ciao,
Dscho
