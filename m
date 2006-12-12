X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-pull from git.git - no remote ref for pu or next?
Date: Tue, 12 Dec 2006 14:07:04 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612121400530.18171@xanadu.home>
References: <863b7l83o9.fsf@blue.stonehenge.com>
 <86y7pd6oz7.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0612120949230.3535@woody.osdl.org>
 <Pine.LNX.4.63.0612121908100.2807@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0612121021270.3535@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Tue, 12 Dec 2006 19:07:13 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <Pine.LNX.4.64.0612121021270.3535@woody.osdl.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34129>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuCy7-00075I-Ea for gcvg-git@gmane.org; Tue, 12 Dec
 2006 20:07:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932290AbWLLTHH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 14:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWLLTHH
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 14:07:07 -0500
Received: from relais.videotron.ca ([24.201.245.36]:20431 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932290AbWLLTHF (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006
 14:07:05 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JA6008KHD3SXZ60@VL-MO-MR004.ip.videotron.ca> for git@vger.kernel.org; Tue,
 12 Dec 2006 14:07:04 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Tue, 12 Dec 2006, Linus Torvalds wrote:

> And kernel.org will probably start doing automatic repacking, since the 
> current situation just means that some people don't repack on their own, 
> and have tens of thousands of loose objects.

Maybe object sharing between repos could be a good idea too?  All kernel 
repos are likely to contain a large subset of your own so they could 
have a reference on it by default.  That would certainly allow for 
better caching and less IO on the server.


