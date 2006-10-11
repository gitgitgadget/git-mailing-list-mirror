From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Do not automatically append " git" to custom site name
Date: Wed, 11 Oct 2006 22:31:42 +0200
Organization: At home
Message-ID: <egjkbc$ht$1@sea.gmane.org>
References: <20061011202228.27279.97423.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Oct 11 22:40:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXkpI-0005XL-ER
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 22:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161254AbWJKUhN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 16:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161255AbWJKUhM
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 16:37:12 -0400
Received: from main.gmane.org ([80.91.229.2]:13234 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161254AbWJKUhK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Oct 2006 16:37:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GXkmu-0004t9-1i
	for git@vger.kernel.org; Wed, 11 Oct 2006 22:34:48 +0200
Received: from host-81-190-20-194.torun.mm.pl ([81.190.20.194])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Oct 2006 22:34:48 +0200
Received: from jnareb by host-81-190-20-194.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Oct 2006 22:34:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-194.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28745>

Petr Baudis wrote:

> +our $site_name = "++GITWEB_SITENAME++" || "$ENV{'SERVER_NAME'} Git" || "Untitled Git";

I'd use perhaps "[$ENV{'SERVER_NAME'}] Git".
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
