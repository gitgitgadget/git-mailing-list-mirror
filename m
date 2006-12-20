X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: What's in git.git (stable), and Announcing GIT 1.4.4.3
Date: Wed, 20 Dec 2006 17:19:46 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612201716270.18171@xanadu.home>
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
 <86vek6z0k2.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 20 Dec 2006 22:19:56 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <86vek6z0k2.fsf@blue.stonehenge.com>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34970>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx9mz-0002L5-SW for gcvg-git@gmane.org; Wed, 20 Dec
 2006 23:19:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030379AbWLTWTu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 17:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030382AbWLTWTt
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 17:19:49 -0500
Received: from relais.videotron.ca ([24.201.245.36]:65389 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1030379AbWLTWTr (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 17:19:47 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JAL00MQNFCY8VF0@VL-MH-MR001.ip.videotron.ca>; Wed, 20 Dec 2006 17:19:46
 -0500 (EST)
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Sender: git-owner@vger.kernel.org

On Wed, 20 Dec 2006, Randal L. Schwartz wrote:

> >>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:
> 
> Junio> * The 'master' branch has these since the last announcement.
> Junio>   They are NOT in 1.4.4.3.
> 
> Junio>       index-pack usage of mmap() is unacceptably slower on many OSes
> Junio>          other than Linux
> 
> Is this really in master?  I'm still seeing one-hour times on
> my Mac, using 8336afa563fbeff35e531396273065161181f04c.

It is in current master, but not in 8336afa563fbeff35e5313...

To be sure you have it just open index-pack.c and make sure "mmap" is 
not found there anymore.


