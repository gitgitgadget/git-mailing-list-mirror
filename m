From: fork0@t-online.de (Alex Riesen)
Subject: Re: [PATCH] sha1_name(): accept ':directory/' to get at the cache_tree
Date: Fri, 22 Dec 2006 09:44:25 +0100
Message-ID: <20061222084425.GA4644@steel.home>
References: <Pine.LNX.4.63.0612220318320.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Dec 22 09:44:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxg1L-0000aC-SZ
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 09:44:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945995AbWLVIot (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 03:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945990AbWLVIor
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 03:44:47 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:55818 "EHLO
	mailout08.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1945987AbWLVIoq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Dec 2006 03:44:46 -0500
Received: from fwd28.aul.t-online.de 
	by mailout08.sul.t-online.com with smtp 
	id 1Gxg1C-0005b3-04; Fri, 22 Dec 2006 09:44:42 +0100
Received: from tigra.home (bpeweBZYgezY8w9gWZLm2NDvlJyyJwlqgumaFtjru+yRbPesE6duUU@[84.163.127.243]) by fwd28.sul.t-online.de
	with esmtp id 1Gxg0v-1i9hb60; Fri, 22 Dec 2006 09:44:25 +0100
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 558AE277AF;
	Fri, 22 Dec 2006 09:44:25 +0100 (CET)
Received: from raa by steel.home with local (Exim 4.62 #1 (Debian))
	id 1Gxg0v-0001FR-5t; Fri, 22 Dec 2006 09:44:25 +0100
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612220318320.19693@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-ID: bpeweBZYgezY8w9gWZLm2NDvlJyyJwlqgumaFtjru+yRbPesE6duUU
X-TOI-MSGID: f7d0a1ae-f83e-4a6b-8211-9bd62e4acdf6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35150>

Johannes Schindelin, Fri, Dec 22, 2006 03:19:21 +0100:
> 
> If the cache tree is not up-to-date, it will be updated first. So, now
> 
> 	$ git show :Documentation/
> 
> will in effect show what files/directories are in the index' version
> of the directory Documentation. The three commands
> 
> 	$ git show :./
> 	$ git show :.
> 	$ git show :
> 
> are all equivalent and show the index' idea of the root directory.

That is a bit unexpected if you're not in the root directory of
repository, but in some subdir of the working directory.
Why root? Why not the current directory relative to root?
