From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Fri, 30 Jan 2009 20:03:22 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901301959300.3586@pacific.mpi-cbg.de>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de>  <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de>  <76718490901300817x3f31460k59b6fe75d136372d@mail.gmail.com>  <alpine.DEB.1.00.0901301756560.3586@pacific.mpi-cbg.de>
 <76718490901301050h1f0f5b2bq902de384d954d99b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 20:04:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSyfB-0004xM-Ez
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 20:04:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906AbZA3TC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 14:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752640AbZA3TC7
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 14:02:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:52354 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751618AbZA3TC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 14:02:58 -0500
Received: (qmail invoked by alias); 30 Jan 2009 19:02:56 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp051) with SMTP; 30 Jan 2009 20:02:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18nqhcDP2wnkgSeb1V6nGnIiZ8y9pKJrSg6Q45baf
	qEYJKbN/plvGog
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <76718490901301050h1f0f5b2bq902de384d954d99b@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107864>

Hi,

On Fri, 30 Jan 2009, Jay Soffian wrote:

> On Fri, Jan 30, 2009 at 12:01 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > As Peff commented, this would be horribly wrong if the remote has a 
> > different "origin" remote.  Not forcing the push does not help either, 
> > it is still wrong.
> 
> Got it. Here was my impression of the work-flow we're trying to help 
> beginners with:
> 
> machineA$ mkdir repo
> machineA$ cd repo
> machineA$ git init
> machineA$ add, commit, add, commit...
> 
> machineB$ git clone ssh://machine1/repo
> machineB$ add, commit, add, commit...
> machineB$ git push
> 
> (And if my impression is wrong, then stop me right here and I'll
> shut-up on this thread.)

I think your impression is not wrong.

BUT.

You cannot just cater for one workflow and fsck the other workflows over.

You'll have to devise a method that helps the workflow you are interested 
in, but leaves the others alone.

Example: the thing I heard most often was "I want to start this 
repository, but there is nothing in there yet, yet I want other people to 
clone it already so they'll see something when I do."

I admit, it does not strike me sensible, but so does cloning an empty 
repository.  As I could not understand how people would want to vote for 
Bush.  Yet they did, so I guess I'll have to live with it.

Ciao,
Dscho
