From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: Git push error
Date: Sun, 18 May 2008 10:09:20 +0200
Message-ID: <20080518080920.GA3670@xp.machine.xx>
References: <8345bd80805180030l23f0412du6bd4361450544f92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marcus <prima@wordit.com>
X-From: git-owner@vger.kernel.org Sun May 18 10:10:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jxdyc-0007sl-9q
	for gcvg-git-2@gmane.org; Sun, 18 May 2008 10:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321AbYERIJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2008 04:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751894AbYERIJZ
	(ORCPT <rfc822;git-outgoing>); Sun, 18 May 2008 04:09:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:44782 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751874AbYERIJX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2008 04:09:23 -0400
Received: (qmail invoked by alias); 18 May 2008 08:09:21 -0000
Received: from e176252152.adsl.alicedsl.de (EHLO localhost) [85.176.252.152]
  by mail.gmx.net (mp008) with SMTP; 18 May 2008 10:09:21 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX19hIB8thHphyHldX6MCmXVyUJ5UFxjxAy82PTKVoY
	04lqve2ahi4xLR
Content-Disposition: inline
In-Reply-To: <8345bd80805180030l23f0412du6bd4361450544f92@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82379>

On Sun, May 18, 2008 at 08:30:36AM +0100, Marcus wrote:
> Can anybody tell me what the following error means?
> 
> -----------------
> sh-3.00# git push ssh://me@git.domain.org/gitroot/project/projectmain.git master
> Password:
> fatal: exec pack-objects failed.
> Broken pipe
> -------------------
> 

You don't have git (especially git-pack-objects) in your path on the
remote end. Try

	ssh me@git.domain.org git --version

to see if your $PATH isn't setup correctly on ssh logins.

-Peter
