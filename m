From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: Ext4 patchqueue corrupted ?
Date: Fri, 11 Jul 2008 18:01:09 +0530
Message-ID: <20080711123109.GA14606@skywalker>
References: <20080711034606.GA779@skywalker> <20080711084715.GT10151@machine.or.cz> <20080711122617.GA8154@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Ming Ming Cao <cmm@us.ibm.com>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: linux-ext4-owner@vger.kernel.org Fri Jul 11 14:32:35 2008
Return-path: <linux-ext4-owner@vger.kernel.org>
Envelope-to: gcfe-linux-ext4@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHHnd-0005I9-2J
	for gcfe-linux-ext4@gmane.org; Fri, 11 Jul 2008 14:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbYGKMbi (ORCPT <rfc822;gcfe-linux-ext4@m.gmane.org>);
	Fri, 11 Jul 2008 08:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755359AbYGKMbh
	(ORCPT <rfc822;linux-ext4-outgoing>);
	Fri, 11 Jul 2008 08:31:37 -0400
Received: from e28smtp04.in.ibm.com ([59.145.155.4]:59372 "EHLO
	e28esmtp04.in.ibm.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751977AbYGKMbh (ORCPT
	<rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Jul 2008 08:31:37 -0400
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28esmtp04.in.ibm.com (8.13.1/8.13.1) with ESMTP id m6BCVEAl025702;
	Fri, 11 Jul 2008 18:01:14 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m6BCUqoF1441800;
	Fri, 11 Jul 2008 18:00:52 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.13.1/8.13.3) with ESMTP id m6BCVDlk003636;
	Fri, 11 Jul 2008 18:01:14 +0530
Received: from skywalker ([9.77.123.86])
	by d28av05.in.ibm.com (8.13.1/8.12.11) with ESMTP id m6BCVA8X003566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Jul 2008 18:01:12 +0530
Content-Disposition: inline
In-Reply-To: <20080711122617.GA8154@mit.edu>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88114>

On Fri, Jul 11, 2008 at 08:26:17AM -0400, Theodore Tso wrote:
> On Fri, Jul 11, 2008 at 10:47:15AM +0200, Petr Baudis wrote:
> >   very puzzling; I have backed up the broken objects store, can you
> > repush, please? I'm curious about how this could have happenned;
> > repo.or.cz now uses Git from latest next, which is a rather strange
> > coincidence. ;-) Or did any of the pushers do anything special about
> > pushin to the repository recently?
> 
> Aneesh, did you try repushing?  It looks like the objects store is
> broken again.

I don't have permission to push to the repo. I can only pull.


> 
> Pasky, in case it helps, and for the benefit of Linux-ext4 folks, I
> have a copy of my repository (which I last pushed to repo.or.cz around
> noon US/Eastern yesterday) here:
> 
>      git://git.kernel.org/pub/scm/fs/ext2/ext4-patch-queue.git
> 
> My most recent HEAD is ec90e411; if anyone has something more recent,
> they can send it to me via:
> 
>      git bundle create /tmp/to-send ec90e411
> 
> ... and then e-mailing me as an attachment the resulting binary file
> in /tmp/to-send.
> 

-aneesh
