From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Change set based shallow clone
Date: Tue, 12 Sep 2006 02:25:08 +0200
Organization: At home
Message-ID: <ee4uos$oq7$1@sea.gmane.org>
References: <17669.8191.778645.311304@cargo.ozlabs.ibm.com> <20060911142644.32313.qmail@science.horizon.com> <7vy7sqic4e.fsf@assigned-by-dhcp.cox.net> <17669.55963.930152.564529@cargo.ozlabs.ibm.com> <7v1wqige41.fsf@assigned-by-dhcp.cox.net> <ee4tmo$mhm$1@sea.gmane.org> <7vodtmey30.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Sep 12 02:25:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMw5a-0003JU-2t
	for gcvg-git@gmane.org; Tue, 12 Sep 2006 02:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965202AbWILAZQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 20:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965203AbWILAZQ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 20:25:16 -0400
Received: from main.gmane.org ([80.91.229.2]:42668 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965202AbWILAZO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Sep 2006 20:25:14 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GMw5L-0003HZ-B4
	for git@vger.kernel.org; Tue, 12 Sep 2006 02:25:07 +0200
Received: from host-81-190-17-209.torun.mm.pl ([81.190.17.209])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Sep 2006 02:25:07 +0200
Received: from jnareb by host-81-190-17-209.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Sep 2006 02:25:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26873>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Actually 'git ls-remote .' _is_ useful for gitweb, see the new 
>> git_get_references code. 
> 
> You are missing the point.
> 
> We are not discussing if having foo^{} is useful.  There is no
> argument about it.  Without it the user is forced to ask
> rev-parse.
> 
> The point is if it is Ok to assume foo and foo^{} (and nothing
> else) are enough to make Porcelains and visualizers happy, and I
> suspected the answer was no (remember show-ref discussion?).

Well, it is enough for ref markers (this commit is this head or tag), for
dumb http transport (indo/refs output is the same as ls-remote), and not
much else... 

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
