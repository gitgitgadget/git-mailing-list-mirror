From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Add test for cloning with "--reference" repo being a
 subset of source repo
Date: Tue, 4 Mar 2008 19:24:30 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803041922090.19665@iabervon.org>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org> <200803031004.16568.johan@herland.net> <alpine.LNX.1.00.0803031318000.19665@iabervon.org> <200803040402.57993.johan@herland.net> <alpine.LNX.1.00.0803041801320.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Mar 05 01:25:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWhRd-0006GF-NX
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 01:25:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758152AbYCEAYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 19:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758100AbYCEAYk
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 19:24:40 -0500
Received: from iabervon.org ([66.92.72.58]:41951 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757971AbYCEAYi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 19:24:38 -0500
Received: (qmail 25568 invoked by uid 1000); 5 Mar 2008 00:24:30 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Mar 2008 00:24:30 -0000
In-Reply-To: <alpine.LNX.1.00.0803041801320.19665@iabervon.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76159>

On Tue, 4 Mar 2008, Daniel Barkalow wrote:

> I think we should be able to avoid setting git_dir to anything other than 
> the repo we're creating, which would avoid this problem for the present, 
> although, as you say, it would be good to be able to switch around as 
> instructed for libification purposes eventually.

Okay, stuff pushed out to not use git_dir to access the reference repo, 
and an additional test that requires that we actually note that we have 
the refs in the reference repository (because otherwise we could pass all 
the tests by just making --reference useless, but that's obviously no 
good).

	-Daniel
*This .sig left intentionally blank*
