X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-fetch fails with error code 128
Date: Thu, 14 Dec 2006 21:31:47 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612142128430.18171@xanadu.home>
References: <200612142325.kBENPF1u001043@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 15 Dec 2006 02:31:53 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <200612142325.kBENPF1u001043@laptop13.inf.utfsm.cl>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34464>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv2rX-0003bN-Th for gcvg-git@gmane.org; Fri, 15 Dec
 2006 03:31:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965026AbWLOCbs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 21:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbWLOCbs
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 21:31:48 -0500
Received: from relais.videotron.ca ([24.201.245.36]:56809 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S965026AbWLOCbs (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 21:31:48 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JAA005GLN0ZLPB0@VL-MH-MR001.ip.videotron.ca> for git@vger.kernel.org; Thu,
 14 Dec 2006 21:31:47 -0500 (EST)
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Sender: git-owner@vger.kernel.org

On Thu, 14 Dec 2006, Horst H. von Brand wrote:

> > Unpacking 186566 objects
> > fatal: failed to apply delta
> > fatal: unpack-objects died with error code 128
> > Fetch failure: /home/andyp/projects/temp/.git
> 
> Happened to me yesterday or so pulling the vanilla kernel (big push shortly
> before 2.6.20-rc1). Trying again somewhat later went through flawlessly.
> Might have been git running out of memory.

This is a very possible cause, especially if both processes 
(pack-objects and unpack-objects) are running at the same time on the 
same machine.


