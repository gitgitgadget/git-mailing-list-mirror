From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] diffcore: Allow users to decide what funcname to use
Date: Tue, 13 Nov 2007 11:03:07 +0100
Organization: At home
Message-ID: <fhbsor$ebf$1@ger.gmane.org>
References: <4738208D.1080003@op5.se>	<Pine.LNX.4.64.0711120958500.4362@racer.site> <47382C84.50408@op5.se>	<7vhcjr2lte.fsf@gitster.siamese.dyndns.org> <4738E9E6.2040001@op5.se> <buomytin9dz.fsf@dhapc248.dev.necel.com> <473954F8.8070908@op5.se> <47396B4C.6070406@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 11:03:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrscN-0007hq-8k
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 11:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbXKMKDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 05:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbXKMKDY
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 05:03:24 -0500
Received: from main.gmane.org ([80.91.229.2]:51986 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493AbXKMKDX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 05:03:23 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Irsc0-0006Ux-Uz
	for git@vger.kernel.org; Tue, 13 Nov 2007 10:03:17 +0000
Received: from abvw125.neoplus.adsl.tpnet.pl ([83.8.220.125])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 10:03:16 +0000
Received: from jnareb by abvw125.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 10:03:16 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvw125.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64780>

Andreas Ericsson wrote:

> Git can be smarter than that, and imo it should. This
> patch lets the diffcore grok a new configuration variable,
> "diff.funcnames", which can be set to "new", "old", or a
> boolean value, which will cause it to be "old" (for 'true')
> and 'none' (for 'false').

Wouldn't it be better to use existing 'diff driver' infrastructure
for this? See "Defining a custom hunk-header" section in
gitattributes(5).

On the other hand... no.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
