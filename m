From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare repositories?
Date: Tue, 13 Nov 2007 11:08:56 +0100
Organization: At home
Message-ID: <fhbt3o$ebf$2@ger.gmane.org>
References: <86k5on8v6p.fsf@lola.quinscape.zz> <20071112131927.GA1701@c3sl.ufpr.br> <Pine.LNX.4.64.0711121355380.4362@racer.site> <200711121719.54146.wielemak@science.uva.nl> <Pine.LNX.4.64.0711121624330.4362@racer.site> <vpq3avbv2ju.fsf@bauges.imag.fr> <Pine.LNX.4.64.0711121715090.4362@racer.site> <18232.35893.243300.179076@lisa.zopyra.com> <Pine.LNX.4.64.0711121727130.4362@racer.site> <vpq7iknqrtp.fsf@bauges.imag.fr> <Pine.LNX.4.64.0711121755460.4362@racer.site> <vpqy7d3pck0.fsf@bauges.imag.fr> <Pine.LNX.4.64.0711121804400.4362@racer.site> <vpqoddzpc88.fsf@bauges.imag.fr> <7v4pfr2kmh.fsf@gitster.siamese.dyndns.org> <vpqzlxiiii6.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 11:09:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irsi3-0001Fj-Ix
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 11:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbXKMKJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 05:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbXKMKJQ
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 05:09:16 -0500
Received: from main.gmane.org ([80.91.229.2]:54857 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493AbXKMKJP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 05:09:15 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Irshd-0007UW-8z
	for git@vger.kernel.org; Tue, 13 Nov 2007 10:09:05 +0000
Received: from abvw125.neoplus.adsl.tpnet.pl ([83.8.220.125])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 10:09:05 +0000
Received: from jnareb by abvw125.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 10:09:05 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvw125.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64782>

Matthieu Moy wrote:

> I repeat the use-case I mentionned above :
> 
> ,----
> | a typical use-case is when I want to create a new project. I'd
> | like to initialize an empty bare repo on my backed up disk, and then
> | clone it to my local-fast-unreliable disk to get a working copy and do
> | the first commit there.
> `----
> 
> I find this quite natural, and up to now, no one gave me either a
> rationale not to do that,

The rationale is that current git just simply cannot do this.
You are welcome to add support for this corner case in git-clone,
or add git protocol extension for symref transfer.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
