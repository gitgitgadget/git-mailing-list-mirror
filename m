From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-log output changed from 1.4.0 -> 1.4.1?
Date: Thu, 6 Jul 2006 23:56:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607062355390.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <761519800607061451n9473ad4oa9e2781517ca9389@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 06 23:56:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fybpv-00048J-J9
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 23:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWGFV4h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 17:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWGFV4g
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 17:56:36 -0400
Received: from mail.gmx.net ([213.165.64.21]:9126 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750786AbWGFV4g (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jul 2006 17:56:36 -0400
Received: (qmail invoked by alias); 06 Jul 2006 21:56:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 06 Jul 2006 23:56:34 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Robin Luckey <robinluckey@gmail.com>
In-Reply-To: <761519800607061451n9473ad4oa9e2781517ca9389@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23405>

Hi,

On Thu, 6 Jul 2006, Robin Luckey wrote:

> In git 1.4.0, the following command...
> 
> git log -r --root --abbrev=40 master
> 
> ...would generate log entries like this...
> 
> commit 8db998464a3cc7f41728ac8bb59aee0f62e14aa8
> Author: someone <someone>
> Date:   Sun Aug 29 09:44:49 2004 +0000
> 
>    A comment goes here.
> 
> :100755 000000 56f5eb6c914c7ff6706dc3f8736a77d155cad93f
> 0000000000000000000000000000000000000000 D someapp/file1.c
> :100755 000000 d7e0277fe15bfc11f75cbc535ecf1c5ee3d79baf
> 0000000000000000000000000000000000000000 D someapp/file2.c
> 
> Is there a way to generate this same format with git 1.4.1?

I do not know about git 1.4.1, but with 'next' you can just add '--raw' to 
the command line, and it works.

Hth,
Dscho
