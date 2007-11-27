From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git bug/feature request
Date: Tue, 27 Nov 2007 16:13:03 +0100
Organization: At home
Message-ID: <fihc5u$mbs$1@ger.gmane.org>
References: <200711271127.41161.gapon007@gmail.com> <Pine.LNX.4.64.0711271531110.1011@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 27 16:14:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix28r-00043U-CP
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 16:14:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755869AbXK0POE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 10:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755708AbXK0POE
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 10:14:04 -0500
Received: from main.gmane.org ([80.91.229.2]:38230 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752447AbXK0POC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 10:14:02 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ix282-0006fj-Kl
	for git@vger.kernel.org; Tue, 27 Nov 2007 15:13:38 +0000
Received: from abvx114.neoplus.adsl.tpnet.pl ([83.8.221.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 15:13:38 +0000
Received: from jnareb by abvx114.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 15:13:38 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvx114.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66226>

Peter Karlsson wrote:

> gapon:
> 
>> i have discovered "weird" behaviour of git in this scenario*:
> 
> Yeah, I have run into it several times myself, and that is being both
> user A and B at the same time. The problem seems to be that git allows
> you to push into a repository which has a check-out, causing it to
> change states in a subtle way. That's just plain broken.
> 
> Git should either handle it somehow (perhaps by forcing the push into a
> new branch, which the pushee needs name), or just plainly refuse to
> push into a repository with a check-out.

I thought that modern git refuses to push into checked out branch
(in HEAD) in non-bare repositories. In shared repositories default
is to deny non-fastforwards, by the way.

> I have learned to work around this problem by always pulling between my
> repositories, not pushing.

You can simply push to remotes, allowing other person to merge
on other side.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
