From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] git-publish
Date: Sun, 13 Aug 2006 20:20:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608132017090.10541@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0608131158500.9789@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 13 20:21:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCKZw-00008k-B4
	for gcvg-git@gmane.org; Sun, 13 Aug 2006 20:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWHMSUq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Aug 2006 14:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbWHMSUq
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Aug 2006 14:20:46 -0400
Received: from mail.gmx.de ([213.165.64.20]:12471 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750703AbWHMSUq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Aug 2006 14:20:46 -0400
Received: (qmail invoked by alias); 13 Aug 2006 18:20:44 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 13 Aug 2006 20:20:44 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0608131158500.9789@iabervon.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25288>

Hi,

On Sun, 13 Aug 2006, Daniel Barkalow wrote:

> Like how "pull" is "fetch" + "merge", I think it would be useful to have 
> a "commit" + "push".

I found myself the other day, looking for files I committed on a box which 
was 280 kilometer away, where I forgot to push. So I understand your 
feeling.

However, adding to Junio's arguments, I find it saner to keep them 
separated: you should commit _often_. Way more often than you would need 
to push. There are many reasons, why small patches are more beautiful than 
big ones, and git actually encourages you to make small patches.

I'd rather have a command which tells me if I have commits after the last 
time I pushed.

Ciao,
Dscho
