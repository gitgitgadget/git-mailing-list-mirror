From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [CFH] Remotes conversion script
Date: Mon, 25 Sep 2006 00:57:51 +0200
Organization: At home
Message-ID: <ef72h1$dk9$1@sea.gmane.org>
References: <20060924212142.GB20017@pasky.or.cz> <ef6tt8$2un$1@sea.gmane.org> <Pine.LNX.4.63.0609242347090.25371@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Sep 25 00:57:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRcv6-00065A-Ri
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 00:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWIXW5y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 18:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWIXW5y
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 18:57:54 -0400
Received: from main.gmane.org ([80.91.229.2]:22761 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932124AbWIXW5x (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 18:57:53 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GRcux-00063k-5b
	for git@vger.kernel.org; Mon, 25 Sep 2006 00:57:47 +0200
Received: from host-81-190-26-109.torun.mm.pl ([81.190.26.109])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Sep 2006 00:57:47 +0200
Received: from jnareb by host-81-190-26-109.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Sep 2006 00:57:47 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-109.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27710>

Johannes Schindelin wrote:

> On Sun, 24 Sep 2006, Jakub Narebski wrote:
> 
>> If I remember correctly currently only some functionality provided by
>> remotes file can be provided by [remote] and [branch] sections of git
>> config.
> 
> ... and what might the lacking functionality be?
> 
> .git/remotes/<name>    config
> 
> URL:                   remote.<name>.url
> Pull:                  remote.<name>.fetch
> Push:                  remote.<name>.push
> 
> You can even have multiple entries in the config, and it behaves as if you 
> had multiple lines in .git/remotes/<name>.

Hmmm... strange, in 'next' branch.<name>.* are documented in
Documentation/config.txt, but the remote.<name>.* are not.

Neither is documented [branch "funky name"] syntax (branch."funky name").

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
