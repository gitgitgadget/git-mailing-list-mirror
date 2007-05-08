From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Add pack.depth option to git-pack-objects and change
 default depth to 50
Date: Tue, 08 May 2007 13:35:40 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705081323040.24220@xanadu.home>
References: <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net>
 <11786309073709-git-send-email-tytso@mit.edu>
 <11786309072612-git-send-email-tytso@mit.edu>
 <alpine.LFD.0.99.0705081136050.24220@xanadu.home>
 <20070508163044.GA15796@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue May 08 19:35:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlTbM-0001WD-QV
	for gcvg-git@gmane.org; Tue, 08 May 2007 19:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965211AbXEHRfo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 13:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934554AbXEHRfo
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 13:35:44 -0400
Received: from relais.videotron.ca ([24.201.245.36]:15183 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934427AbXEHRfn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 13:35:43 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JHQ00FLOGVGPY10@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 08 May 2007 13:35:40 -0400 (EDT)
In-reply-to: <20070508163044.GA15796@thunk.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46603>

On Tue, 8 May 2007, Theodore Tso wrote:

> On Tue, May 08, 2007 at 11:38:46AM -0400, Nicolas Pitre wrote:
> > On Tue, 8 May 2007, Theodore Ts'o wrote:
> > 
> > > Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
> > 
> > I'd prefer if tests were performed on the performance impact before 
> > changing the default depth.  If done separately from this patch then the 
> > commit log could contain those results as well.
> 
> The following results are on a recent git repository, using time to
> record the real, user, and sys times on the two commands: "git-gc
> --no-reuse-delta --window=X --depth=Y" and "git log --pretty=oneline
> -S'object' > /dev/null".  All of these tests were done with a hot
> cache, so disk speed didn't enter into the calculations.
[...]
> My conclusion given this quick benchmark is that it seems to me that
> changing the defaults of --depth to 50, and keeping --window at 10, is
> a reasonable thing to do.

Effectively.

I'd still prefer to see the default changed in a patch of its own 
though.


Nicolas
