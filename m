From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: branch.pu.forcefetch
Date: Wed, 27 Dec 2006 22:20:36 +0100
Organization: At home
Message-ID: <emuntl$fn$2@sea.gmane.org>
References: <1167251519.2247.10.camel@dv> <7vfyb159dn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Dec 27 22:18:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzgA3-0006wZ-Fe
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 22:18:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932699AbWL0VSE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 16:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932762AbWL0VSD
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 16:18:03 -0500
Received: from main.gmane.org ([80.91.229.2]:39806 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932754AbWL0VSC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 16:18:02 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Gzg9n-0000Lr-W7
	for git@vger.kernel.org; Wed, 27 Dec 2006 22:17:52 +0100
Received: from host-81-190-19-121.torun.mm.pl ([81.190.19.121])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 Dec 2006 22:17:51 +0100
Received: from jnareb by host-81-190-19-121.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 Dec 2006 22:17:51 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-19-121.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35482>

Junio C Hamano wrote:

> Pavel Roskin <proski@gnu.org> writes:
> 
>> For example, I clone the git repository anew, and I try to update it by
>> git-fetch a few days later.  I get an error:
>>
>> * refs/remotes/origin/pu: not updating to non-fast forward branch 'pu'
>> of git://www.kernel.org/pub/scm/git/git
> 
> Perhaps you would want something like this?
> 
> if you are using separate remote layout:
> 
> [remote "origin"]
>       fetch = +refs/heads/pu:refs/remotes/origin/pu
>       fetch = refs/heads/*:refs/remotes/origin/*

By the way, does the ordering matter here, i.e. does it matter if 'pu' fetch
line is before or after wildcards line?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
