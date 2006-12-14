X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] "master" should be treated no differently from any other
 branch
Date: Thu, 14 Dec 2006 13:22:26 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612141321110.18171@xanadu.home>
References: <200612141519.44294.andyparkins@gmail.com>
 <Pine.LNX.4.63.0612141627090.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <4581721B.4050102@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 14 Dec 2006 18:22:48 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <4581721B.4050102@xs4all.nl>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34381>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuvE4-0000b9-H1 for gcvg-git@gmane.org; Thu, 14 Dec
 2006 19:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751972AbWLNSWd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 13:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751971AbWLNSWd
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 13:22:33 -0500
Received: from relais.videotron.ca ([24.201.245.36]:45119 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751969AbWLNSWc (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 13:22:32 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JAA008TR0DFUDG0@VL-MH-MR002.ip.videotron.ca> for git@vger.kernel.org; Thu,
 14 Dec 2006 13:22:30 -0500 (EST)
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org

On Thu, 14 Dec 2006, Han-Wen Nienhuys wrote:

> Johannes Schindelin escreveu:
> > Hi,
> > 
> > On Thu, 14 Dec 2006, Andy Parkins wrote:
> > 
> >> "master" shouldn't get special treatment; making different log messages 
> >> based on the name of the branch is bad form.  What if a user likes 
> >> "my/master" or "my/head" as their master branch?
> > 
> > I do not agree. There is usually a principal branch, where you collect the 
> > topics, and you do want to treat that special. As for the name: better 
> > have a convention here than configurability. You would not want "git" to 
> > be called "guitar" for some users, just because they happen to like that 
> > name more, either, right?
> 
> Disagree: I have two principal branches, master and stable/2.10.  I don't see
> why the latter should get different commit messages.

I also agree to disagree.  "master" is maybe the default branch, but it 
is not so special to deserve a different message than any other branch.


