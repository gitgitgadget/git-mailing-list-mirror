From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: What are branches?
Date: Mon, 20 Apr 2009 22:47:46 +0400
Message-ID: <20090420184746.GG25059@dpotapov.dyndns.org>
References: <alpine.DEB.1.00.0904191709220.10279@pacific.mpi-cbg.de> <20090420113216.GC25059@dpotapov.dyndns.org> <49EC6596.8060208@drmicha.warpmail.net> <20090420132414.GD25059@dpotapov.dyndns.org> <alpine.DEB.1.00.0904201621290.6771@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 20 20:50:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvyZ6-0000kP-Gd
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 20:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756393AbZDTSsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 14:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756090AbZDTSsU
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 14:48:20 -0400
Received: from ti-out-0910.google.com ([209.85.142.184]:62014 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756354AbZDTSsU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 14:48:20 -0400
Received: by ti-out-0910.google.com with SMTP id 11so1400291tim.23
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 11:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=NqgCAdgXrrctac+4IK9taTWngmmBj+NDvAR2gr0hzAk=;
        b=ZRHUmY3J82YO2/oO+UeftWMa/BVT3D6XIet2oAfVraLeAPEoA/GiEVW5HTZ1S0WfyJ
         cLptYAb8kwHxdlX0M8ZF/+uTbc4xIA6pOqpJZ6Q4AZJX3tZrBQxvT2zPVmwimReOMF40
         0D0NM6Q4UKxGTIKOLIIJ2onJA6YwatoZEm0qA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fNgioPIZQm0HsWj3989FDHnCMt+H/RFnJ9XnMs1HGxeGH5gjeVE1vJBbrD397pk1hM
         z2qAtLJvokfIolwgCbLOIs3lvE30RDSGanYM+RgtgnsWxKdmMeY2/653BaVhKuonW9N/
         WAIDO4Oz+srFkXaYd3y8FSeKQ7NyBPD8zzv+4=
Received: by 10.110.2.2 with SMTP id 2mr6559868tib.2.1240253298318;
        Mon, 20 Apr 2009 11:48:18 -0700 (PDT)
Received: from localhost ([91.78.50.115])
        by mx.google.com with ESMTPS id 25sm2004932tif.36.2009.04.20.11.48.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Apr 2009 11:48:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0904201621290.6771@intel-tinevez-2-302>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117021>

On Mon, Apr 20, 2009 at 04:25:38PM +0200, Johannes Schindelin wrote:
> 
> On Mon, 20 Apr 2009, Dmitry Potapov wrote:
> 
> > When you create a new commit, it is always belong to _one_ branch and 
> > never to two or more branches.
> 
> Certainly you forgot about detached HEADs?

I suppose it is a branch without any name given to it, but it is an
advanced feature. I don't think many beginners know about it, so it
is something that can confuse beginners.

> And about the ability to 
> create new branches which point to the _exact_ same commit as other 
> branches?

In essence, we mark the starting point of the branch. Obviously, it
points to a commit that is on other branch or branches. Not every
VCS creates a commit when a new branch is created, though overhead
of creating of a new branch in other VCSes is usually much larger.

> And about the option to delete the original branch, not 
> removing the commit, or the other branches, at all?

Again, there is nothing unique about it. If I remember correctly, it is
so in CVS too. You could remove branch name, but it was still available
by ID.


Dmitry
