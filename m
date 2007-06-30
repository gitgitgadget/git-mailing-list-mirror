From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] git-clone: fetch possibly detached HEAD over dumb http
Date: Sat, 30 Jun 2007 15:45:44 +0200
Message-ID: <20070630134542.GF7969MdfPADPa@greensroom.kotnet.org>
References: <20070628105208.GA11105@liacs.nl>
 <7vsl8bmxv9.fsf@assigned-by-dhcp.pobox.com> <20070629083108.GA14747@liacs.nl>
 <20070630133310.GB2866@steel.home>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Louis-Noel Pouchet <louis-noel.pouchet@inria.fr>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 30 15:45:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4dGp-0005lW-GO
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 15:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757455AbXF3Nps (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 09:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757287AbXF3Nps
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 09:45:48 -0400
Received: from psmtp09.wxs.nl ([195.121.247.23]:53051 "EHLO psmtp09.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756097AbXF3Npr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 09:45:47 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp09.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JKG00593BK9H3@psmtp09.wxs.nl> for git@vger.kernel.org; Sat,
 30 Jun 2007 15:45:46 +0200 (MEST)
Received: (qmail 17494 invoked by uid 500); Sat, 30 Jun 2007 13:45:45 +0000
In-reply-to: <20070630133310.GB2866@steel.home>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51216>

On Sat, Jun 30, 2007 at 03:33:10PM +0200, Alex Riesen wrote:
> Sven Verdoolaege, Fri, Jun 29, 2007 10:31:08 +0200:
> > +		head_sha1=`cat "$GIT_DIR/REMOTE_HEAD"`
> > +		case "$head_sha1" in
> > +		'ref: refs/'*)
> > +			;;
> 
> And what do you do if the HEAD is a reflink on something not in refs/?
> Like "ref: tmp"? Yes, it is unlikely, but is not forbidden.

It may not be forbidden, but I don't think it would
work with current git-clone either.

skimo
