From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] Cogito README: add a block describing team workflow with git+ssh
Date: Fri, 30 Sep 2005 09:52:11 +1200
Message-ID: <46a038f905092914524d3cd8c1@mail.gmail.com>
References: <11279754774179-git-send-email-martin@catalyst.net.nz>
	 <20050929212511.GA28106@zippy.emcb.local>
Reply-To: Martin Langhoff <martin.langhoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Sep 29 23:54:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL6KC-0000VA-TA
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 23:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbVI2VwM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 17:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbVI2VwM
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 17:52:12 -0400
Received: from qproxy.gmail.com ([72.14.204.203]:57376 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932290AbVI2VwL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 17:52:11 -0400
Received: by qproxy.gmail.com with SMTP id c12so104565qbc
        for <git@vger.kernel.org>; Thu, 29 Sep 2005 14:52:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qNcTU0TBhdNAjq4hsU6l5cfgovmbJ5epg7U3Y8dJEqn3cDa7IgHpSPaNP2SuuM8Xe78k1rgps8hIi0UuqvvqyfzNZb+TBE4wkPWbAHkTCzWecu6iwPZfGJTPfJVrpLSSjgNjlmsa4Qe83ej3NudcaFHagAEyeBI8czdOtxZjmTA=
Received: by 10.65.22.20 with SMTP id z20mr565814qbi;
        Thu, 29 Sep 2005 14:52:11 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Thu, 29 Sep 2005 14:52:11 -0700 (PDT)
To: Elfyn McBratney <beu@gentoo.org>, git@vger.kernel.org,
	Martin Langhoff <martin@catalyst.net.nz>
In-Reply-To: <20050929212511.GA28106@zippy.emcb.local>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9518>

On 9/30/05, Elfyn McBratney <beu@gentoo.org> wrote:
> > +        $ chgroup gitcommit /var/git
>
> s/chgroup/chgrp/

Ooops! Thanks for catching that

> > +        $ chmod  2775 /var/git
> > +        $ mkdir -p /var/git/projectname.git
> > +        $ GIT_DIR=/var/git/projectname.git git-init-db
>
> Hmm .. if you're you're going to be using cogito anyway, might it be an
> idea to instead do:
>
>         $ GIT_DIR=/var/git/projectname.git/.git cg-init [-I]

You only really need git on the repo server, and I think that's a plus.

> > +        $ git-push  remoteserver:/var/git/projectname.git master branchname
>
> Ditto here, tho' that'll require that remotes have been set-up, of
> course. ;)

Yes, the cogito way of doing this seems messy. Is there a simple way
to set up the remote branch and push to it?

cheers,


martin
