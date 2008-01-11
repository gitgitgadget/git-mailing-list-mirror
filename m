From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] bundle, fast-import: detect write failure
Date: Fri, 11 Jan 2008 10:14:01 +0100
Organization: At home
Message-ID: <fm7c0p$n9a$1@ger.gmane.org>
References: <874pdmhxha.fsf@rho.meyering.net> <alpine.LSU.1.00.0801101204120.31053@racer.site> <87myrdhnn5.fsf@rho.meyering.net> <alpine.LSU.1.00.0801101234580.31053@racer.site> <87hchlhm3k.fsf@rho.meyering.net> <20080110162526.GB27808@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 10:15:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDFyn-00089C-Sn
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 10:15:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760896AbYAKJOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 04:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758881AbYAKJOO
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 04:14:14 -0500
Received: from main.gmane.org ([80.91.229.2]:47249 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759583AbYAKJOM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 04:14:12 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JDFxp-0008NJ-Re
	for git@vger.kernel.org; Fri, 11 Jan 2008 09:14:09 +0000
Received: from abur101.neoplus.adsl.tpnet.pl ([83.8.189.101])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 09:14:09 +0000
Received: from jnareb by abur101.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 09:14:09 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abur101.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70142>

Pierre Habouzit wrote:
> On Thu, Jan 10, 2008 at 01:00:15PM +0000, Jim Meyering wrote:

>> However, even if it's not technically required to fail at that point,
>> if it were my choice, I'd prefer to know when a .keep file whose
>> contents are unimportant just happens to reside on a bad spot on my
>> disk.  I/O errors should never be ignored.
> 
>   Actually I think .keep files are empty, so the write() should not be
> there in the first place, and we should only check for close() right ?
> not that it matters that much.

In theory the .keep file should contain description _why_ the pack
is made kept. In practice git creates IIRC empty .kep files.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
