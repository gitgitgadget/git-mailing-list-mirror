From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Start git svn clone at specific revision for cloning subprojects
 in large svn repositories?
Date: Wed, 22 Oct 2008 17:08:43 +0200
Message-ID: <48FF41FB.4080403@drmicha.warpmail.net>
References: <pan.2008.10.22.15.00.21.403423@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff Kowalczyk <jtk@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 17:10:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsfLi-0007Xx-Na
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 17:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756655AbYJVPIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 11:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754078AbYJVPIr
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 11:08:47 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:53202 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756648AbYJVPIr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Oct 2008 11:08:47 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 6692D1823B4;
	Wed, 22 Oct 2008 11:08:46 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 22 Oct 2008 11:08:46 -0400
X-Sasl-enc: pa/5lI6B90oa+AfVItEkJvdJVswxZO4OzyRCPoClcZZu 1224688126
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D73EB2028F;
	Wed, 22 Oct 2008 11:08:45 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <pan.2008.10.22.15.00.21.403423@yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98877>

Jeff Kowalczyk venit, vidit, dixit 10/22/08 17:00:
> I would like to git svn clone subprojects from a large community
> subversion repository (plone collective).
> 
> The repository is currently at 74K commits, but subprojects of interest
> are typically much more recent, and their initial import revision is known.
> 
> I would like to avoid a) unnecessary traffic to the svn server and b)
> the very long delay in git svn cloning these subprojects.
> 
> Is there a way to specfiy a starting revision to git svn clone?

Your friendly man page provider says:

       -r <ARG>, --revision <ARG>
           Used with the fetch command.

           This allows revision ranges for partial/cauterized history to
be supported. $NUMBER, $NUMBER1:$NUMBER2 (numeric
           ranges), $NUMBER:HEAD, and BASE:$NUMBER are all supported.

           This can allow you to make partial mirrors when running
fetch; but is generally not recommended because history
           will be skipped and lost.

Usage of "Scroll Down" is strongly advised when viewing git help svn ;)

Michael

P.S.: It works nicely, don't mind the warning in the man page if you
know the start rev for sure.
