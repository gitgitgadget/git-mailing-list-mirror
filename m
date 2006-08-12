From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How to resolve git-am conflict (possible bug)
Date: Sat, 12 Aug 2006 11:52:54 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608121146550.10541@wbgn013.biozentrum.uni-wuerzburg.de>
References: <ebj7er$64j$1@sea.gmane.org> <7vslk2rbq8.fsf@assigned-by-dhcp.cox.net>
 <ebk5tf$31k$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 12 11:53:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBqBD-0004ZI-91
	for gcvg-git@gmane.org; Sat, 12 Aug 2006 11:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWHLJw5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Aug 2006 05:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbWHLJw5
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Aug 2006 05:52:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:3746 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932382AbWHLJw5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Aug 2006 05:52:57 -0400
Received: (qmail invoked by alias); 12 Aug 2006 09:52:55 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 12 Aug 2006 11:52:55 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ebk5tf$31k$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25258>

Hi,

On Sat, 12 Aug 2006, Jakub Narebski wrote:

> Why do we not record commit id in patch?

Because we do not have to.

There is a commit SHA1 which guarantees the integrity of the commit, and 
then you can generate the patch-id with

	$ git show $commit | git patch-id

> And how git-rebase deals with this? 

AFAICT by cherry-picking the commit, and if nothing changed in the index, 
just ignoring the patch.

Hth,
Dscho
