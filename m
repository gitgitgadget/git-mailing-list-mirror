From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GIT v1.5.1-rc1
Date: Wed, 21 Mar 2007 00:30:46 +0100
Organization: At home
Message-ID: <etpqlk$jvq$1@sea.gmane.org>
References: <20070306063501.GA24355@spearce.org> <7v7itcd8mk.fsf@assigned-by-dhcp.cox.net> <20070320025539.GA28922@spearce.org> <200703200937.39440.andyparkins@gmail.com> <20070320144206.GB1750@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 21 00:28:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTnke-00048y-Kg
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 00:28:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933935AbXCTX2U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 19:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933936AbXCTX2U
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 19:28:20 -0400
Received: from main.gmane.org ([80.91.229.2]:47587 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933935AbXCTX2T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 19:28:19 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HTnkH-0007Eh-Td
	for git@vger.kernel.org; Wed, 21 Mar 2007 00:28:02 +0100
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Mar 2007 00:28:01 +0100
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Mar 2007 00:28:01 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42766>

Shawn O. Pearce wrote:

> Andy Parkins <andyparkins@gmail.com> wrote:
>> On Tuesday 2007 March 20 02:55, Shawn O. Pearce wrote:
>>> think they are stuck on the fact that you cannot use:
>>>
>>>     git log $new --not --all
>> 
>>> That almost needs a --all-except="refs/heads/a refs/heads/b" option
>>> to rev-list.  Grrrr.
>> 
>> I'm afraid so.  Would a --ignore list be more appropriate?  That way you could 
>> list any refs you wanted (i.e. not just --all) and then have that list 
>> finally filtered by --ignore.
> 
> Last night on #git Dscho suggested something like:
> 
>   git log $new --not '!a' '!b' --all
> 
> as a way to say ignore ref a and ref b when otherwise parsing the
> command line arguments.  Ugly, very ugly.  But is more or less the
> same idea you are talking about with the --ignore flag.

You mean

  git log $new --not ^a ^b --all

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
