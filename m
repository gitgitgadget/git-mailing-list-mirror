From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 4/3] gitweb: Use here-doc
Date: Tue, 22 Aug 2006 23:54:26 +0200
Organization: At home
Message-ID: <ecfuef$riq$1@sea.gmane.org>
References: <200608221651.19629.jnareb@gmail.com> <200608222342.53861.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Aug 22 23:54:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFeD0-0004TQ-E4
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 23:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWHVVyn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 17:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWHVVyn
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 17:54:43 -0400
Received: from main.gmane.org ([80.91.229.2]:4846 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750740AbWHVVym (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Aug 2006 17:54:42 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GFeCm-0004RN-R3
	for git@vger.kernel.org; Tue, 22 Aug 2006 23:54:40 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Aug 2006 23:54:40 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Aug 2006 23:54:40 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25875>

Jakub Narebski wrote:

> This patch uses undocumented, at least in perlop(1), trick in
> interpolation that allows calling function from interpolated string,
> using ${\subroutine_name(parameters...)}, found in git_blame,
> and used in git_rss here-doc in this patch.

It is trick, using ${...} syntax described in perlref(1), where ... is a
expression returning reference (in our case scalar reference).
${\...} is similar to @{[...]} trick, dereference(reference(value)), where
dereference is only to have interpolation.  

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
