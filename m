From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: More precise tag following
Date: Mon, 29 Jan 2007 21:25:04 +0100
Organization: At home
Message-ID: <epll4j$iil$1@sea.gmane.org>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org> <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org> <Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org> <7vzm84gmei.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org> <7vps8zfqlx.fsf@assigned-by-dhcp.cox.net> <20070129061807.GA4634@spearce.org> <Pine.LNX.4.64.0701290759570.3611@woody.linux-foundation.org> <20070129192911.GA12903@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 29 21:24:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBd30-0006tf-LW
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 21:24:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589AbXA2UYL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 15:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752591AbXA2UYL
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 15:24:11 -0500
Received: from main.gmane.org ([80.91.229.2]:40056 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752589AbXA2UYK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 15:24:10 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HBd2o-00048a-Gy
	for git@vger.kernel.org; Mon, 29 Jan 2007 21:24:02 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Jan 2007 21:24:02 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Jan 2007 21:24:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38095>

Theodore Tso wrote:

> On Mon, Jan 29, 2007 at 08:24:52AM -0800, Linus Torvalds wrote:
>> Anyway, all of these issues makes me suspect that the proper blame 
>> interface is to basically *hide* the blame almost entirely, in order to 
>> make the important parts much more visible, and in order to encourage 
>> people to start looking for the piece of code that they are actually 
>> interested in.
> 
> One approach which might work is where you hover your mouse over a
> line, and it pops up a tiny window with the blame information if the
> mouse remains stationary for more than a second or two.
> 
> Another thing which would be really useful is where the lines that
> have been changed in the last n commits (where n is probably between
> 3-5) are highlighted using different colors.  That way you can see
> what was changed recently, which is often what you are most interested
> in.  (As in, what changed recently that might have caused this file to
> get all screwed up?)

It would be also nice to have window split into two, and for example
have at bottom details of the commit which changed current line, like
author, description, date, how many commits ago, branch name (e.g. taken
from commit message if it was merged), perhaps also patch...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
