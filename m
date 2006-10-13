From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-fetch: Allow branch."branchname".remote=.
Date: Fri, 13 Oct 2006 13:27:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610131324090.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87y7rk3b9n.fsf@gmail.com>  <7vpscwd4ya.fsf@assigned-by-dhcp.cox.net>
 <8aa486160610130208s67ea0746o8a54910860b3fb78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 13:28:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYLCa-000691-JA
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 13:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWJML1Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 07:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWJML1Y
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 07:27:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:49601 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751341AbWJML1X (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Oct 2006 07:27:23 -0400
Received: (qmail invoked by alias); 13 Oct 2006 11:27:22 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp020) with SMTP; 13 Oct 2006 13:27:22 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Santi <sbejar@gmail.com>
In-Reply-To: <8aa486160610130208s67ea0746o8a54910860b3fb78@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28836>

Hi,

On Fri, 13 Oct 2006, Santi wrote:

> For example, in git.git you could have:
> 
> [branch "next"]
>   remote="."
>   merge=master
> 
> so the default merge in the next branch is the master branch in the
> local repository.

There is a subtle problem here. Up until now, "remote" meant a short cut. 
You either had a file with that name in .git/remotes/ or .git/branches, or 
an entry in the config (remote.<name>.url).

You use it differently here, designating the URL instead of the remote. 
I'd rather have it point to a real remote.

Ciao,
Dscho
