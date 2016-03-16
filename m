From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 18/19] index-helper: autorun
Date: Wed, 16 Mar 2016 19:27:56 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603161923380.4690@virtualbox>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>  <1457548582-28302-19-git-send-email-dturner@twopensource.com>  <CACsJy8CaWFhCzrH3imz+BRMTESSmyUB4jeAaYUDNk+Tmpj-VrQ@mail.gmail.com>  <alpine.DEB.2.20.1603151517590.4690@virtualbox>
 <1458151880.9385.1.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 19:28:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agGB3-0005dG-51
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 19:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935368AbcCPS2C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 14:28:02 -0400
Received: from mout.gmx.net ([212.227.17.22]:63707 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932618AbcCPS2A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 14:28:00 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MXUmw-1aLxd4436M-00WYZr; Wed, 16 Mar 2016 19:27:57
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1458151880.9385.1.camel@twopensource.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:W0JQOMZXtB7mPQ5qG3otoA/v3Tw8vO7G8OMxT35EZ26yL0ROmGN
 zfGJfxdB72Cajn6YtGWHGfSow1NXykh1ztP5iE4OP6vhtz6SpzGruZZpf1zHRd0hI3vw7oE
 hGlwhA6qoXBafU45W0m3JGQ5aJBidk6FbHmGbmKd9nUBjA0TURQfJGADVkXFrkK2O0rPejy
 rjUTPcnzwKAgRAeoWjllw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AACS90dZE7c=:KpQMz6fpSefPGGL/3IR50T
 YZ2Uy3n1xPeCXsY2bLJgTFyou6ZJd5r1O/TMva8sCvIAl4rUzMBKaRcyovg7zSpxLZIb6dV0N
 z60Q0II1KuHg/eWTq/djByFUrI5fo2j9YSrT94/LvgGTUMEhD6QrOj44LFeQZwoEb0ZVmIG4N
 P40CXfTpYKweXvOfxpQT2e2MQ8BHgV7pdlcoqWi0ieYKdLCCPyBifolTaY1FcvYiI4f4pafYG
 /sLSgDjkZEgogb+tFaIomL4Id4fiY55/HfaSQvgll86AaOPZKzK30F2D+5KxrI1b0+HP/JnIw
 k/DmjhPbfDrp4SjH73ZH0qSb1FW7U4vc/CeRZ/A8faXP+ASJH4IyWpee4V//SvUpU5Ai2UAcm
 k/VJr6cF6ayR2Dl5NPvmblMD+3l628MuAv3OjGit+aKqlqEVqWM4pRV4qmTdxK+4AkpTJrtJA
 5PO33Dq1/6XDrU3g4A7mxG+I0ML9UvJa0+U3cai2eQ5vn6LYvGIcLb1kVXpLr6iqjz4+WFSJv
 zvifI1RnyY4xQ0s8pzylseHN884xFCQ0UEKgpac2VgiQK+CGUNRFC+NsAxMxILQWeb3U65Ax5
 PtyDH91HZfnDzAp/Q0jsF0bXYUm0qg/Ok+16jbd60kU/TPT1Vk1ymjGgci/+YKBAA5jXwCp10
 1xPD1XpO21kKzmYyL5h5MRWsgBnU4lOJOblGN2tdn0uIdUCjqvaTcYNhCLJMcB5HxDUEYVN5W
 rOoxhiL4GN/I5cUCDg7qX+DN/RpGIZIYAtDM9wRgAT7qtdFhX6KPVGh902cljRYe5MUKOKHe 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289014>

Hi David,

On Wed, 16 Mar 2016, David Turner wrote:

> I don't understand what a "detached process" is on Windows (I have never
> done any real Windows programming). Does that mean "call daemonize() and
> it'll take care of it?"  Or something else?  Or should I just not worry
> about it and let you take care of it?

Every process is detached by default, when created via CreateProcess().
There is no fork() followed by a daemonize(). If you want to wait for a
process to finish, you have to wait for it explicitly.

But yeah, why don't you let me worry about this?

I am much more concerned about concurrent accesses and the communication
between the Git processes and the index-helper. Writing to the .pid file
sounds very fragile to me, in particular when multiple processes can poke
the index-helper in succession and some readers are unaware that the index
is being refreshed.

This is just a quick note, and I should go into more detail, also about
the topic branch my colleague Jeff Hostetler and I are working on, that is
similar in spirit but wants to use a home-rolled alternative to watchman.
I will go into more detail, but that will have to wait for tomorrow, as I
need to log off for the day.

Ciao,
Dscho
