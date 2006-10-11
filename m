From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Thu, 12 Oct 2006 01:05:16 +0200
Organization: At home
Message-ID: <egjtba$33o$1@sea.gmane.org>
References: <egdge3$t12$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Oct 12 01:07:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXnA1-0004je-2r
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 01:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161271AbWJKXGp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 19:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161272AbWJKXGp
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 19:06:45 -0400
Received: from main.gmane.org ([80.91.229.2]:33758 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161271AbWJKXGn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Oct 2006 19:06:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GXn9Z-0004b3-Ck
	for git@vger.kernel.org; Thu, 12 Oct 2006 01:06:21 +0200
Received: from host-81-190-20-194.torun.mm.pl ([81.190.20.194])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Oct 2006 01:06:21 +0200
Received: from jnareb by host-81-190-20-194.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Oct 2006 01:06:21 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-194.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28762>

4. New features

 * Better support for symlinks in the "tree" view, perhaps in the
   "_filename_ -> _target_" form instead of simply "_filename_"
   if the symlink is relative, and the target is inside repository
   (not checking if it exists), "_filename_ -> target" otherwise.
   Needs some normalizing (removing of '/./' and '/../') of the symlink
   target.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
