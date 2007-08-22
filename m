From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Document what the stage numbers in the :$n:path syntax mean.
Date: Wed, 22 Aug 2007 02:14:10 +0200
Organization: At home
Message-ID: <fafv4j$fb4$2@sea.gmane.org>
References: <7v1we5bvbw.fsf@assigned-by-dhcp.cox.net> <20070814231422.GA10662@pe.Belkin> <7vps1paceh.fsf@assigned-by-dhcp.cox.net> <46C90C46.1030000@midwinter.com> <20070820055221.GA22993@coredump.intra.peff.net> <20070820060522.GA27913@spearce.org> <7vveba90qs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 02:16:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INdt3-0002jZ-PN
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 02:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbXHVAPu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 20:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbXHVAPu
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 20:15:50 -0400
Received: from main.gmane.org ([80.91.229.2]:57203 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750711AbXHVAPt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 20:15:49 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1INdsq-00083s-Nm
	for git@vger.kernel.org; Wed, 22 Aug 2007 02:15:40 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 02:15:40 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 02:15:40 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56341>

Junio C Hamano wrote:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
>>> Am I the only one who messes this up? If not, patch is below.
>>
>> Maybe.  ;-)
>>
>> I've memorized it long long ago.  But my coworkers haven't and always
>> get it wrong, and look at me funny when I tell them "trust me, your
>> data is in stage 2 and theirs is in stage 3...  because that's the
>> convention all of the tools you are using follows".
> 
> I am not _opposed_ to :ours:$path syntax, but I suspect there is
> something else that is wrong if you need to use :$n:$path syntax
> that often.
> 
> I have never been in a situation I had to say :base:$path,
> unless I am debugging the merge driver.  So it is between :ours:$path
> and :theirs:$path.
> 
> But aren't they by definition HEAD:$path and MERGE_HEAD:$path,
> which are far more descriptive?

Nice idea, if only this was mentioned in the documentation...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
