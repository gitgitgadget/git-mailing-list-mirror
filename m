From: Nicolas Vilz 'niv' <niv@iaglans.de>
Subject: Re: git + ssh + key authentication feature-request
Date: Thu, 09 Feb 2006 01:43:09 +0100
Message-ID: <43EA901D.3030008@iaglans.de>
References: <43EA73C3.2040309@iaglans.de> <7vhd79o6m5.fsf@assigned-by-dhcp.cox.net> <43EA7D57.7040409@iaglans.de> <Pine.LNX.4.64.0602081438390.2458@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Feb 09 00:44:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6yys-0006vS-TW
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 00:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422645AbWBHXoL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 18:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422644AbWBHXoL
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 18:44:11 -0500
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:54277 "EHLO
	vsectoor.geht-ab-wie-schnitzel.de") by vger.kernel.org with ESMTP
	id S1422642AbWBHXoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2006 18:44:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 0D8F73E9D
	for <git@vger.kernel.org>; Thu,  9 Feb 2006 00:44:09 +0100 (CET)
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1])
	by localhost (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 31812-07 for <git@vger.kernel.org>;
	Thu, 9 Feb 2006 00:44:08 +0100 (CET)
Received: from [192.168.100.26] (hermes.lan.home.vilz.de [192.168.100.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 564B23E51
	for <git@vger.kernel.org>; Thu,  9 Feb 2006 00:44:08 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0602081438390.2458@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15763>

Linus Torvalds wrote:
> Create a "project" account on some shared machine, create the project(s) 
> in that accounts home directory, and set the login shell for that 
> project to "git-shell".

done..

> It _should_ all work perfectly fine. There are features you may want to 
> add, like logging (but sshd does some of that for you) and various "admin" 
> commands in addition to just plain push/pull. git-shell was really just a 
> quick hack, and I don't know if anybody actually uses it.

I would like to use it.. i searched for something like scponly for ssh 
just for git.. and I found git-shell.

as long as i can modify and setup git-repositories myself, i haven't 
needed admin-commands, yet...

as mentioned in the thread, i still search for a posibility to tell git 
to send my identify-file... and possibly set an alias for this command :)

ssh with bash for this account and the keys works... ssh with git-shell 
does work, too... (What do you think I am? A shell?) but git with keys 
and ssh transport, that is what i don't get working :)

Nicolas
