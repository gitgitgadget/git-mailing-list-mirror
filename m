From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [topgit] tg update error
Date: Thu, 12 Feb 2009 14:55:58 +0530
Message-ID: <20090212092558.GB21074@skywalker>
References: <cc723f590902120009w432f5f61xd6550409835cdbb7@mail.gmail.com> <20090212084811.GA14261@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Aneesh Kumar <aneesh.kumar@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 10:27:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXXr5-0004Qo-T9
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 10:27:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428AbZBLJ0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 04:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751903AbZBLJ0H
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 04:26:07 -0500
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:60999 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbZBLJ0G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 04:26:06 -0500
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp05.au.ibm.com (8.13.1/8.13.1) with ESMTP id n1C9OU7X024378
	for <git@vger.kernel.org>; Thu, 12 Feb 2009 20:24:30 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id n1C9QLxO1122340
	for <git@vger.kernel.org>; Thu, 12 Feb 2009 20:26:21 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n1C9Q3Sw011454
	for <git@vger.kernel.org>; Thu, 12 Feb 2009 20:26:04 +1100
Received: from skywalker (kamarali-009124046169.in.ibm.com [9.124.46.169])
	by d23av01.au.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id n1C9Px6s011353
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 12 Feb 2009 20:26:03 +1100
Content-Disposition: inline
In-Reply-To: <20090212084811.GA14261@piper.oerlikon.madduck.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109588>

On Thu, Feb 12, 2009 at 09:48:11AM +0100, martin f krafft wrote:
> also sprach Aneesh Kumar <aneesh.kumar@gmail.com> [2009.02.12.0909 +0100]:
> > doing a tg update with latest git gives the below error
> > 
> > [extent_validate@linux-2.6]$ tg update
> > fatal: Refusing to point HEAD outside of refs/heads/
> > [extent_validate@linux-2.6]$
> 
> Which version? And could you please provide (a lot) more information
> about your repository or make it available?
> 

Latest git and topgit. Moving to git version v1.6.1.3 fixed the issue.
I can reproduce the problem on any test repo. Just do a tg update after
committing something in the dependent branch.

-aneesh
