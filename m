From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Commit-ish shortcut for immediate parent range
Date: Sun, 22 Oct 2006 22:55:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610222254210.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200610221548.42048.andyparkins@gmail.com>
 <Pine.LNX.4.64.0610221017180.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 22:56:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbkMT-00055O-6u
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 22:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWJVUz6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 16:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbWJVUz6
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 16:55:58 -0400
Received: from mail.gmx.de ([213.165.64.20]:25823 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750893AbWJVUz5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Oct 2006 16:55:57 -0400
Received: (qmail invoked by alias); 22 Oct 2006 20:55:56 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 22 Oct 2006 22:55:56 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610221017180.3962@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29790>

Hi,

On Sun, 22 Oct 2006, Linus Torvalds wrote:

> Anyway, there's two kinds of commands wrt revision ranges in git:
> 
>  - "git diff"
>  - everything else

Well, there is also "git format-patch". If you provide it with only one 
commit-ish "<rev>", it will believe you actually meant "<rev>..".

Ciao,
Dscho
