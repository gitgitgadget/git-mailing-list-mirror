From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare repositories?
Date: Mon, 12 Nov 2007 23:49:55 +0100
Organization: At home
Message-ID: <fhalah$e9s$1@ger.gmane.org>
References: <86k5on8v6p.fsf@lola.quinscape.zz> <20071112131927.GA1701@c3sl.ufpr.br> <Pine.LNX.4.64.0711121355380.4362@racer.site> <200711121719.54146.wielemak@science.uva.nl> <Pine.LNX.4.64.0711121624330.4362@racer.site> <vpq3avbv2ju.fsf@bauges.imag.fr> <Pine.LNX.4.64.0711121715090.4362@racer.site> <alpine.LFD.0.9999.0711121231150.21255@xanadu.home> <Pine.LNX.4.64.0711121751100.4362@racer.site> <4738A6BD.50704@op5.se> <7vzlxj15xe.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 23:50:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iri6m-0007NG-HA
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 23:50:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756838AbXKLWuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 17:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757081AbXKLWuE
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 17:50:04 -0500
Received: from main.gmane.org ([80.91.229.2]:42568 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755626AbXKLWuD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 17:50:03 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Iri6R-00021G-3W
	for git@vger.kernel.org; Mon, 12 Nov 2007 22:49:59 +0000
Received: from abvw125.neoplus.adsl.tpnet.pl ([83.8.220.125])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 22:49:59 +0000
Received: from jnareb by abvw125.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 22:49:59 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvw125.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64728>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
>> Johannes Schindelin wrote:
>>
>>> But since you're one of the people knowing git _internals_ pretty
>>> well, here's another reason just for you why this cannot be done:
>>> There is no way to find out where the HEAD points to.
>>
>> $ mkdir foo; cd foo; git init; git symbolic-ref -q HEAD
>> refs/heads/master
> 
> Johannes is talking about the lack of native protocol support to
> transfer symref information.  That's the reason git-clone dances
> around finding where HEAD really points at.  It simply does not
> know -- all it gets about a symref is what SHA-1 the ref points
> at.

Do I remember correctly that there was some talk about extending git
protocol to avoid this compicated dance, and transfer symbolic refs
directly?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
