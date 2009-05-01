From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Permissions of objects within shared repo
Date: Fri, 1 May 2009 15:01:16 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905011500530.10279@pacific.mpi-cbg.de>
References: <799406d60904301849t1e77e81bgc6d58ecd0e9d6b7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?UTF-8?B?R0lU77u/77u/77u/77u/?= <git@vger.kernel.org>
To: Adam Mercer <ramercer@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 01 15:01:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzsN3-0008TF-1o
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 15:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179AbZEANA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 09:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753232AbZEANA5
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 09:00:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:47015 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754179AbZEANA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 09:00:56 -0400
Received: (qmail invoked by alias); 01 May 2009 13:00:54 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp044) with SMTP; 01 May 2009 15:00:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/66il2nQj6qv8AJlG3CyItCeLap7R1TbaFdKdqWq
	MlIMc8i8hjtfLz
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <799406d60904301849t1e77e81bgc6d58ecd0e9d6b7d@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118077>

Hi,

On Thu, 30 Apr 2009, Adam Mercer wrote:

> We have a shared repository with the following config:
> 
> [core]
>         repositoryformatversion = 0
>         filemode = true
>         bare = true
>         sharedrepository = 1
> [receive]
>         denyNonFastforwards = true
> 
> Users push their commits to the repository over ssh, all users are in
> group 1000 and so far everything seems to be working OK. However I
> have noticed that something seems to be strange with the permissions
> of the objects, e.g.:
> 
> [ram@g3 ~]$ cd /path/to/repo.git/objects/00/
> [ram@g3 00]$ ls -l
> total 43
> -r--r--r--+ 1 user1           1000  2729 Apr 19 13:13
> 028ade623678384fca34c51e0ea3ae91b8a50d

Objects are immutable.  So they do not need to be writable at all.

Hth,
Dscho
