From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] repo-config: learn the flag "--no-local"
Date: Thu, 08 Jun 2006 20:36:34 +0200
Organization: At home
Message-ID: <e69qne$nnl$2@sea.gmane.org>
References: <Pine.LNX.4.63.0606081331140.11910@wbgn013.biozentrum.uni-wuerzburg.de> <44880BE8.40804@etek.chalmers.se> <Pine.LNX.4.63.0606081340230.25911@wbgn013.biozentrum.uni-wuerzburg.de> <20060608133747.GA15374@diana.vm.bytemark.co.uk> <20060608153508.GB8047@satan.machinehead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Jun 08 20:40:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoPQe-0003wW-Kp
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 20:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbWFHSkW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 14:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbWFHSkV
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 14:40:21 -0400
Received: from main.gmane.org ([80.91.229.2]:25567 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964933AbWFHSkV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jun 2006 14:40:21 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1FoPQJ-0003rd-Po
	for git@vger.kernel.org; Thu, 08 Jun 2006 20:40:05 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Jun 2006 20:40:03 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Jun 2006 20:40:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21505>

Aneesh Kumar K.V wrote:

> On Thu, Jun 08, 2006 at 03:37:47PM +0200, Karl Hasselstr?m wrote:
>> On 2006-06-08 13:41:04 +0200, Johannes Schindelin wrote:
>> 
>> My vote goes to --no-local, but only if we also get a --no-no-local
>> flag with the opposite meaning. Otherwise, I'd prefer --global. :-)
>> 
> 
> 
> I guess it makes much sense to rename the command to git-config and say 
> 
> git config  alias.l  -> for golbal config 
> git config --repo alias.l -> for repo specific config 

And legacy "git repo-config" as equivalent of "git config --repo", perhaps
implemented via alias mechanism (if there woul be system-wide coniguration
file, otherwise in skeleton/template).

-- 
Jakub Narebski
Warsaw, Poland
