X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git pull and merging.
Date: Wed, 6 Dec 2006 10:58:31 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612061057250.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com>
 <7vodqhaa7o.fsf@assigned-by-dhcp.cox.net> <cc723f590612052121u1f6e3c9lc7329f40ee1c9e5a@mail.gmail.com>
 <el62hi$esu$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 6 Dec 2006 09:58:39 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <el62hi$esu$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33414>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrtXw-0007bv-MV for gcvg-git@gmane.org; Wed, 06 Dec
 2006 10:58:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760397AbWLFJ6e (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 04:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760403AbWLFJ6e
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 04:58:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:58070 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1760397AbWLFJ6d
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 04:58:33 -0500
Received: (qmail invoked by alias); 06 Dec 2006 09:58:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp036) with SMTP; 06 Dec 2006 10:58:31 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 6 Dec 2006, Jakub Narebski wrote:

> $ git repo-config remote.origin.fetch  refs/heads/master:refs/remotes/origin/master
> $ git repo-config remote.origin.fetch  refs/heads/next:refs/remotes/origin/next

Oops. You want to append "^$" at the end (otherwise the "master" entry is 
overwritten; remote.origin.fetch is a multivalued key). Same for "pu".

Ciao,
