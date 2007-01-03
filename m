From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation/tutorial: misc updates
Date: Wed, 03 Jan 2007 15:07:41 +0100
Organization: At home
Message-ID: <engd5e$8fr$1@sea.gmane.org>
References: <sbejar@gmail.com> <200701031350.l03Doulu015800@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Jan 03 15:05:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H26k6-0004MB-C3
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 15:05:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbXACOFT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 09:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbXACOFT
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 09:05:19 -0500
Received: from main.gmane.org ([80.91.229.2]:45428 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785AbXACOFR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 09:05:17 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H26jn-0000VH-71
	for git@vger.kernel.org; Wed, 03 Jan 2007 15:05:03 +0100
Received: from host-81-190-20-195.torun.mm.pl ([81.190.20.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Jan 2007 15:05:03 +0100
Received: from jnareb by host-81-190-20-195.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Jan 2007 15:05:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-195.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35869>

Horst H. von Brand wrote:

>> +------------------------------------------------
>> +$ git branch -d experimental
>> +------------------------------------------------
>> +
>> +This command ensures that the changes in the experimental branch are
>> +already in the current branch.
>> +
> 
> Huh? This deletes the branch, it doesn't ensure changes have been saved.

It ensures that the branch we want to delete is in lineage of
current branch (otherwise we would have to use -D).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
