From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Merge git-gui into 1.5.0 ?
Date: Tue, 13 Feb 2007 01:34:23 +0100
Organization: At home
Message-ID: <eqr0v4$rqd$1@sea.gmane.org>
References: <20070211084030.GE2082@spearce.org> <7vwt2oba8s.fsf@assigned-by-dhcp.cox.net> <20070211224158.GA31488@spearce.org> <7v64a782ht.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0702130037530.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070212234212.GB30967@spearce.org> <Pine.LNX.4.63.0702130053200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 13 01:33:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGlbs-0006la-Hx
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 01:33:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030591AbXBMAdW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 19:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030594AbXBMAdW
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 19:33:22 -0500
Received: from main.gmane.org ([80.91.229.2]:37291 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030591AbXBMAdW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 19:33:22 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HGlbP-00086n-Jx
	for git@vger.kernel.org; Tue, 13 Feb 2007 01:32:59 +0100
Received: from host-81-190-26-216.torun.mm.pl ([81.190.26.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Feb 2007 01:32:59 +0100
Received: from jnareb by host-81-190-26-216.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Feb 2007 01:32:59 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-216.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39467>

Johannes Schindelin wrote:
> On Mon, 12 Feb 2007, Shawn O. Pearce wrote:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>>> On Mon, 12 Feb 2007, Junio C Hamano wrote:
>>> 
>>>> Ok, so here is what I did last night.
>>>> 
>>>> $ git remote show git-gui
>>>> * remote git-gui
>>>>   URL: git://repo.or.cz/git-gui.git/
>>>>   Tracked remote branches
>>>>     master
>>>> $ git fetch git-gui
>>>> $ git read-tree --prefix=git-gui/ git-gui/master
>>>> $ git checkout git-gui
>>> 
>>> Didn't you mean "git checkout master" here?
>> 
>> I don't think so.  At this point the subdirectory git-gui is known
>> in the index, so Junio is trying to get checkout-index to process
>> those paths and create it in the working directory.
> 
> Ah! Thanks,
> Dscho

So it is "git checkout -- git-gui" then?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
