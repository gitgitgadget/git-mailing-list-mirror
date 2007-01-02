From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Tue, 02 Jan 2007 12:31:38 +0100
Organization: At home
Message-ID: <endfl1$iq0$1@sea.gmane.org>
References: <405044.6078.qm@web31809.mail.mud.yahoo.com> <7vy7omyuaf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Jan 02 12:28:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1hp6-0000iZ-D2
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 12:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932749AbXABL2t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 06:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932848AbXABL2t
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 06:28:49 -0500
Received: from main.gmane.org ([80.91.229.2]:51310 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932749AbXABL2s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 06:28:48 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H1hos-0004OB-ST
	for git@vger.kernel.org; Tue, 02 Jan 2007 12:28:39 +0100
Received: from host-81-190-20-195.torun.mm.pl ([81.190.20.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Jan 2007 12:28:38 +0100
Received: from jnareb by host-81-190-20-195.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Jan 2007 12:28:38 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-195.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35785>

Junio C Hamano wrote:

> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
>> Questions:
>>
>> What is the reasonining of defining branch.<name>.merge to point
>> to the "remote's setup"?
> 
> See list archives.  
> 
> Because you are not required to use remote tracking branches.
> By the way, I think we allow the name of the remote tracking
> branch as well, but we do not advertise it -- always using
> remote's name consistently is much less confusing.

If  remember correctly there were added some magic which makes
git search on pull first remote branches (to allow to pull
without tracking branches), then tracking branches. This I think
supercedes alternate proposal of using branch.<name>.mergeLocal.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
