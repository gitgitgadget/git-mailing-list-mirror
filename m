From: Sean Estabrooks <seanlkml@sympatico.ca>
Subject: Re: "Not currently on any branch"
Date: Fri, 2 Oct 2009 16:15:37 -0700
Message-ID: <BLU0-SMTP927FF0174DF8AAD58644A8AED20@phx.gbl>
References: <loom.20091002T215942-663@post.gmane.org>
	<81b0412b0910021446nb07e7e9l465f588168297fe9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Tim <timothyjwashington@yahoo.ca>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 03 01:15:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtrLv-0003Q5-4V
	for gcvg-git-2@lo.gmane.org; Sat, 03 Oct 2009 01:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754228AbZJBXPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 19:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753001AbZJBXPm
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 19:15:42 -0400
Received: from blu0-omc3-s19.blu0.hotmail.com ([65.55.116.94]:3188 "EHLO
	blu0-omc3-s19.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752327AbZJBXPm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Oct 2009 19:15:42 -0400
Received: from BLU0-SMTP92 ([65.55.116.72]) by blu0-omc3-s19.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 2 Oct 2009 16:15:46 -0700
X-Originating-IP: [12.49.64.26]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from localhost ([12.49.64.26]) by BLU0-SMTP92.blu0.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 2 Oct 2009 16:15:44 -0700
In-Reply-To: <81b0412b0910021446nb07e7e9l465f588168297fe9@mail.gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.16.6; i586-redhat-linux-gnu)
X-OriginalArrivalTime: 02 Oct 2009 23:15:45.0211 (UTC) FILETIME=[44DFD8B0:01CA43B6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129469>

On Fri, 2 Oct 2009 23:46:53 +0200
Alex Riesen <raa.lkml@gmail.com> wrote:

> On Fri, Oct 2, 2009 at 22:08, Tim <timothyjwashington@yahoo.ca> wrote:
> > What's the most straightforward & cleanest way to merge my changes in the
> > headless branch to my 'ui-integration' branch?
> 
> Assuming you use a Bourne shell:
> 
> $ prev=$(git rev-parse HEAD)
> $ git checkout ui-integration && git merge $prev
> 
> 

You could also rely on the reflog to avoid the need to store off the
previous HEAD value, so just:

$ git checkout ui-integration && git merge HEAD@{1}


Sean
