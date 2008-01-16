From: Mike <fromlists@talkingspider.com>
Subject: Re: I don't want the .git directory next to my code.
Date: Tue, 15 Jan 2008 23:24:55 -0500
Message-ID: <478D8717.50100@talkingspider.com>
References: <478D79BD.7060006@talkingspider.com> <alpine.LNX.1.00.0801152305050.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 05:25:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEzq9-00045k-SB
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 05:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757504AbYAPEY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 23:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755641AbYAPEY5
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 23:24:57 -0500
Received: from relay00.pair.com ([209.68.5.9]:2207 "HELO relay00.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753407AbYAPEY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 23:24:56 -0500
Received: (qmail 40394 invoked from network); 16 Jan 2008 04:24:55 -0000
Received: from unknown (HELO ?192.168.1.100?) (unknown)
  by unknown with SMTP; 16 Jan 2008 04:24:55 -0000
X-pair-Authenticated: 72.225.213.70
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <alpine.LNX.1.00.0801152305050.13593@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70626>


Daniel Barkalow wrote:
 > On Tue, 15 Jan 2008, Mike wrote:
 >
 >
 > Generate your tarballs with "git archive", which will also make sure 
that
 > you don't accidentally include anything else that's not committed.
 > Likewise for sending to the live site, probably.

Thanks please see my response to David about why this isn't good.

 >
 > You'll probably want to keep your history, which is what's in .git, when
 > you migrate to a different server; that's kind of the point of using
 > version control...

The git repositories should be on the development server, but should 
*never* be on the live server.  Anywhere, ever.

 > export GIT_DIR=/somewhere-else.git
 >
 > Note that this only really works if you've only got one repository;
 > there's no good way to have the repository information outside of the
 > working directory and still have which repository you're using depend on
 > which directory you're working in.
 >

Thanks. Damn. We do have several repositories, (several sites).  I'll 
try Dan's soft link suggestion.

thanks
m
