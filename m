From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Subject: [PATCH 2/3] Let git-add--interactive read colors from .gitconfig
Date: Tue, 13 Nov 2007 10:46:38 +0100
Organization: At home
Message-ID: <fhbrpp$ceq$2@ger.gmane.org>
References: <47112491.8070309@gmail.com>	<20071015034338.GA4844@coredump.intra.peff.net>	<20071016194709.3c1cb3a8@danzwell.com>	<20071017015152.GN13801@spearce.org>	<20071022164048.71a3dceb@danzwell.com>	<20071023042702.GB28312@coredump.intra.peff.net>	<20071023035221.66ea537f@danzwell.com>	<20071102224100.71665182@paradox.zwell.net>	<20071104045735.GA12359@segfault.peff.net>	<7v640ivagv.fsf@gitster.siamese.dyndns.org>	<20071104054305.GA13929@sigill.intra.peff.net>	<20071110202351.7b4544aa@paradox.zwell.net>	<7vve89f6qy.fsf@gitster.siamese.dyndns.org>	<47390050.1020907@zwell.net>	<7v4pfq27tx.fsf@gitster.siamese.dyndns.org>	<47391211.5000606@zwell.net> <7v4pfqwqln.fsf@gitster.siamese.dyndns.org> <47395F63.8040306@zwell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 10:50:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrsPY-00040m-CI
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 10:50:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbXKMJuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 04:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbXKMJuJ
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 04:50:09 -0500
Received: from main.gmane.org ([80.91.229.2]:52182 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751433AbXKMJuH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 04:50:07 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IrsPC-000539-CC
	for git@vger.kernel.org; Tue, 13 Nov 2007 09:50:02 +0000
Received: from abvw125.neoplus.adsl.tpnet.pl ([83.8.220.125])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 09:50:02 +0000
Received: from jnareb by abvw125.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 09:50:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvw125.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64776>

Dan Zwell wrote:

> Junio C Hamano wrote:
>> But the point is, that you are not ignoring invalid color names
>> but instead giving back a random match aren't you?
> 
> No, if there's no match, the token is ignored. False matches are 
> possible in some cases (the bogus config option "colored" would match 
> "red", for example),

Match /\b(?:red|...)\b/ then

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
