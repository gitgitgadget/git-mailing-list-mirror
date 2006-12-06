X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Commit order in git.git, was Re: [RFC] Two conceptually distinct
 commit commands
Date: Wed, 6 Dec 2006 10:54:24 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612061052490.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87d56z32e1.wl%cworth@cworth.org> <7vejrdbzdb.fsf@assigned-by-dhcp.cox.net>
 <874ps91v79.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 6 Dec 2006 09:54:35 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <874ps91v79.wl%cworth@cworth.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33412>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrtTy-00078H-O2 for gcvg-git@gmane.org; Wed, 06 Dec
 2006 10:54:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760392AbWLFJy1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 04:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760396AbWLFJy1
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 04:54:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:47613 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1760392AbWLFJy0
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 04:54:26 -0500
Received: (qmail invoked by alias); 06 Dec 2006 09:54:25 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp042) with SMTP; 06 Dec 2006 10:54:25 +0100
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 5 Dec 2006, Carl Worth wrote:

> On Tue, 05 Dec 2006 17:13:20 -0800, Junio C Hamano wrote:
> > (This is offtopic)
> 
> It's an interesting topic nonetheless, so I'll comment anyway.
> 
> >  (1) one commit exposes, then another fixes.
> >  (2) one commit fixes, then another verifies the bug is no more.
> >  (3) one commit to include both.
> 
> I feel very strongly that I want (1) in the history.

Note that (1) maybe would reflect history better, but (2) and (3) are way 
nicer to bisecting.

I fell very strongly that I want (3) in the history.

(Though I am guilty of many instances of (2)...)

Ciao,
Dscho
