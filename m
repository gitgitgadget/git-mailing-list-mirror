X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] xdl_merge(): fix and simplify conflict handling
Date: Tue, 5 Dec 2006 23:27:44 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612052327210.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <456FD461.4080002@saville.com> <Pine.LNX.4.64.0611302330000.3695@woody.osdl.org>
 <456FDF24.1070001@saville.com> <Pine.LNX.4.64.0612012018490.3476@woody.osdl.org>
 <7vejri20mf.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612021131140.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <4575B32F.5060108@ramsay1.demon.co.uk> <Pine.LNX.4.64.0612051023460.3542@woody.osdl.org>
 <Pine.LNX.4.63.0612051949290.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vac22glzz.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612052209030.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vvekqf0yh.fsf@assigned-by-dhcp.cox.net> <el4rko$aqe$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 5 Dec 2006 22:47:12 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <el4rko$aqe$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33382>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grj43-0001GD-Sj for gcvg-git@gmane.org; Tue, 05 Dec
 2006 23:47:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936890AbWLEWq6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 17:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936892AbWLEWq6
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 17:46:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:54517 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S936890AbWLEWq5
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 17:46:57 -0500
Received: (qmail invoked by alias); 05 Dec 2006 22:27:45 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp018) with SMTP; 05 Dec 2006 23:27:45 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 5 Dec 2006, Jakub Narebski wrote:

> Junio C Hamano wrote:
> 
> > Looking at some other cases after applying your patch, I noticed
> > that I really like one thing that your version does over what
> > RCS merge does.
> 
> Is it with "try harder" option?

Yes, it uses the XDL_MERGE_ZEALOUS option.

Ciao,
Dscho
