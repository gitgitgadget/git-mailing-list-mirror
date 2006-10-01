From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Multiple checkouts of the same repository
Date: Sun, 1 Oct 2006 21:08:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610012105590.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <3bbc18d20610011203p40d631b7o3bd2c6971a2bfcca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 01 21:08:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GU6g5-0005Hc-F9
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 21:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWJATIh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 15:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWJATIh
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 15:08:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:15318 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932215AbWJATIg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Oct 2006 15:08:36 -0400
Received: (qmail invoked by alias); 01 Oct 2006 19:08:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp014) with SMTP; 01 Oct 2006 21:08:34 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Matt McCutchen <hashproduct+git@gmail.com>
In-Reply-To: <3bbc18d20610011203p40d631b7o3bd2c6971a2bfcca@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28191>

Hi,

On Sun, 1 Oct 2006, Matt McCutchen wrote:

> Maybe this is common knowledge, but I thought I should mention it in
> case it isn't.  I had a git repository in a directory A and I wanted
> to check out a branch of the repository to a different directory B.
> So I created B/.git and filled it with symlinks pointing to the files
> in A/.git, except for index and HEAD because those need to be
> different for each checkout;

A better method is to use a local clone:

	git-clone --local --shared A  B

Such a clone will be very fast, and cheap, because it sets up links (not 
just symbolic links, but links that git understands).

Hth,
Dscho
