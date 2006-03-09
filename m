From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [PATCH 0/3] Teach git-blame about renames
Date: Thu, 9 Mar 2006 08:30:14 +0100
Message-ID: <20060309073014.GA1500@c165.ib.student.liu.se>
References: <20060308225412.GA461@c165.ib.student.liu.se> <7v4q28h38p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 09 08:30:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHFbN-0001Vp-0M
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 08:30:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWCIHaV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 02:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWCIHaV
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 02:30:21 -0500
Received: from 85.8.31.11.se.wasadata.net ([85.8.31.11]:1411 "EHLO
	mail6.wasadata.com") by vger.kernel.org with ESMTP id S1750806AbWCIHaV
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Mar 2006 02:30:21 -0500
Received: from c165 (85.8.2.189.se.wasadata.net [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id C7C5D40FD; Thu,  9 Mar 2006 08:45:47 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1FHFbC-0003nh-00; Thu, 09 Mar 2006 08:30:14 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4q28h38p.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17400>

On Wed, Mar 08, 2006 at 04:27:02PM -0800, Junio C Hamano wrote:
> > -static int compare_tree(struct tree *t1, struct tree *t2)
> > +int compare_tree(struct tree *t1, struct tree *t2)
> > ...
> > -static int same_tree_as_empty(struct tree *t1)
> > +int same_tree_as_empty(struct tree *t1)
> 
> Maybe the names are a bit too generic to be used as a global?
> 

Yes.. maybe. They are quite general though. Any suggestions for better
names? We could prefix everything in revision.h with "rev_" or
something like that.


Thanks for the comments. I will send an updated patch series soon.

- Fredrik
