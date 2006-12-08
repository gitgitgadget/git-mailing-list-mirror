X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: For all you darcs lovers: git-hunk-commit
Date: Fri, 8 Dec 2006 16:37:30 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612081634570.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0612051936480.28348@wbgn013.biozentrum.uni-wuerzburg.de>
  <45760CA3.9060003@xs4all.nl>  <Pine.LNX.4.63.0612060129310.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <1165568153.21747.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 8 Dec 2006 15:37:56 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <1165568153.21747.11.camel@localhost.localdomain>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33699>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GshnM-0007Cb-9n for gcvg-git@gmane.org; Fri, 08 Dec
 2006 16:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1425578AbWLHPhd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 10:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425585AbWLHPhd
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 10:37:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:49005 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1425578AbWLHPhc
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 10:37:32 -0500
Received: (qmail invoked by alias); 08 Dec 2006 15:37:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp049) with SMTP; 08 Dec 2006 16:37:31 +0100
To: Matthias Kestenholz <lists@spinlock.ch>
Sender: git-owner@vger.kernel.org

Hi,

On Fri, 8 Dec 2006, Matthias Kestenholz wrote:

> On Wed, 2006-12-06 at 01:36 +0100, Johannes Schindelin wrote:
> > But in this case, bash was faster to script and debug, and unless people 
> > speak up, saying "I want that feature badly!", I do not plan to do 
> > anything with it.
> 
> This feature is _very_ handy and I think it would be great if this
> became part of the default git distribution.

Note that it requires a relatively new bash version ATM, because of the 
"while read line; do ...; done < <(cmd)" construct. I have another version 
which substitutes a temporary file for that, but I keep thinking that a 
graphical tool, such as git-gui, would be more appropriate. BTW I just did 
it in bash, because I wanted to learn about these famous bash arrays.

Ciao,
Dscho
