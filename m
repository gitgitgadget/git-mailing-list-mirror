X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git
Date: Wed, 29 Nov 2006 11:21:21 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611291118160.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vzmaf3kdl.fsf@assigned-by-dhcp.cox.net> <87zmabv0i7.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 29 Nov 2006 10:22:07 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <87zmabv0i7.wl%cworth@cworth.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32629>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpMZD-0005Ii-Mc for gcvg-git@gmane.org; Wed, 29 Nov
 2006 11:21:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966872AbWK2KVZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 05:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966874AbWK2KVY
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 05:21:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:63454 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S966872AbWK2KVY (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 05:21:24 -0500
Received: (qmail invoked by alias); 29 Nov 2006 10:21:22 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp045) with SMTP; 29 Nov 2006 11:21:22 +0100
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 28 Nov 2006, Carl Worth wrote:

> On Sat, 25 Nov 2006 02:12:38 -0800, Junio C Hamano wrote:
> >  * The new "--depth $n" parameter to git clone/fetch tries to
> >    limit the commit ancestry depth to $n.
> [...]
> Has though been given to make the depth selection consistent with
> other limiting options for rev-parse and rev-list? For example, I'd
> like to be able to use --since to get a shallow clone, (so should
> --depth instead be --max-count?, and can we re-use some existing
> machinery here?).

I briefly considered that, but decided against it, for two reasons: 1) it 
puts the burden of calculation on the server, and 2) I was not at all sure 
if the whole shallow stuff would be useful to begin with (and therefore 
avoided complicated stuff as much as possible).

> >    Petr Baudis (1):
> >       Make git-clone --use-separate-remote the default
> ...
> >    Junio C Hamano (19):
> >       git-merge: make it usable as the first class UI
> 
> Also very exciting. Please do keep up the user-interface improvements, 
> everybody.

I concur.

Ciao,
Dscho
