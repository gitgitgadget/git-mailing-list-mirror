From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Removing deleted files after checkout
Date: Tue, 23 Aug 2005 18:34:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508231830280.23242@iabervon.org>
References: <20050823162156.GA32240@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.63.0508231533570.23242@iabervon.org> <20050823205052.GA13311@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.63.0508231713450.23242@iabervon.org> <7vvf1wnwtl.fsf@assigned-by-dhcp.cox.net>
 <20050823222151.GA15321@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 00:32:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7hIf-00057X-Ab
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 00:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbVHWWa6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 18:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVHWWa6
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 18:30:58 -0400
Received: from iabervon.org ([66.92.72.58]:16909 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932460AbVHWWa6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Aug 2005 18:30:58 -0400
Received: (qmail 15990 invoked by uid 1000); 23 Aug 2005 18:34:30 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Aug 2005 18:34:30 -0400
To: Carl Baldwin <cnb@fc.hp.com>
In-Reply-To: <20050823222151.GA15321@hpsvcnb.fc.hp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7683>

On Tue, 23 Aug 2005, Carl Baldwin wrote:

> The thing that this doesn't do is remove empty directories when the last
> file is deleted.  I once expressed the opinion in a previous thread that
> directories should be added and removed explicitly in git.  (Thus
> allowing an empty directory to be added).  If this were to happen then
> this case would get handled correctly.  However, if git stays with the
> status quo then I think that git-read-tree -u should be changed to
> remove the empty directory.  This would make it consistent.

I think that git-read-tree -u ought to remove a directory if it removes
the last file (or directory) in it.

	-Daniel
*This .sig left intentionally blank*
