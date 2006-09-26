From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Notes on Using Git with Subprojects
Date: Wed, 27 Sep 2006 00:13:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609270009400.25371@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45196628.9010107@gmail.com>
 <Pine.LNX.4.63.0609262203510.25371@wbgn013.biozentrum.uni-wuerzburg.de>
 <4519A321.4010507@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 00:13:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSLAu-0005Z6-Q3
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 00:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWIZWNI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 18:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbWIZWNI
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 18:13:08 -0400
Received: from mail.gmx.de ([213.165.64.20]:11963 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964866AbWIZWNH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Sep 2006 18:13:07 -0400
Received: (qmail invoked by alias); 26 Sep 2006 22:13:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 27 Sep 2006 00:13:05 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: A Large Angry SCM <gitzilla@gmail.com>
In-Reply-To: <4519A321.4010507@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27830>

Hi,

On Tue, 26 Sep 2006, A Large Angry SCM wrote:

> How the state (subproject list, branch names, etc.) is recorded in a 
> parent project is only important to the parent project. The parent 
> project must also know how to interact with with each of its 
> subprojects.

Granted, if you mix VCSes, this is most pragmatic.

But it is also wrong: The whole point in bundling the subprojects together 
is (IMHO) to get the benefits of a VCS for the root project, i.e. for the 
combined states of the subprojects. After all, you want to say "I know 
that this collection of projects at these states compiled and worked 
fine."

And if you let a build system handle the stitching of the subprojects, you 
completely lose these benefits.

Ciao,
Dscho
