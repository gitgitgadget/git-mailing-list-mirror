From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [MinGW PATCH] git clone was failing with 'invalid object name
 HEAD' if ran from cmd.exe directly
Date: Mon, 6 Aug 2007 22:56:26 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708062255420.14781@racer.site>
References: <BD28FA320B7749FFBE3135FE92380BCE@ntdev.corp.microsoft.com> 
 <Pine.LNX.4.64.0708061134380.14781@racer.site>
 <a1bbc6950708061455v459182cei3fb6b3b518d4b176@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 23:57:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIAZZ-0008Ry-IJ
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 23:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758100AbXHFV5I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 17:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757554AbXHFV5G
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 17:57:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:37803 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754263AbXHFV5F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 17:57:05 -0400
Received: (qmail invoked by alias); 06 Aug 2007 21:57:02 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp010) with SMTP; 06 Aug 2007 23:57:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/HrslGZT3HRrWwsJGAlov5cwUaOqiZRIkgKJN4Dq
	HYqWQ6vWAdzHrb
X-X-Sender: gene099@racer.site
In-Reply-To: <a1bbc6950708061455v459182cei3fb6b3b518d4b176@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55175>

Hi,

On Mon, 6 Aug 2007, Dmitry Kakurin wrote:

> On 8/6/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > I had more problems than I thought with setting up a fork of mingw.git.
> > It seems that the relative alternates path to mingw.git is followed, but
> > not that one from mingw.git to git.git.  So I could upload, but not fetch.
> 
> Does it mean that fork of a fork does not work on repo.or.cz?

Yes, at the moment it does not work.  Therefore I set up 
git/mingw4msysgit.git, for the time being.

Ciao,
Dscho
