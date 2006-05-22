From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Current Issues #3
Date: Mon, 22 May 2006 17:54:28 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0605221738090.6713@iabervon.org>
References: <7v8xoue9eo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 22 23:53:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiIKv-0007W6-Uq
	for gcvg-git@gmane.org; Mon, 22 May 2006 23:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWEVVxL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 17:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWEVVxL
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 17:53:11 -0400
Received: from iabervon.org ([66.92.72.58]:4110 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751208AbWEVVxK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 17:53:10 -0400
Received: (qmail 391 invoked by uid 1000); 22 May 2006 17:54:28 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 May 2006 17:54:28 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xoue9eo.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20536>

On Mon, 22 May 2006, Junio C Hamano wrote:

> * reflog
> 
>   I still haven't merged this series to "next" -- I do not have
>   much against what the code does, but I am unconvinced if it is
>   useful.  Also objections raised on the list that this can be
>   replaced by making sure that a repository that has hundreds of
>   tags usable certainly have a point.

I think it would make gitweb's summary view clearer, and Linus seemed 
interested in being able to look up what happened in the fast forward 
which was the first of several merges in a day.

It could be replaced by a repository with hundreds of machine-readable 
tags with code to parse dates into queries for suitable tags. But I don't 
think there's an advantage to using the tag mechanism here, because you 
never want to look the history up by exactly which history it is (the 
thing that a tag ref is good for); you'll be looking for whatever reflog 
item is the newest not after a specified time, where the specified time is 
almost never a time that a reflog item was created.

	-Daniel
*This .sig left intentionally blank*
