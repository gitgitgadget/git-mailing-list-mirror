From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: git refuses to switch to older branches
Date: Sun, 20 Aug 2006 21:11:33 +0200
Message-ID: <200608202111.33470.Josef.Weidendorfer@gmx.de>
References: <20060819202558.GE30022@admingilde.org> <20060820122128.GG30022@admingilde.org> <Pine.LNX.4.63.0608201447470.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Aug 20 21:11:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEsi3-0006ro-Ea
	for gcvg-git@gmane.org; Sun, 20 Aug 2006 21:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWHTTLh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Aug 2006 15:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWHTTLh
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Aug 2006 15:11:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:43988 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751157AbWHTTLg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Aug 2006 15:11:36 -0400
Received: (qmail invoked by alias); 20 Aug 2006 19:11:35 -0000
Received: from p5496A45F.dip0.t-ipconnect.de (EHLO noname) [84.150.164.95]
  by mail.gmx.net (mp034) with SMTP; 20 Aug 2006 21:11:35 +0200
X-Authenticated: #352111
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0608201447470.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25766>

On Sunday 20 August 2006 14:48, you wrote:
> Not necessarily. Sometimes you have files in your working directory, which 
> are not in your repository, you know?

Yet, I think it is quite inconvenient the way it is now. The same happens if
you track a generated file by accident, and remove it later from tracking.

The real problem is that there are two reasons to put a file into .gitignore:
You do not want to have it tracked and polluting git-status because
(1) it is temporary and generated
(2) it is private and not supposed to be in the repository

To distinguish these cases, we could introduce a per-repository configuration
file .git/nevertouch . Comments?

Josef
