From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitweb: not all files listed in commit list
Date: Thu, 4 Aug 2005 11:02:38 +0200
Message-ID: <20050804090238.GA11605@vrfy.org>
References: <20050804014916.GB10556@austin.ibm.com> <20050804083916.GL991MdfPADPa@garage.linux.student.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 05 10:49:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from mail-relay.eunet.no ([193.71.71.242])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0xrl-0002TW-O6
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 10:47:45 +0200
Received: from vger.kernel.org (vger.kernel.org [12.107.209.244])
	by mail-relay.eunet.no (8.13.1/8.13.1/GN) with ESMTP id j7498r4o026405
	for <gcvg-git@gmane.org>; Thu, 4 Aug 2005 11:08:53 +0200 (CEST)
	(envelope-from git-owner@vger.kernel.org)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbVHDJCm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 05:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262277AbVHDJCm
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 05:02:42 -0400
Received: from soundwarez.org ([217.160.171.123]:8860 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261963AbVHDJCl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2005 05:02:41 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id E6BFB56605; Thu,  4 Aug 2005 11:02:38 +0200 (CEST)
To: Olof Johansson <olof@lixom.net>, git@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <20050804083916.GL991MdfPADPa@garage.linux.student.kuleuven.ac.be>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 04, 2005 at 10:39:16AM +0200, Sven Verdoolaege wrote:
> On Wed, Aug 03, 2005 at 08:49:16PM -0500, Olof Johansson wrote:
> > Hi,
> > 
> > My apologies if this has already been found and reported; I'm not
> > tracking the list closely.
> > 
> > It seems that newly introduced files are not shown in gitweb.
> > For example, see the following commit:
> > 
> > http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=fce0d5740322b98b863f9e609f5a9bd4c06703af
> 
> That's probably because either git-core or gitweb needs updating.
> New files used to be indicated by an 'N', whereas an 'A' is used now.

Gitweb already expects the new format. The git binaries need to be updated.

Kay
