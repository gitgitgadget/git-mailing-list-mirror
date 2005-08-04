From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: gitweb: not all files listed in commit list
Date: Thu, 4 Aug 2005 10:39:16 +0200
Message-ID: <20050804083916.GL991MdfPADPa@garage.linux.student.kuleuven.ac.be>
References: <20050804014916.GB10556@austin.ibm.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Fri Aug 05 10:03:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from mail-relay.eunet.no ([193.71.71.242])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0x8I-0004oQ-Pg
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 10:00:47 +0200
Received: from vger.kernel.org (vger.kernel.org [12.107.209.244])
	by mail-relay.eunet.no (8.13.1/8.13.1/GN) with ESMTP id j748apql008494
	for <gcvg-git@gmane.org>; Thu, 4 Aug 2005 10:36:51 +0200 (CEST)
	(envelope-from git-owner@vger.kernel.org)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbVHDIal (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 04:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262277AbVHDIal
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 04:30:41 -0400
Received: from thumbler.kulnet.kuleuven.ac.be ([134.58.240.45]:51677 "EHLO
	thumbler.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261944AbVHDIag (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2005 04:30:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by thumbler.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 6356E137B46
	for <git@vger.kernel.org>; Thu,  4 Aug 2005 10:30:35 +0200 (CEST)
Received: from smtp02.kuleuven.be (lepidus.kulnet.kuleuven.ac.be [134.58.240.72])
	by thumbler.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 6A93B137AE3
	for <git@vger.kernel.org>; Thu,  4 Aug 2005 10:30:33 +0200 (CEST)
Received: from garage.linux.student.kuleuven.ac.be (garage.linux.student.kuleuven.be [193.190.253.84])
	by smtp02.kuleuven.be (Postfix) with ESMTP id 53A812CAA02
	for <git@vger.kernel.org>; Thu,  4 Aug 2005 10:30:33 +0200 (CEST)
Received: (qmail 10727 invoked by uid 500); 4 Aug 2005 08:39:17 -0000
To: Olof Johansson <olof@lixom.net>
Mail-Followup-To: Olof Johansson <olof@lixom.net>,
	git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <20050804014916.GB10556@austin.ibm.com>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by KULeuven Antivirus Cluster
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 03, 2005 at 08:49:16PM -0500, Olof Johansson wrote:
> Hi,
> 
> My apologies if this has already been found and reported; I'm not
> tracking the list closely.
> 
> It seems that newly introduced files are not shown in gitweb.
> For example, see the following commit:
> 
> http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=fce0d5740322b98b863f9e609f5a9bd4c06703af

That's probably because either git-core or gitweb needs updating.
New files used to be indicated by an 'N', whereas an 'A' is used now.
 
skimo
