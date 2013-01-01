From: Paul Mackerras <paulus@samba.org>
Subject: Re: Bug in latest gitk - can't click lines connecting commits
Date: Wed, 2 Jan 2013 10:22:20 +1100
Message-ID: <20130101232220.GD20724@iris.ozlabs.ibm.com>
References: <20130101172156.GA22450@gmail.com>
 <1kw18d3.5sftkl125qdz4M%stefan@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jason Holden <jason.k.holden.swdev@gmail.com>, git@vger.kernel.org
To: Stefan Haller <stefan@haller-berlin.de>
X-From: git-owner@vger.kernel.org Wed Jan 02 02:29:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqD9S-0001tw-GY
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 02:29:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400Ab3ABB3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 20:29:24 -0500
Received: from ozlabs.org ([203.10.76.45]:57660 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752327Ab3ABB3X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 20:29:23 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 3DDC12C0097; Wed,  2 Jan 2013 12:29:21 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <1kw18d3.5sftkl125qdz4M%stefan@haller-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212483>

On Tue, Jan 01, 2013 at 06:54:23PM +0100, Stefan Haller wrote:
> Jason Holden <jason.k.holden.swdev@gmail.com> wrote:
> 
> > I was testing some patches against the latest gitk, and noticed that when I
> > click the mouse on the lines that connect the commits in the history graph,
> > I get an error popup with:
> >  Error: can't read "cflist_top": no such variable
> > 
> > Looks like this was introduced in gitk commit b967135d89e8d8461d059
> >  gitk: Synchronize highlighting in file view when scrolling diff
> 
> A patch that fixes this was proposed over two months ago, and Paul said
> he had applied it:
> 
>   <http://permalink.gmane.org/gmane.comp.version-control.git/208162>
> 
> However, looking at git://ozlabs.org/~paulus/gitk.git it's not there.
> Paul?

I just forgot to push it out.  It's there now.

Paul.
