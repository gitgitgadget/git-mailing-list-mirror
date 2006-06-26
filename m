From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/2] format-patch: use clear_commit_marks() instead of
 some adhocery
Date: Tue, 27 Jun 2006 00:39:42 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606270038200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0606250349280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
  <Pine.LNX.4.63.0606261728340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <46a038f90606261520k7df8cb3ci7a4a609644e0be12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net, martin@catalyst.net.nz
X-From: git-owner@vger.kernel.org Tue Jun 27 01:07:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fv0B1-0001Iv-R9
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 01:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWFZXH1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 19:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933272AbWFZXHZ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 19:07:25 -0400
Received: from mail.gmx.net ([213.165.64.21]:39064 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S933268AbWFZWjo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jun 2006 18:39:44 -0400
Received: (qmail invoked by alias); 26 Jun 2006 22:39:42 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 27 Jun 2006 00:39:42 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90606261520k7df8cb3ci7a4a609644e0be12@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22691>

Hi,

On Tue, 27 Jun 2006, Martin Langhoff wrote:

> And it errors out with ignore-if-in-upstream:
> 
>  $ ./git format-patch --ignore-if-in-upstream -o .patches origin master
>  fatal: Not a range.

Could you test with "origin..master" instead of "origin master"?

Thanks,
Dscho
