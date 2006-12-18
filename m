X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] fetch-pack: avoid fixing thin packs when unnecessary
Date: Mon, 18 Dec 2006 17:17:55 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612181713110.18171@xanadu.home>
References: <86y7p57y05.fsf@blue.stonehenge.com>
 <Pine.LNX.4.63.0612182154170.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0612182213020.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0612181638220.18171@xanadu.home>
 <Pine.LNX.4.63.0612182251210.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Mon, 18 Dec 2006 22:18:12 +0000 (UTC)
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <Pine.LNX.4.63.0612182251210.19693@wbgn013.biozentrum.uni-wuerzburg.de>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34744>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwQo3-00041i-Um for gcvg-git@gmane.org; Mon, 18 Dec
 2006 23:18:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754634AbWLRWR5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 17:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754636AbWLRWR5
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 17:17:57 -0500
Received: from relais.videotron.ca ([24.201.245.36]:65124 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1754634AbWLRWR4 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 17:17:56 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JAH00E1TPXVB7P0@VL-MH-MR001.ip.videotron.ca> for git@vger.kernel.org; Mon,
 18 Dec 2006 17:17:55 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On Mon, 18 Dec 2006, Johannes Schindelin wrote:

> Hi,
> 
> On Mon, 18 Dec 2006, Nicolas Pitre wrote:
> 
> > On Mon, 18 Dec 2006, Johannes Schindelin wrote:
> > 
> > > 	... and here is a lightly tested fix.
> > 
> > NAK.
> > 
> > This fixes nothing.  See previous message.
> 
> You're completely right. My patch does what I say, but it does not fix the 
> problem.

Your patch is also unnecessary.  For use_thin_pack to be true, you must 
provide --thin to git-fetch-pack which is not the case when cloning.


