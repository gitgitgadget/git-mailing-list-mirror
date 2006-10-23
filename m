From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] git-split: Split the history of a git repository by subdirectories and ranges
Date: Mon, 23 Oct 2006 22:07:11 +0200
Organization: At home
Message-ID: <ehj7cm$dku$1@sea.gmane.org>
References: <451A30E4.50801@freedesktop.org> <7vlko5d3bx.fsf@assigned-by-dhcp.cox.net> <453C96C9.4010005@freedesktop.org> <Pine.LNX.4.64.0610230846420.3962@g5.osdl.org> <453D17B5.6070203@freedesktop.org> <Pine.LNX.4.64.0610231237080.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Oct 23 22:09:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc66X-0001jP-Uz
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 22:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWJWUI6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 16:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965024AbWJWUI6
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 16:08:58 -0400
Received: from main.gmane.org ([80.91.229.2]:36538 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964890AbWJWUI5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 16:08:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Gc64R-0001E5-Qd
	for git@vger.kernel.org; Mon, 23 Oct 2006 22:06:51 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Oct 2006 22:06:51 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Oct 2006 22:06:51 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29871>

There is also not-that-obvious result that

  git rev-log --parents --full-history <head> -- <pathspec> 

generates different result than if either --parents or --full-history are
absent.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
