From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-bundle: fix pack generation.
Date: Wed, 7 Mar 2007 05:05:40 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703070504140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45ECEB40.4000907@gmail.com> <7vejo2stlw.fsf@assigned-by-dhcp.cox.net>
 <45EE1242.8080405@gmail.com> <7vhcsxkb8n.fsf@assigned-by-dhcp.cox.net>
 <45EE2ECA.60403@gmail.com> <Pine.LNX.4.63.0703070419410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45EE36A1.30001@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 05:05:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOnPN-0004ym-KV
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 05:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161257AbXCGEFm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 23:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161259AbXCGEFm
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 23:05:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:54792 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161257AbXCGEFl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 23:05:41 -0500
Received: (qmail invoked by alias); 07 Mar 2007 04:05:40 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp043) with SMTP; 07 Mar 2007 05:05:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/dppg5A+jdZoCBnIVRC3VLCXRnQ7oj3fhgOcheMo
	+CC4YSGvGEXST2
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45EE36A1.30001@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41649>

Hi,

On Tue, 6 Mar 2007, Mark Levedahl wrote:

> Yes, setting GIT_EXEC_PATH fixed the problem, thanks.

Wonderful!

> I just tried git-bundle in a repository where I just committed 1 file, 
> the previous commit is several weeks old.
> 
> git-bundle create test.bdl HEAD --since=1.day.ago  ==>> pack with 1531
> objects

Did you test with "--since=1.day.ago HEAD", i.e. with the correct order? I 
know you'd like the options to be interminglable, but "HEAD" really is not 
an option, but an argument.

Hth,
Dscho
