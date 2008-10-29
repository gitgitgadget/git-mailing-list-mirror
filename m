From: Nicolas Pitre <nico@cam.org>
Subject: Re: Pull request for sub-tree merge into /contrib/gitstats
Date: Wed, 29 Oct 2008 19:31:29 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810291922320.13034@xanadu.home>
References: <bd6139dc0810291606o2efe4254me378335b76861340@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailinglist <git@vger.kernel.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Thu Oct 30 00:33:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvKXD-0004c6-4J
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 00:33:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754467AbYJ2Xby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 19:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754452AbYJ2Xby
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 19:31:54 -0400
Received: from relais.videotron.ca ([24.201.245.36]:18185 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbYJ2Xbx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 19:31:53 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9I009NNXBEFB10@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 29 Oct 2008 19:30:51 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <bd6139dc0810291606o2efe4254me378335b76861340@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99435>

On Thu, 30 Oct 2008, Sverre Rabbelier wrote:

> My work is available in the git repository at:
> 
>   git://repo.or.cz/git-stats.git master
> 
> Please use a subtree merge to put this in contrib/gitstats.

[...]

Why do you have commits such as:

>       Changelog for 01-06-2008
>       Changelog for 02-06-2008
>       Changelog for 02-06-2008 (2)
>       Changelog for 03-06-2008
>       Changelog for 04-06-2008
>       Changelog for 05-06-2008
>       Changelog for 06-06-2008
>       Changelog for 07-06-2008
>       Changelog for 08-06-2008
>       Changelog for 09-06-2008
>       Changelog for 10-06-2008

?

If those are not significant enough to have a proper description, then 
I'd suggest you use 'git rebase -i' and its "squash" command to fold 
them into the appropriate commit.


Nicolas
