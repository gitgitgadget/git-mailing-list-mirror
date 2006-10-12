From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-pickaxe: blame rewritten.
Date: Thu, 12 Oct 2006 23:55:49 +0200
Organization: At home
Message-ID: <egmdkv$k33$1@sea.gmane.org>
References: <7v7iz5rk4b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Oct 13 00:43:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY96W-0006Vc-PU
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 00:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWJLWch (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 18:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWJLWch
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 18:32:37 -0400
Received: from main.gmane.org ([80.91.229.2]:39661 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751226AbWJLWcg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Oct 2006 18:32:36 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GY8ri-0000F6-4R
	for git@vger.kernel.org; Fri, 13 Oct 2006 00:17:22 +0200
Received: from host-81-190-17-207.torun.mm.pl ([81.190.17.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Oct 2006 00:17:22 +0200
Received: from jnareb by host-81-190-17-207.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Oct 2006 00:17:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-207.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28814>

Junio C Hamano wrote:

> Currently it does what git-blame does, but only faster.
> 
> More importantly, its internal structure is designed to support
> content movement (aka cut-and-paste) more easily by allowing
> more than one paths to be taken from the same commit.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---
> 
> I really hate to do this immediately after writing obituary for
> annotate, but I had a solid 24-hour to work on git, which is a
> rare opportunity for me these days, so here it is.

Why not reuse git-annotate name? git-pickaxe doesn't do pickaxe...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
