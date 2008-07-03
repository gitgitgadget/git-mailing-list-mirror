From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: finding deleted file names
Date: Thu, 3 Jul 2008 12:57:22 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807031255230.9925@racer>
References: <93c3eada0807021701m13b7adddv51537f4cf9d52533@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 14:02:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KENVi-0003wv-W9
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 14:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755305AbYGCL7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 07:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755295AbYGCL7S
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 07:59:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:55164 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755273AbYGCL7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 07:59:16 -0400
Received: (qmail invoked by alias); 03 Jul 2008 11:59:14 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp022) with SMTP; 03 Jul 2008 13:59:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18CLBMnmXcCBPLVNgG6SdAc22+GKk6prtZiD9eMPP
	MOTBce1yq3VteO
X-X-Sender: gene099@racer
In-Reply-To: <93c3eada0807021701m13b7adddv51537f4cf9d52533@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87266>

Hi,

On Thu, 3 Jul 2008, Geoff Russell wrote:

> git diff --diff-filter=D --name-only HEAD@{'7 days ago'}
> 
> finds files deleted during the last 7 days, but if my repository is
> only 6 days old I get a
> fatal error.
> 
> fatal: bad object HEAD@{7 days ago}

Sorry, but you haven't grasped the concept of reflogs.  The "@{...}" is 
purely for the _local_ state.

So clearly, if you did not have the repo 7 days ago, "HEAD@{7.days.ago}" 
does not exist.

In a distributed SCM, asking about a branch's state "7 days ago" is 
ill-defined at best.

Hth,
Dscho
