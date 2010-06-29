From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: recovering orphaned commit
Date: Tue, 29 Jun 2010 08:17:16 -0700
Message-ID: <20100629151716.GF2337@spearce.org>
References: <AANLkTiks6yPfdTACQwZlqv8PPPEg3RYGMx1Q1PjT0nRu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mahesh Vaidya <forvaidya@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 29 17:41:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTcwK-0004bH-9e
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 17:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756458Ab0F2Pla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 11:41:30 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:34174 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696Ab0F2Pl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 11:41:29 -0400
Received: by pvc7 with SMTP id 7so185833pvc.19
        for <git@vger.kernel.org>; Tue, 29 Jun 2010 08:41:28 -0700 (PDT)
Received: by 10.142.194.1 with SMTP id r1mr3121129wff.260.1277824689680;
        Tue, 29 Jun 2010 08:18:09 -0700 (PDT)
Received: from localhost ([172.18.104.34])
        by mx.google.com with ESMTPS id g30sm1587934rvb.0.2010.06.29.08.17.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Jun 2010 08:17:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTiks6yPfdTACQwZlqv8PPPEg3RYGMx1Q1PjT0nRu@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149909>

Mahesh Vaidya <forvaidya@gmail.com> wrote:
>  I have a situation like this; 2 commits.
> 
> Example -
> 
>  2899684ed173063354b7fe4f5ec7216e7d953e2c	 <-- HEAD  ( say C1)
>  1ef67de1a0d6e97470a8c827d2989317600532ff                    ( say C2)
> 
> To see file at C2 ; I have done git reset --hard C2; I could see the file.
> Now want go to C1 ; Ho do I Determine C1  using git command ?

Use `git reflog show` or `git log -g` to view the reflog entries
for HEAD.  It will show you the different states HEAD had, so you
want to find the state before you reset to C2, that would be C1.

-- 
Shawn.
