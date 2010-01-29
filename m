From: Ron Garret <ron1@flownet.com>
Subject: Re: [PATCH] checkout: warn about 'branch name' rather than 'local branch'
Date: Fri, 29 Jan 2010 13:50:30 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-15D04D.13503029012010@news.gmane.org>
References: <fabb9a1e1001291256j71e2c95cic21cb5a6a0cc1fe8@mail.gmail.com> <1264799342-11093-1-git-send-email-srabbelier@gmail.com> <alpine.LFD.2.00.1001291621020.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 29 22:51:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nayjy-0003NT-Jm
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 22:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939Ab0A2Vux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 16:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752804Ab0A2Vuw
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 16:50:52 -0500
Received: from lo.gmane.org ([80.91.229.12]:47042 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750899Ab0A2Vuw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 16:50:52 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nayjq-0003En-Sv
	for git@vger.kernel.org; Fri, 29 Jan 2010 22:50:50 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 22:50:50 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 22:50:50 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138376>

In article <alpine.LFD.2.00.1001291621020.1681@xanadu.home>,
 Nicolas Pitre <nico@fluxnic.net> wrote:

> On Fri, 29 Jan 2010, Sverre Rabbelier wrote:
> 
> > These days, you can say "git checkout topic" to automagically create
> > a local "topic" branch that forks from "origin/topic" remote tracking
> > branch when you have one, thanks to Dscho's UI improvement ideas. As
> > such it is more appropriate to say that the user is checking out
> > something that is not a branch name, rather than saying it is not a
> > 'local branch'.
> > 
> > Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
> 
> For the record, I'm providing a NAK.  First I don't agree with the UI 
> "improvement" if there is no way to check out a remote branch without 
> creating soon-to-be-stall local branches with the same name.
> 
> Next, the message can be made yet more clear and give the user more of a 
> hint with what is going on.  Something like:
> 
> 	"%s is not a local branch head: creating a detached HEAD\n"
> 
> plus the remaining clue lines.  This way people will have a much greater 
> chance of understanding what state they're in, and a simple Google 
> search for detached HEAD gives you the Git manual page with the needed 
> info.

I agree that would be much better.

rg
