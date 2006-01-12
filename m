From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: RFC: Subprojects
Date: Thu, 12 Jan 2006 09:58:23 +0100
Message-ID: <81b0412b0601120058u6e60f009u5caf83ba574aaa7e@mail.gmail.com>
References: <43C52B1F.8020706@hogyros.de> <200601121125.33696.lan@ac-sw.com>
	 <46a038f90601112139l2f2bde5bx15102a1afcf4ec25@mail.gmail.com>
	 <200601121436.52827.lan@ac-sw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Simon Richter <Simon.Richter@hogyros.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 09:58:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwyHs-0008Nf-Fd
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 09:58:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbWALI60 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 03:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbWALI60
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 03:58:26 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:58735 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030324AbWALI6Z convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 03:58:25 -0500
Received: by nproxy.gmail.com with SMTP id o25so221100nfa
        for <git@vger.kernel.org>; Thu, 12 Jan 2006 00:58:24 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OS1+hzhyLOLwzc/MmTL6sMd+NpsHVNWRVpeptLIOdgyWZg2DV4RqtAf1nYPHUfyUBmfrXkD3RIxYkdPFU3xWA5iCOB8yihr90qRdab4+ZlQbjFnq9y1O8aAWnDn2KMPBVK0CPlFbP0bG0+qkUFW+04GG/o8yNtlbSZSzeaHG9Qs=
Received: by 10.48.248.14 with SMTP id v14mr117044nfh;
        Thu, 12 Jan 2006 00:58:23 -0800 (PST)
Received: by 10.48.248.4 with HTTP; Thu, 12 Jan 2006 00:58:23 -0800 (PST)
To: Alexander Litvinov <lan@ac-sw.com>
In-Reply-To: <200601121436.52827.lan@ac-sw.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14554>

On 1/12/06, Alexander Litvinov <lan@ac-sw.com> wrote:
> > > 1. I need to have ability to make tags, branches thru all subprojects.
> >
> > I suspect that this is a bad idea -- for the same reason as committing
> > to a subproject is a bad idea. The subprojects most likely have their
> > own external repositories -- and lifecycles of their own. The same
> > headname/branchname won't do.
>
> This is one main idea of supporing subprojects. Everything else I already can
> do. I want to be able to make tag over composite project and be able to fetch
> tagged files later. The same with branches.
>
> I cleary understand if I made tag/branch on subproject outside my composite
> project I will not be able to work with it - this is ok.
>
> But tag/branches on whole composite project is "the must".

The Linus' proposal of gitlink will probably help you here: gitlink will be
tagged as well, so you just have to teach git-checkout about checking
out subprojects.
