From: Rico Secada <coolzone@it.dk>
Subject: Re: Git pull doesn't get the tags
Date: Fri, 22 Oct 2010 14:23:08 +0200
Message-ID: <20101022142308.f275aefe.coolzone@it.dk>
References: <20101022053747.a5427cad.coolzone@it.dk>
	<4CC153A0.7080605@debugon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 22 14:25:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9Ggb-00038t-Lk
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 14:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754634Ab0JVMZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 08:25:23 -0400
Received: from smtp.fullrate.dk ([90.185.1.42]:64602 "EHLO smtp.fullrate.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754099Ab0JVMZW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 08:25:22 -0400
Received: from workp4 (4304ds5-ynoe.0.fullrate.dk [90.185.142.211])
	by smtp.fullrate.dk (Postfix) with SMTP id BA27B9CFB4
	for <git@vger.kernel.org>; Fri, 22 Oct 2010 14:25:19 +0200 (CEST)
In-Reply-To: <4CC153A0.7080605@debugon.org>
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159684>

On Fri, 22 Oct 2010 11:04:32 +0200
Mathias Lafeldt <misfire@debugon.org> wrote:

I managed to overlook the info from the man page, sorry.

But what does "but tags that do not point at objects reachable from the
branch heads that are being tracked will not be fetched by this
mechanism" mean?

When is an object not reachable from the branch head? In the repo only
the master branch exist, and one repo is cloned from the other.

> On 10/22/2010 05:37 AM, Rico Secada wrote:
> > Hi.
> > 
> > I am working on a repo on my desktop and I got a clone on my laptop.
> > I needed to pull the new stuff from my desktop unto my laptop, and I
> > noticed that tags doesn't get pulled.
> > 
> > The laptop access the desktop using NFS and I am using "git pull
> > NFS_SOURCE".
> > 
> > The repos are identical except that a few files has been updated
> > and a new tag has been added.
> > 
> > Why doesn't pull get the tag?
> > 
> > Best regards.
> 
> Try git pull --tags.
> 
> From git-pull's manpage:
> 
> -t
> --tags
>         Most of the tags are fetched automatically as branch
>         heads are downloaded, but tags that do not point at
>         objects reachable from the branch heads that are being
>         tracked will not be fetched by this mechanism.  This
>         flag lets all tags and their associated objects be
>         downloaded. [...]
> 
> -Mathias
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
