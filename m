From: Mark Burton <markb@ordern.com>
Subject: Re: Git commit won't add an untracked file given on the command
 line
Date: Wed, 19 Nov 2008 09:54:52 +0000
Organization: Order N Ltd.
Message-ID: <20081119095452.3018d2de@crow>
References: <20081118211237.234d8035@crow>
	<200811182227.20076.fge@one2team.com>
	<20081118214730.005fc72d@crow>
	<alpine.DEB.1.00.0811190206170.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 19 10:56:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2jnG-0002B8-Js
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 10:56:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517AbYKSJzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 04:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752511AbYKSJzD
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 04:55:03 -0500
Received: from c2beaomr01.btconnect.com ([213.123.26.179]:20053 "EHLO
	c2beaomr01.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477AbYKSJzC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 04:55:02 -0500
Received: from crow.ordern.com (host86-128-20-200.range86-128.btcentralplus.com [86.128.20.200])
	by c2beaomr01.btconnect.com (MOS 3.8.6-GA)
	with ESMTP id CGL03920;
	Wed, 19 Nov 2008 09:54:53 GMT
Received: from crow (localhost [127.0.0.1])
	by crow.ordern.com (Postfix) with ESMTP id B3FDD190C96;
	Wed, 19 Nov 2008 09:54:52 +0000 (GMT)
In-Reply-To: <alpine.DEB.1.00.0811190206170.30769@pacific.mpi-cbg.de>
X-Mailer: Claws Mail 3.6.1 (GTK+ 2.12.9; x86_64-pc-linux-gnu)
X-Junkmail-Status: score=10/50, host=c2beaomr01.btconnect.com
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A090207.4923E273.0038,ss=1,fgs=0,
	ip=86.128.20.200,
	so=2007-10-30 19:00:17,
	dmn=5.7.1/2008-09-02
X-Junkmail-IWF: false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101321>


Hi,

> It may be a traditional wart, but a helpful one.  Remember, you can also 
> say:
> 
> 	git commit that/directory/
> 
> I do _not_ want Git to add all untracked (and unignored) files in that 
> directory automatically.

Yes, I can see the wisdom in not automatically adding the contents of a
directory specified on the command line. So that's probably the answer
to my original question.

As for "knowing what the staging area is about", I use the staging
area almost all the time as I consider it one of git's major
improvements over "traditional" SCM systems. I especially like how I
can use tools like git gui to browse and select the changes to be
staged for the next commit.

Having said that, I still like the concept of being able to add named
files without touching the index.

Feature request for the git gui people:

  It would be nice if git gui was able to stage a highlighted region
  rather than either the whole hunk or just the line under the cursor
  as I believe it behaves now. I might be wrong but I don't think it
  can do that at the moment. I think that would be useful because
  although it's a step forward to be able to stage individual lines in
  a hunk, it can be laborious if you want to pick out more than just a
  couple of lines.

Cheers,

Mark
