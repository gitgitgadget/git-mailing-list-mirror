From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [topgit] tg update error
Date: Thu, 12 Feb 2009 15:42:43 +0530
Message-ID: <20090212101243.GC21074@skywalker>
References: <cc723f590902120009w432f5f61xd6550409835cdbb7@mail.gmail.com> <20090212084811.GA14261@piper.oerlikon.madduck.net> <20090212092558.GB21074@skywalker> <20090212093227.GC20248@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aneesh Kumar <aneesh.kumar@gmail.com>, git@vger.kernel.org
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu Feb 12 11:14:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXYaK-00045P-Li
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 11:14:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756355AbZBLKMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 05:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756233AbZBLKMx
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 05:12:53 -0500
Received: from e28smtp03.in.ibm.com ([59.145.155.3]:44110 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755738AbZBLKMw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 05:12:52 -0500
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp03.in.ibm.com (8.13.1/8.13.1) with ESMTP id n1CACkri004391
	for <git@vger.kernel.org>; Thu, 12 Feb 2009 15:42:46 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id n1CACpok3104920
	for <git@vger.kernel.org>; Thu, 12 Feb 2009 15:42:51 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id n1CACj3Z028827
	for <git@vger.kernel.org>; Thu, 12 Feb 2009 15:42:45 +0530
Received: from skywalker (skywalker.in.ibm.com [9.124.35.32])
	by d28av01.in.ibm.com (8.13.1/8.12.11) with ESMTP id n1CAChSd028815
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 12 Feb 2009 15:42:45 +0530
Content-Disposition: inline
In-Reply-To: <20090212093227.GC20248@piper.oerlikon.madduck.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109595>

On Thu, Feb 12, 2009 at 10:32:27AM +0100, martin f krafft wrote:
> also sprach Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> [2009.02.12.1025 +0100]:
> > Latest git and topgit. Moving to git version v1.6.1.3 fixed the issue.
> > I can reproduce the problem on any test repo. Just do a tg update after
> > committing something in the dependent branch.
> 
> This is not helpful. Please provide a complete transcript of
> a session reproducing the problem.
> 
> I can't:
> 
> piper:~/.tmp/cdt.GydvBgiR|test|% git --version                                                   #10010
> git version 1.6.0.2

The git version that failed for me is the latest git. As I mentioned
above git version 1.6.1.3 works fine.

Can you test with
$git --version
git version 1.6.2.rc0.55.g30aa4f

-aneesh
