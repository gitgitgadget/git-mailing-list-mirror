X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-explain
Date: Wed, 6 Dec 2006 01:27:42 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612060125320.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200612031701.15594.alan@chandlerfamily.org.uk>
 <Pine.LNX.4.64.0612031024480.3476@woody.osdl.org> <7v1wngwws6.fsf@assigned-by-dhcp.cox.net>
 <7vwt57j94c.fsf_-_@assigned-by-dhcp.cox.net> <el3ibq$9kn$2@sea.gmane.org>
 <46a038f90612051500w44438f70y3c7d1c99998d16bb@mail.gmail.com>
 <7vslfudjsa.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612060033540.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vu009dhgz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 6 Dec 2006 00:27:50 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vu009dhgz.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33393>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrkdX-0005ZN-AB for gcvg-git@gmane.org; Wed, 06 Dec
 2006 01:27:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758765AbWLFA1o (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 19:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758818AbWLFA1o
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 19:27:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:54260 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1758765AbWLFA1n
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 19:27:43 -0500
Received: (qmail invoked by alias); 06 Dec 2006 00:27:42 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp017) with SMTP; 06 Dec 2006 01:27:42 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 5 Dec 2006, Junio C Hamano wrote:

> But the more I think about it, I feel that "undo" is less important.

Me, too. I was really astonished that people said -- after quite some 
explanations -- "wow, you mean I did not lose any work?"

That's the nice thing about git: it is really hard to lose any objects. 
Unless you explicitely issue a "git prune", you can resurrect whatever was 
your state.

In this spirit, maybe it is time to enable reflog per default?


Ciao,
Dscho
