From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: qgit idea: interface for cherry-picking
Date: Tue, 04 Jul 2006 09:02:22 +0200
Organization: At home
Message-ID: <e8d3ot$ne9$2@sea.gmane.org>
References: <e8954u$srh$1@sea.gmane.org> <e5bfff550607021433l1987c32apf4453b52fc2f3e63@mail.gmail.com> <e89eqj$npu$1@sea.gmane.org> <e5bfff550607021504l6e7fc8b8ja61f20f630c0f3f@mail.gmail.com> <e89iql$42a$1@sea.gmane.org> <e5bfff550607022245s2ef160fu5ad30a822f06117d@mail.gmail.com> <7vzmfrrxyp.fsf@assigned-by-dhcp.cox.net> <e5bfff550607030418n6a46c0cdh1a95155e1feb4356@mail.gmail.com> <7vd5cmqwv3.fsf@assigned-by-dhcp.cox.net> <e5bfff550607032322jdf3bc79l3f41c292ebb6d3f7@mail.gmail.com> <7vk66tna71.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Jul 04 09:05:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxeyG-0006pV-FL
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 09:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWGDHFK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 03:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWGDHFK
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 03:05:10 -0400
Received: from main.gmane.org ([80.91.229.2]:8114 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751089AbWGDHFI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 03:05:08 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Fxexy-0006ms-VW
	for git@vger.kernel.org; Tue, 04 Jul 2006 09:05:03 +0200
Received: from host-81-190-27-124.torun.mm.pl ([81.190.27.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Jul 2006 09:05:02 +0200
Received: from jnareb by host-81-190-27-124.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Jul 2006 09:05:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-124.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23262>

Junio C Hamano wrote:
> [...] (you let the user to hand
> resolve and say "am --resolved", but then when the series is
> depleted, somebody has to run "reset --soft" to roll N commits
> back to realize what you wanted to do, so at that point QGit
> somehow needs to take control back).

Would it be easier if QGit for "am --squash" generated lightweight temporary
tag before first git-am, so one would need not to remember N for "reset
--soft"?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
