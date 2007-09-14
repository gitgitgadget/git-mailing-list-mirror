From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Sat, 15 Sep 2007 00:47:53 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709150047030.28586@racer.site>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org>
 <7v1wd1d0le.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 01:48:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWKtt-0000Nf-RX
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 01:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758909AbXINXsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 19:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756051AbXINXsg
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 19:48:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:38270 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755135AbXINXsf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 19:48:35 -0400
Received: (qmail invoked by alias); 14 Sep 2007 23:48:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 15 Sep 2007 01:48:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+wfNR5WXWwBDDVMvZGrI/gWBI8AT5cvnwQv/Vxgk
	JytJzjiuSkptWS
X-X-Sender: gene099@racer.site
In-Reply-To: <7v1wd1d0le.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58213>

Hi,

On Fri, 14 Sep 2007, Junio C Hamano wrote:

> * cr/reset (Fri Sep 14 01:19:30 2007 -0700) 5 commits
>  + Simplify cache API
>  + An additional test for "git-reset -- path"
>  + Make "git reset" a builtin.
>  + Move make_cache_entry() from merge-recursive.c into read-cache.c
>  + Add tests for documented features of "git reset".
> 
> I found "git reset commit paths..." had problem in this series,
> which was why jc/cachetree is merged into this topic to fix it.
> Hopefully we can put this in 'master' soon, after giving it
> another and final round of eyeballing.

I think this is my bug.  The initial reset-with-paths functionality in the 
builtin reset came out of my feather... Sorry!

Ciao,
Dscho
