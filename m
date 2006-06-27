From: fork0@t-online.de (Alex Riesen)
Subject: Re: CFT: merge-recursive in C
Date: Tue, 27 Jun 2006 02:24:39 +0200
Message-ID: <20060627002439.GD3121@steel.home>
References: <20060626233838.GA3121@steel.home> <Pine.LNX.4.64.0606261652350.3927@g5.osdl.org> <Pine.LNX.4.64.0606261704390.3927@g5.osdl.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Tue Jun 27 02:25:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fv1Ny-0004Nr-Hs
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 02:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbWF0AYz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 20:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbWF0AYz
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 20:24:55 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:15538 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1030249AbWF0AYy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jun 2006 20:24:54 -0400
Received: from fwd35.aul.t-online.de 
	by mailout06.sul.t-online.com with smtp 
	id 1Fv1Nl-0001pw-00; Tue, 27 Jun 2006 02:24:45 +0200
Received: from tigra.home (V+Og56Zdoe7aj+52KCeHJHnbHYvZnG1sqlihCshOVaWDagBm72jbr6@[84.160.112.192]) by fwd35.sul.t-online.de
	with esmtp id 1Fv1Ng-14FgZs0; Tue, 27 Jun 2006 02:24:40 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 7E983277B5;
	Tue, 27 Jun 2006 02:24:39 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1Fv1Nf-0000ze-As; Tue, 27 Jun 2006 02:24:39 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606261704390.3927@g5.osdl.org>
User-Agent: Mutt/1.5.6i
X-ID: V+Og56Zdoe7aj+52KCeHJHnbHYvZnG1sqlihCshOVaWDagBm72jbr6
X-TOI-MSGID: 7b7ad865-59a3-482b-9b90-406147068bda
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22701>

Linus Torvalds, Tue, Jun 27, 2006 02:07:02 +0200:
> > 
> > git-diff-tree is one of the simplest git operations. We've got absolutely 
> > _tons_ of infrastructure in place to do it efficiently, since it's done 
> > all over the map (a "git-rev-list" with path limiting will do a diff-tree 
> > against all the commits).
> 
> Side note - I think merge-recursive could/should be rewritten to use 
> "git-merge-tree" instead of "git-read-tree -u -m". I suspect that the 
> git-merge-tree output is in fact a lot closer to what git-merge-recursive 
> actually wants to have.
> 

Yep. And does not touch the index, too. Cool...
