From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Support for custom per-project owner string
Date: Wed, 20 Sep 2006 21:01:05 +0200
Organization: At home
Message-ID: <ees35e$4vh$1@sea.gmane.org>
References: <20060919225522.GB13132@pasky.or.cz> <7veju6lgxu.fsf@assigned-by-dhcp.cox.net> <20060920154208.GN8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Sep 20 21:02:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ7Ks-00049T-C5
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 21:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWITTCN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 15:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWITTCN
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 15:02:13 -0400
Received: from main.gmane.org ([80.91.229.2]:42433 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932258AbWITTCL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 15:02:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GQ7Jv-0003so-CD
	for git@vger.kernel.org; Wed, 20 Sep 2006 21:01:19 +0200
Received: from host-81-190-26-109.torun.mm.pl ([81.190.26.109])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Sep 2006 21:01:19 +0200
Received: from jnareb by host-81-190-26-109.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Sep 2006 21:01:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-109.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27393>

Petr Baudis wrote:

> Dear diary, on Wed, Sep 20, 2006 at 05:02:21PM CEST, I got a letter
> where Junio C Hamano <junkio@cox.net> said that...
>> Petr Baudis <pasky@suse.cz> writes:
>> 
>>> Also, ideally this would be in the configfile but calling repoconfig for
>>> each repository in the index would slow things down way too much.
>> 
>> Hmph.  I wonder why.  We do read description already from a file
>> so maybe we would want a faster way to access the config file to
>> grab gitweb.* variables in a single call?
> 
> Still, opening files is _much_ faster than executing a tool, I'd say.

Perhaps we should just parse $GIT_DIR/config ourself in gitweb
(this is thing that I certainly would want to see in Git.pm).
There are many modules which parse ini-like config files, but it
shouldn't be that difficult to write parser which _reads_ and parses
config file (without support for setting variables).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
