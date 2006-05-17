From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: "git add $ignored_file" fail
Date: Wed, 17 May 2006 15:46:04 +0200
Organization: At home
Message-ID: <e4f9eo$b60$1@sea.gmane.org>
References: <8aa486160605161507w3a27152dq@mail.gmail.com> <Pine.LNX.4.64.0605161526210.16475@g5.osdl.org> <8aa486160605161542u704ccf03w@mail.gmail.com> <Pine.LNX.4.63.0605171306400.19012@wbgn013.biozentrum.uni-wuerzburg.de> <81b0412b0605170604i689a8f7axa5aeb7752dc72072@mail.gmail.com> <8aa486160605170641p2ab8704o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed May 17 15:47:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgMMf-00069h-1j
	for gcvg-git@gmane.org; Wed, 17 May 2006 15:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbWEQNqq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 09:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbWEQNqq
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 09:46:46 -0400
Received: from main.gmane.org ([80.91.229.2]:43430 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932555AbWEQNqp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 09:46:45 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FgMM9-00064H-6u
	for git@vger.kernel.org; Wed, 17 May 2006 15:46:29 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 May 2006 15:46:29 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 May 2006 15:46:29 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20197>

Santi wrote:

> In the other way, now I find the value of being able to say:
> 
> $ git add t*
> 
> and be sure that it does not add an ignored file. Unfortunately
> git-add cannot distinguish between both.

Well, it could. If 'git add <filespec>' would result in NO files 
added, take <filespec> as literate <file> (filename), regardless
of ignores.

-- 
Jakub Narebski
Warsaw, Poland
