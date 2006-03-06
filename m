From: sean <seanlkml@sympatico.ca>
Subject: Re: git clone downloads objects that are in GIT_OBJECT_DIRECTORY
Date: Sun, 5 Mar 2006 22:31:15 -0500
Message-ID: <BAYC1-PASMTP05F90E7F1807F05A274507AEE90@CEZ.ICE>
References: <20060306010825.GF20768@kvack.org>
	<20060306014253.GD25790@spearce.org>
	<7vfylwcncn.fsf@assigned-by-dhcp.cox.net>
	<20060306025702.GH25790@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 06 04:34:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG6U0-000465-Sa
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 04:34:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbWCFDdH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 22:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751596AbWCFDdH
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 22:33:07 -0500
Received: from bayc1-pasmtp05.bayc1.hotmail.com ([65.54.191.165]:49293 "EHLO
	BAYC1-PASMTP05.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751582AbWCFDdG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 22:33:06 -0500
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP05.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 5 Mar 2006 19:33:03 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 97AD1644C28;
	Sun,  5 Mar 2006 22:32:59 -0500 (EST)
To: Shawn Pearce <spearce@spearce.org>
Message-Id: <20060305223115.37c1a734.seanlkml@sympatico.ca>
In-Reply-To: <20060306025702.GH25790@spearce.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.13; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 06 Mar 2006 03:33:03.0513 (UTC) FILETIME=[ACEA8890:01C640CE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 5 Mar 2006 21:57:02 -0500
Shawn Pearce <spearce@spearce.org> wrote:

> It might be nicer if the user could place a list of locally (here
> locally being possibly remote but closer network-wise) available
> repositories which should be considered as sources for faster
> cloning.  When cloning a remote repository git-clone would try to
> examine each of the designated repositories to see if any of them
> have commits in common with the remote; if so clone off that and
> then pull from the remote, but designating the remote as `origin'.

It is already easy to start from a similar repo (eg. locally cloned)
if you wish to conserve bandwidth.

However, it might be nice to have a command that allows you to 
change origin information for a repo without needing to know git
internals; maybe something like:

$ git set-origin <URL>

Or maybe better:

$ git set-remote --pull master:origin origin <URL>

Sean
