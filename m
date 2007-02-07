From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: describe fails on tagless branch
Date: Wed, 07 Feb 2007 01:40:51 +0100
Organization: At home
Message-ID: <eqb73j$hri$1@sea.gmane.org>
References: <eqb660$ft7$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 07 01:39:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEaqZ-0008Jb-Gf
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 01:39:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030465AbXBGAjg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 19:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030462AbXBGAjg
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 19:39:36 -0500
Received: from main.gmane.org ([80.91.229.2]:52566 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030465AbXBGAjg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 19:39:36 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HEaqL-0004Lj-D4
	for git@vger.kernel.org; Wed, 07 Feb 2007 01:39:25 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 01:39:25 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 01:39:25 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38881>

[Cc: git@vger.kernel.org]

Han-Wen Nienhuys wrote:

> try 
> 
>   git init
>   echo hoi > a
>   git add a
>   git commit -m 'add a' a
>   git describe
> 
> this yields
> 
> 
> [lilydev@haring t]$ git describe
> fatal: cannot describe '3b26396bbb5f18580ffd4bc31f70ef0738ec73d6'
> 
> 
> I would prefer it if an implicit tag INIT was supposed at the start of the
> history, so we'd get
> 
>   INIT-3b2...

_Which_ INIT? In git there can be more than one root commit. In git.git
repository mainline (maint, master, next and pu branches) has 4 roots
(plus three linear independent branches: man, html and todo, each with its
own root).

I agree that error description should probably be better: cannot describe
_why_.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
