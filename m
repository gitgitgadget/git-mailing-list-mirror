From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Newbie questions about moving around repositories
Date: Fri, 15 Jun 2007 23:58:38 +0200
Message-ID: <20070615215838.GA6785@steel.home>
References: <1b5a37350706150652y7710c380l79e785cba8f6b02e@mail.gmail.com> <81b0412b0706150718t2382648aw25959844f52c5c02@mail.gmail.com> <1b5a37350706151019u2bf81e81me05d13ea9bf40591@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ed Schofield <edschofield@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 23:59:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzJor-00075Y-JI
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 23:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755714AbXFOV6m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 17:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755707AbXFOV6l
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 17:58:41 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:34353 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755714AbXFOV6k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 17:58:40 -0400
Received: from tigra.home (Facfb.f.strato-dslnet.de [195.4.172.251])
	by post.webmailer.de (fruni mo48) (RZmta 7.2)
	with ESMTP id I01c05j5FInBTm ; Fri, 15 Jun 2007 23:58:38 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 73824277BD;
	Fri, 15 Jun 2007 23:58:38 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 129D9D261; Fri, 15 Jun 2007 23:58:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1b5a37350706151019u2bf81e81me05d13ea9bf40591@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzzcF9vUQA=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50279>

Ed Schofield, Fri, Jun 15, 2007 19:19:58 +0200:
> On 6/15/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> >On 6/15/07, Ed Schofield <edschofield@gmail.com> wrote:
> >> 1. I would like to move my repository (including all branches) from
> >> directory A to a directory B on a different filesystem.
> >> [snip]
> >
> >Just copy it.
> >[snip]
> >... but fix that .git/objects/info/alternates files in the repos left to
> >point to the new location of the moved directory.
> 
> 
> Thanks, Alex! Changing this and .git/branches/origin worked a treat.
> 

.git/branches is obsoleted. Branch configuration is in .git/config now
