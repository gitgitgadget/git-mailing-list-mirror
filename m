X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-pull from git.git - no remote ref for pu or next?
Date: Tue, 12 Dec 2006 13:51:43 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612121345180.18171@xanadu.home>
References: <863b7l83o9.fsf@blue.stonehenge.com>
 <86y7pd6oz7.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0612120949230.3535@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Tue, 12 Dec 2006 18:51:54 +0000 (UTC)
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <Pine.LNX.4.64.0612120949230.3535@woody.osdl.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34124>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuCjI-0004Pf-BW for gcvg-git@gmane.org; Tue, 12 Dec
 2006 19:51:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932332AbWLLSvt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 13:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWLLSvt
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 13:51:49 -0500
Received: from relais.videotron.ca ([24.201.245.36]:58057 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932332AbWLLSvs (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006
 13:51:48 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JA600BSOCE7JL80@VL-MH-MR001.ip.videotron.ca> for git@vger.kernel.org; Tue,
 12 Dec 2006 13:51:44 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Tue, 12 Dec 2006, Linus Torvalds wrote:

> If the public sites used git itself to synchronize git repositories, 
> they'd never see anything like this (because git itself will only write 
> the new refs after it has actually updated the data). But since the thing 
> needs mirroring for non-git uses too, and since rsync generally _works_ 
> apart from the slight race-condition issue, that's what it just uses.

Wouldn't it be a worthy goal to exclude git repos from the rsync 
mirroring and use git instead?  The current arrangement doesn't put git 
in good light for the general public not reading this mailing list wrt 
git reliability, even if we know it is just a minor and temporary 
annoyance.

A failure always makes you look bad regardless of its severity.


