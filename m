From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: What's new in git.git master branch
Date: Fri, 2 Dec 2005 09:36:52 +0100
Message-ID: <20051202083652.GA4824@c165.ib.student.liu.se>
References: <7vlkz5n3r1.fsf@assigned-by-dhcp.cox.net> <20051201085433.GA7866@c165.ib.student.liu.se> <7vmzjljgwo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 09:38:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ei6Q4-0000p7-Dn
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 09:37:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbVLBIhE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 03:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbVLBIhE
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 03:37:04 -0500
Received: from [85.8.31.11] ([85.8.31.11]:47291 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S932455AbVLBIhD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Dec 2005 03:37:03 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id D5EB64102; Fri,  2 Dec 2005 09:46:39 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1Ei6PU-00047v-00; Fri, 02 Dec 2005 09:36:52 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmzjljgwo.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13105>

On Thu, Dec 01, 2005 at 01:38:47AM -0800, Junio C Hamano wrote:

> Currently, rename result is recorded by using "git-update-index
> --cacheinfo" to populate the index.  This method unfortunately
> can only create a stage0 entry.  We can go two ways.  One way is
> to support "register this mode/sha1 tuple at stageN for path" to
> update-index.  Another would be for merge-recursive to first
> construct three trees with the final directory structure
> (i.e. prepare three temporary trees with renames applied) and
> run read-tree 3-way merge on these temporary trees.  I suspect
> the former is probably of lesser impact.  Thoughts?

If we really want to do this then the former is certainly easier from
the perspective of git-merge-recursive.

- Fredrik
