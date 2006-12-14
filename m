X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: What's in git.git (stable)
Date: Wed, 13 Dec 2006 22:32:52 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612132231050.18171@xanadu.home>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
 <200612132237.10051.andyparkins@gmail.com>
 <7vk60vbcfz.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612140113340.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 14 Dec 2006 03:33:34 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <Pine.LNX.4.63.0612140113340.3635@wbgn013.biozentrum.uni-wuerzburg.de>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34276>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuhLa-0000O6-ME for gcvg-git@gmane.org; Thu, 14 Dec
 2006 04:33:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750726AbWLNDcx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 22:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWLNDcx
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 22:32:53 -0500
Received: from relais.videotron.ca ([24.201.245.36]:44141 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1750726AbWLNDcx (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 22:32:53 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JA800LOHV6S5CE0@VL-MH-MR001.ip.videotron.ca> for git@vger.kernel.org; Wed,
 13 Dec 2006 22:32:52 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On Thu, 14 Dec 2006, Johannes Schindelin wrote:

> Hi,
> 
> On Wed, 13 Dec 2006, Junio C Hamano wrote:
> 
> > We might want to add a pair of built-in internal aliases though:
> > 
> > 	[alias]
> >         	cat = cat-file -p
> >                 less = -p cat-file -p
> > 
> > or have these as samples in template .git/config file.
> 
> I sent a patch which makes "git show" have that functionality, and 
> frankly, I disagree "less" would be a good name for it. It uses the 
> _pager_, which is not always "less", and besides, what it does is to show 
> that particular blob. So obviously, I think my patch is the best approach.

I think your approach is pretty sensible too.


