From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] New option (-H) for rpush/rpull to update HEAD
Date: Mon, 25 Apr 2005 00:47:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504250041500.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0504242132280.5064@sam.ics.uci.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 06:42:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPvQK-0002gt-0B
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 06:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262533AbVDYErI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 00:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbVDYErH
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 00:47:07 -0400
Received: from iabervon.org ([66.92.72.58]:56580 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262533AbVDYErF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 00:47:05 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DPvV0-0002xi-00; Mon, 25 Apr 2005 00:47:10 -0400
To: Andreas Gal <gal@uci.edu>
In-Reply-To: <Pine.LNX.4.58.0504242132280.5064@sam.ics.uci.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 24 Apr 2005, Andreas Gal wrote:

> This patch adds a new option -H to rpush/rpull to update the
> HEAD pointer when pushing a new release to a remote repository. 

Updating the head pointer (in either direction) should be instead of
specifying a commit, and should also apply to http-pull. I've also
suggested some changes to the organization of HEAD and related items, so
the logical things to read and write are likely to change soon.

	-Daniel
*This .sig left intentionally blank*

