From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] git-rev-parse: Fix --short= option parsing
Date: Sat, 18 Feb 2006 16:07:09 +0100
Message-ID: <20060218150709.GA16846@diku.dk>
References: <20060218011053.GB2562@diku.dk> <7v7j7tupn7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 16:07:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FATg5-0004J3-VG
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 16:07:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWBRPHO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Feb 2006 10:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWBRPHN
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Feb 2006 10:07:13 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:24296 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1751282AbWBRPHM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Feb 2006 10:07:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id D130952D576;
	Sat, 18 Feb 2006 16:07:11 +0100 (CET)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 27702-10; Sat, 18 Feb 2006 16:07:10 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 2C5EE52D569;
	Sat, 18 Feb 2006 16:07:10 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 7DAC06DFD1E; Sat, 18 Feb 2006 16:06:11 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 120FA61BDE; Sat, 18 Feb 2006 16:07:10 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v7j7tupn7.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16415>

Junio C Hamano <junkio@cox.net> wrote Fri, Feb 17, 2006:
> > Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
> >
> > ---
> > commit 013b99654ee464856d266a72f0203d0fee2b0d11
> > tree 3c961d6ebb8b9805ee3950ec081679de15f5a9ba
> > parent 16e2efc524d181cf46dcb252532139a0aff4a28f
> > author Jonas Fonseca <fonseca@diku.dk> Sat, 18 Feb 2006 02:05:11 +0100
> > committer Jonas Fonseca <fonseca@antimatter.localdomain> Sat, 18 Feb 2006 02:05:11 +0100
> 
> BTW, what git-based tool do you use to spit out this ugly format?

Cogito.

> Full object name of the parent commit is useful only if the
> recipient has that object, and it is not one of mine, so it is
> unlikely nobody but you would have it.  Name of the tree is what
> you would get _after_ applying this patch, so it also is not
> very useful for e-mail communication.

I agree most of this is useless and will look into making a patch to so
Cogito will also use the more or less standard From and Date headers
with parent prefixed to the diff.

-- 
Jonas Fonseca
