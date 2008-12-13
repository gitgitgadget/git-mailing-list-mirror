From: Resul Cetin <Resul-Cetin@gmx.net>
Subject: Re: Optimizing cloning of a high object count repository
Date: Sat, 13 Dec 2008 17:14:04 +0100
Message-ID: <200812131714.05472.Resul-Cetin@gmx.net>
References: <200812131624.57618.Resul-Cetin@gmx.net> <fcaeb9bf0812130746l38a12f37wde26f31d5fa0d2a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>, gentoo-scm@gentoo.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 13 17:15:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBX9e-0001QG-5P
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 17:15:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbYLMQO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 11:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbYLMQO2
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 11:14:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:54143 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750741AbYLMQO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 11:14:28 -0500
Received: (qmail invoked by alias); 13 Dec 2008 16:14:24 -0000
Received: from i59F6A60F.versanet.de (EHLO rowo) [89.246.166.15]
  by mail.gmx.net (mp047) with SMTP; 13 Dec 2008 17:14:24 +0100
X-Authenticated: #13824512
X-Provags-ID: V01U2FsdGVkX1/rSV9Dv5brXWtV6ffQaJlco3LBLyaemij7evBf3k
	lJJYdwcopSTvsr
User-Agent: KMail/1.10.3 (Linux/2.6.26-1-amd64; KDE/4.1.3; x86_64; ; )
In-Reply-To: <fcaeb9bf0812130746l38a12f37wde26f31d5fa0d2a2@mail.gmail.com>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103003>

On Saturday 13 December 2008 16:46:50 you wrote:
[...]
> >  The size of the linux repository seems to be smaller but in the same
> > range object count and repository size but clones are much much faster.
> > Is there any way to optimize the server operations like counting and
> > compressing of objects to get the same speed as we get from
> > git.kernel.org (which does it in nearly no time and the only limiting
> > factor seems to be my bandwith)?
> >  The only other information I have is that Robin H. Johnson made a single
> >  ~910MiB pack for the whole repository.
>
> Make yearly packed repository snapshots and publish them via http.
> People can wget the latest snapshot, then pull updates later.
That would be a workaround but it doesn't explain why git.kernel.org deliveres 
torvalds repository without any notable counting and compressing time. Maybe 
it has something todo with the config I found inside the repository:
http://git.overlays.gentoo.org/gitroot/exp/gentoo-x86.git/config
It says that it isnt a bare repository.
Before I forget. I was wrong that it is a single 910mb file. Somebody seems to 
have repacked it into 7 single packs.

Regards,
	Resul
