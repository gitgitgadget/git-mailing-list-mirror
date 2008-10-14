From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG?] git remote rm repo nukes local refs for mirror repo
Date: Tue, 14 Oct 2008 11:32:13 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810141131130.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <48F460DB.9030209@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Oct 14 11:27:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpgAz-0001T5-IM
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 11:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754640AbYJNJZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 05:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754617AbYJNJZg
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 05:25:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:54912 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754515AbYJNJZf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 05:25:35 -0400
Received: (qmail invoked by alias); 14 Oct 2008 09:25:32 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp067) with SMTP; 14 Oct 2008 11:25:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1++H49U28O+S3QLoau8bSfXz+Yowkak7erdkfSKnj
	2nwvMQByfGRP52
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <48F460DB.9030209@drmicha.warpmail.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98176>

Hi,

On Tue, 14 Oct 2008, Michael J Gruber wrote:

> I just noticed the hard way that "git remote rm repo" nukes all local 
> (mirrored) refs if repo had been setup with "git remote add --mirror 
> repo url".
>
> Some may argue that this behaviour fits the description "deletes all 
> remote tracking branches" but I would claim it does not: mirrored 
> branches are not remote tracking branches in the proper sense.

Count me into the former group.  If you set up a "--mirror" repository, it 
defeats the purpose to mix that with _true_ local branches.

I'd color this a pilot error,
Dscho
