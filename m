From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI
 revamp
Date: Thu, 30 Oct 2008 13:03:11 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810301301510.13034@xanadu.home>
References: <1225338485-11046-1-git-send-email-sam@vilain.net>
 <20081030143918.GB14744@mit.edu> <20081030144321.GF24098@artemis.corp>
 <20081030163056.GA8899@mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Pierre Habouzit <madcoder@debian.org>, Sam Vilain <sam@vilain.net>,
	git@vger.kernel.org, Sam Vilain <samv@vilain.net>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Oct 30 18:06:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvawh-00008P-JB
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 18:04:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755083AbYJ3RDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 13:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755087AbYJ3RDR
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 13:03:17 -0400
Received: from relais.videotron.ca ([24.201.245.36]:32670 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754914AbYJ3RDR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 13:03:17 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9K00IKRA1BB8F0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 30 Oct 2008 13:03:11 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20081030163056.GA8899@mit.edu>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99503>

On Thu, 30 Oct 2008, Theodore Tso wrote:

> On Thu, Oct 30, 2008 at 03:43:21PM +0100, Pierre Habouzit wrote:
> > 
> > git format-patch origin/next.. works already. I'm used to the asymetric
> > git format-patch origin/next syntax, and I would be sorry if it
> > disappeared though, and I see no really good reason to get rid of it.
> 
> The reason why it annoys me is because I often what to cherry-pick a
> single patch to send to someone, and so while "git show 332d2e78"
> shows me the patch, but if I want to use git-send-email for that
> particular patch, "git format-patch 332d2e78" doesn't DTRT.  I have to
> type "git format-patch 332d2e78^..332d2e78" instead.

try:

	git show --pretty=email 332d2e78


Nicolas
