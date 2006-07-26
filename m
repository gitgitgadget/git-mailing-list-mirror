From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make git-mv a builtin
Date: Wed, 26 Jul 2006 12:19:17 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607261204020.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607260348130.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vk660udcn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 26 12:19:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5gU7-0001W9-MS
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 12:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWGZKTU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 06:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbWGZKTU
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 06:19:20 -0400
Received: from mail.gmx.de ([213.165.64.21]:1985 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932151AbWGZKTT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jul 2006 06:19:19 -0400
Received: (qmail invoked by alias); 26 Jul 2006 10:19:18 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 26 Jul 2006 12:19:18 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk660udcn.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24210>

Hi,

On Tue, 25 Jul 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > This also moves add_file_to_index() to read-cache.c. Oh, and while
> > touching builtin-add.c, it also removes a duplicate git_config() call.
> 
> I'd have preferred to see this not depend on uncooked
> merge-recur infrastructure, since it is very likely that this
> would be ready to graduate to "master" before merge-recur.

I use "next" to base all my work (git or otherwise) on, and forgot that 
path-list did not yet make it into "master". Sorry.

> I've branched from "master" and placed the path-list stuff which
> was split out of the merge-recur WIP, and applied this patch
> with some trivial adjustment, and will place it on "pu", so I'd
> appreciate if you can double check the result.

Looks good from what I see. BTW do you have any indent command line you 
prefer? I see that all changes but in the usage string (which was my 
fault: thank you), and in Makefile (putting path-list into libgit.a rather 
than linking it specifically), are white space changes.

> > diff --git a/builtin.h b/builtin.h
> > index 5339d86..6f3a439 100755
> 
> Huh -- 100755?

A mistake introduced on cygwin. Again, sorry.

Ciao,
Dscho
