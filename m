From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] checkout -d: explicitly detach HEAD even when switching to the tip of a branch
Date: Sat, 31 Mar 2007 02:11:45 +0200
Organization: At home
Message-ID: <euk8ps$vu1$1@sea.gmane.org>
References: <7vr6r879zp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 31 02:08:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXR9G-0004ja-S9
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 02:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933156AbXCaAIm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 20:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933161AbXCaAIm
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 20:08:42 -0400
Received: from main.gmane.org ([80.91.229.2]:54048 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933156AbXCaAIm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 20:08:42 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HXR93-0007KE-9g
	for git@vger.kernel.org; Sat, 31 Mar 2007 02:08:37 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 31 Mar 2007 02:08:37 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 31 Mar 2007 02:08:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43511>

Junio C Hamano wrote:

> You cannot currently checkout the tip of an existing branch
> without moving to the branch.
> 
> This allows you to detach your HEAD and place it at such a
> commit, with:
> 
>     $ git checkout -d master

What about

      $ git checkout master^0

trick to force detaching?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
