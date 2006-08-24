From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3] gitweb: Show information about incomplete lines in commitdiff
Date: Thu, 24 Aug 2006 13:12:28 +0200
Organization: At home
Message-ID: <eck1is$p8b$2@sea.gmane.org>
References: <200608240015.15071.jnareb@gmail.com> <200608240158.49908.jnareb@gmail.com> <7vy7teg9gz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Aug 24 13:15:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGDBF-0000bO-GH
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 13:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWHXLPW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 07:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWHXLPW
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 07:15:22 -0400
Received: from main.gmane.org ([80.91.229.2]:12193 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751124AbWHXLPU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Aug 2006 07:15:20 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GGDAs-0000Vr-So
	for git@vger.kernel.org; Thu, 24 Aug 2006 13:15:03 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Aug 2006 13:15:02 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Aug 2006 13:15:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25955>

Junio C Hamano wrote:

> I do not see much point in
> removal of git_commitdiff_plain.

So should I split git_commitdiff into two subroutines,
or should I left it as it is after
  gitweb: Use git-diff-tree patch output for commitdiff
i.e. git_commitdiff('plain') for git_commitdiff_plain?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
