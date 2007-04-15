From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] Add basic infrastructure to assign attributes to
 paths
Date: Sun, 15 Apr 2007 17:54:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704151055530.18846@racer.site>
References: <7vr6qod4wh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 15 17:55:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hd74W-0006iE-54
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 17:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989AbXDOPzT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 11:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752995AbXDOPzT
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 11:55:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:39397 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752989AbXDOPzS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 11:55:18 -0400
Received: (qmail invoked by alias); 15 Apr 2007 15:55:16 -0000
Received: from 88-110-140-199.dynamic.dsl.as9105.com (EHLO 88-110-140-199.dynamic.dsl.as9105.com) [88.110.140.199]
  by mail.gmx.net (mp027) with SMTP; 15 Apr 2007 17:55:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+WBTV8E4uW/TjSW8n53vftqW09gz4qvrJV9De0c1
	8XZhaD51fKEq0H
X-X-Sender: gene099@racer.site
In-Reply-To: <7vr6qod4wh.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44495>

Hi,

On Fri, 13 Apr 2007, Junio C Hamano wrote:

> --- a/Makefile
> +++ b/Makefile
> @@ -283,7 +283,7 @@ LIB_H = \
>  	diff.h object.h pack.h pkt-line.h quote.h refs.h list-objects.h sideband.h \
>  	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
>  	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
> -	utf8.h reflog-walk.h patch-ids.h
> +	utf8.h reflog-walk.h attr.h

Did you really want to remove "patch-ids.h" from the list?

Ciao,
Dscho
