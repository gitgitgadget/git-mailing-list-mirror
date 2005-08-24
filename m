From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Removing deleted files after checkout
Date: Tue, 23 Aug 2005 17:02:00 -0700
Message-ID: <7vu0hgmccn.fsf@assigned-by-dhcp.cox.net>
References: <20050823162156.GA32240@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.63.0508231533570.23242@iabervon.org>
	<20050823205052.GA13311@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.63.0508231713450.23242@iabervon.org>
	<7vvf1wnwtl.fsf@assigned-by-dhcp.cox.net>
	<20050823222151.GA15321@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.63.0508231830280.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Baldwin <cnb@fc.hp.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 02:03:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7iiX-0003Xj-MB
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 02:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbVHXACG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 20:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbVHXACG
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 20:02:06 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:60142 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932496AbVHXACE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 20:02:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050824000202.JBWC7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 23 Aug 2005 20:02:02 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0508231830280.23242@iabervon.org> (Daniel
	Barkalow's message of "Tue, 23 Aug 2005 18:34:30 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7686>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I think that git-read-tree -u ought to remove a directory if it removes
> the last file (or directory) in it.

I concur and do not have much objections to a patch that would
do so.
