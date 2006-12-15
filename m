X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: svn versus git
Date: Fri, 15 Dec 2006 21:19:16 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612152117390.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200612132200.41420.andyparkins@gmail.com>  <20061213225627.GC32568@spearce.org>
  <200612140908.36952.andyparkins@gmail.com>  <7vodq695ha.fsf@assigned-by-dhcp.cox.net>
  <fcaeb9bf0612140708w6bc691f6k2e08fbab2a651421@mail.gmail.com> 
 <Pine.LNX.4.63.0612141630240.3635@wbgn013.biozentrum.uni-wuerzburg.de> 
 <fcaeb9bf0612140832v1c80bf7dgd61897111292d31@mail.gmail.com> 
 <Pine.LNX.4.63.0612141754420.3635@wbgn013.biozentrum.uni-wuerzburg.de> 
 <fcaeb9bf0612140910t6aff44e1m9570b20850a41b87@mail.gmail.com> 
 <Pine.LNX.4.63.0612150118190.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <fcaeb9bf0612150726o40527552l8b3564ddcc3adb94@mail.gmail.com>
 <Pine.LNX.4.63.0612152115000.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 15 Dec 2006 20:19:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.63.0612152115000.3635@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34546>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvJWc-0001xe-A7 for gcvg-git@gmane.org; Fri, 15 Dec
 2006 21:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753401AbWLOUTT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 15:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753403AbWLOUTT
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 15:19:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:57751 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1753401AbWLOUTS
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006 15:19:18 -0500
Received: (qmail invoked by alias); 15 Dec 2006 20:19:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp032) with SMTP; 15 Dec 2006 21:19:17 +0100
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Fri, 15 Dec 2006, Johannes Schindelin wrote:

> On Fri, 15 Dec 2006, Nguyen Thai Ngoc Duy wrote:
> 
> > About adding index support to git-show, yes it's really messy. index
> > doesn't have tree objects.
> 
> Insofar, it is not messy: git-show only shows _objects_. For example, "git 
> show :README" works as expected if you have a file called "README" in the 
> index...

Note: this is not completely true. The index contains cache_trees. But 
they do not need to be up-to-date, which would mean that "git show :./" 
would have to remake the cache_tree, and _then_ show it.

Ciao,
Dscho
