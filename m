From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: Re: defaults for where to merge from
Date: Wed, 28 Feb 2007 20:56:58 +0100
Message-ID: <45E5DE8A.2080101@lu.unisi.ch>
References: <es450f$d58$1@sea.gmane.org>	 <200702281522.14965.andyparkins@gmail.com>	 <Pine.LNX.4.64.0702281526270.15314@reaper.quantumfyre.co.uk>	 <Pine.LNX.4.63.0702281643200.22628@wbgn013.biozentrum.uni-wuerzburg.de> <81b0412b0702281045u2e511ebfie14a7b718531f8c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Paolo Bonzini <bonzini@gnu.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 28 20:57:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMUvJ-00061f-Nm
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 20:57:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbXB1T5M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 14:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751862AbXB1T5M
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 14:57:12 -0500
Received: from server.usilu.net ([195.176.178.200]:24699 "EHLO mail.usilu.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751861AbXB1T5L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 14:57:11 -0500
Received: from [1.240.182.245] ([213.140.22.65] RDNS failed) by mail.usilu.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 28 Feb 2007 20:57:06 +0100
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
In-Reply-To: <81b0412b0702281045u2e511ebfie14a7b718531f8c4@mail.gmail.com>
X-OriginalArrivalTime: 28 Feb 2007 19:57:06.0645 (UTC) FILETIME=[9FA9C050:01C75B72]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41001>


> As is an option to disable the feature. I.e. for scripts, which create 
> branches
> blindly, without knowing they working on a remote branch.
> So, please, provide an option to do what git-checkout/git-branch did 
> before:
> which is just create the branch, nothing more.

This does create the branch and nothing more.  It sets up "git pull" to 
do the obvious thing, but does not do anything more.  The branch is left 
in the same state than without the patch.  So the scripts will still 
work unless they create branches blindly, and blindly do a "git pull" 
expecting it to do the unobvious thing.

Paolo
