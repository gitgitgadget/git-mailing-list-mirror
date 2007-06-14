From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: tags and patches
Date: Thu, 14 Jun 2007 11:35:35 +0930
Message-ID: <93c3eada0706131905i1cd43fd2xcc44ce47dca8ce00@mail.gmail.com>
References: <93c3eada0706130352h3ad6857eie01e1171fdda3991@mail.gmail.com>
	 <Pine.LNX.4.64.0706131313550.4059@racer.site>
	 <93c3eada0706131715oa84eff7kc0b477a3b80e9d66@mail.gmail.com>
	 <Pine.LNX.4.64.0706140201400.4059@racer.site>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 14 04:05:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyeiR-0004m4-6i
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 04:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbXFNCFh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 22:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbXFNCFh
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 22:05:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:21453 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367AbXFNCFg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 22:05:36 -0400
Received: by ug-out-1314.google.com with SMTP id j3so557094ugf
        for <git@vger.kernel.org>; Wed, 13 Jun 2007 19:05:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GOzAiqCLnQBdJSUufk1BPHqjycGRaXNpdBaDph1lcFJdS0soorq9AVJbRlaGRFtyjCgSzSps9zxH1grGRQa1gnFCE9YUDPsb04DVQyc151+1U3AjUwdOslzUDtFIkacgEwSM/GuP5wEpw3KIyANanoFWstcYsXDCNlNIzP3AFhE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J94KOdfkqbi7LVFagknSo1qQ/EFcLkxIc4ykHeXIBuArQqD5elsytIdOl/aQO14xu1tN+cCPeKdc5uuqSCR3qpkYWmZ+8OAOiQr98Zxeg89UcNkN3rxt0SeUAciz+9242mgWdc/Y3rq2YA+54xpFMiAECmOlOk1WgfZJNssQqwo=
Received: by 10.82.174.20 with SMTP id w20mr2412938bue.1181786735284;
        Wed, 13 Jun 2007 19:05:35 -0700 (PDT)
Received: by 10.82.141.14 with HTTP; Wed, 13 Jun 2007 19:05:35 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0706140201400.4059@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50158>

On 6/14/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 14 Jun 2007, Geoff Russell wrote:
>
> > On 6/13/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > Hi,
> > >
> > > On Wed, 13 Jun 2007, Geoff Russell wrote:
> > >
> > > > Dear gits,
> > >
> > > ;-)
> > >
> > > > [...]
> > > >
> > > >        git tag v1.1
> > > >        git format-patch v1.0
> > > >        cd /tmp/newmyrepo
> > > >        git am ~/myrepo/THEPATCHNAME
> > > >
> > > > Where is tag v1.1 ?
> > >
> > > Tags are not propagated with patches. Sorry.
> >
> > Is this considered to be a bug to be eventually fixed or a feature?
>
> AFAIK patches are not supposed to _contain_ patches.

Is this a typo? I expected patches to contain tags, not other patches.

>
> What you want is probably a bundle. You don't want a collection of diffs
> with comments on them, but you want a collection to reacreate the history
> the other side has.

I didn't know about bundles but do now.  However "git bundle --help" tells
me "No manual entry for git-bundle" despite
git-bundle.html being in the Documentation directory.

I'm trying to work out if I want to use git to manage a software distribution
problem. I distribute release v1.0 to people then later I want to email them
a patch to take them from v1.0 to v1.1.  I can probably live without
the tags, but
am just surprised that patches don't send them.


Cheers,
Geoff

>
> Ciao,
> Dscho
>
>
