From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: way to automatically add untracked files?
Date: Mon, 06 Aug 2007 02:32:56 +0200
Organization: At home
Message-ID: <f95q7l$8lv$2@sea.gmane.org>
References: <873ayymzc1.fsf@catnip.gol.com> <fc339e4a0708042100jdf0a0f1jd1fddfb5dc1c1052@mail.gmail.com> <20070805041320.GH9527@spearce.org> <200708051411.25238.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 06 02:33:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHqX3-0003EG-Dp
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 02:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758991AbXHFAdK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 20:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758933AbXHFAdJ
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 20:33:09 -0400
Received: from main.gmane.org ([80.91.229.2]:47353 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752060AbXHFAdG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 20:33:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IHqWr-0001Kq-MR
	for git@vger.kernel.org; Mon, 06 Aug 2007 02:33:01 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Aug 2007 02:33:01 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Aug 2007 02:33:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55097>

Johan Herland wrote:

> So different users seem to have two different (almost incompatible) 
> expectations to git-add:
> 
> 1. git-add adds new files into the index. git-add has _no_ business removing 
> deleted files from the index.
> 
> 2. git-add updates the index according to the state of the working tree. 
> This includes adding new files and removing deleted files.
> 
> 
> Both interpretations are useful and worth supporting, but git-add currently 
> seems focused on #1 (and rightly so, IMHO).
> 
> Even though #2 can be achieved by using a couple of git-add commmands (or a 
> longer series of more obscure plumbing-level commands), it might be worth 
> considering the more user-friendly alternative of adding a dedicated 
> command for supporting #2. Such a command already exists in a similar RCS:
> 
> ---
> $ hg addremove --help
> hg addremove [OPTION]... [FILE]...
> 
> add all new files, delete all missing files

git update-index --add --remove?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
