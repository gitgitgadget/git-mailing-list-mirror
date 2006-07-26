From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] t7001: add test for git-mv dir1 dir2/
Date: Wed, 26 Jul 2006 20:47:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607262047160.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607261940090.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <9e4733910607261050k5f8d8d5dke5ded3a806b46f21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Jul 26 20:47:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5oPz-0001jq-Dk
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 20:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWGZSrg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 14:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWGZSrg
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 14:47:36 -0400
Received: from mail.gmx.de ([213.165.64.21]:24257 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751101AbWGZSrg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jul 2006 14:47:36 -0400
Received: (qmail invoked by alias); 26 Jul 2006 18:47:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 26 Jul 2006 20:47:34 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910607261050k5f8d8d5dke5ded3a806b46f21@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24236>

Hi,

On Wed, 26 Jul 2006, Jon Smirl wrote:

> An exact test case:
> 
> git clone git foo
> git clone git foo1
> cd foo
> mkdir zzz
> git mv gitweb zzz
> cg diff >patch
> cd ../foo1
> cg patch <../foo/patch
> 
> This patch won't apply because zzz does not exist in foo1

Okay, I got it wrong, then. Thanks for the clarification!

Ciao,
Dscho
