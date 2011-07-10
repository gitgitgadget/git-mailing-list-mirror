From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH v2] git-rebase.txt: clarify that --abort checks out
 <branch>
Date: Sun, 10 Jul 2011 14:07:45 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1107100841400.2491@debian>
References: <1309574324-6833-1-git-send-email-martin.von.zweigbergk@gmail.com> <1310092069-19708-1-git-send-email-martin.von.zweigbergk@gmail.com> <7vzkkog3ia.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Drew Northup <drew.northup@maine.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 10 20:07:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QfyQ9-0006nM-Qu
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jul 2011 20:07:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756193Ab1GJSHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jul 2011 14:07:53 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:43994 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755717Ab1GJSHw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2011 14:07:52 -0400
Received: by qwk3 with SMTP id 3so1569351qwk.19
        for <git@vger.kernel.org>; Sun, 10 Jul 2011 11:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=m/oXGq/ZEapSL/Rrq2CTnZTzRXhqb5NWfomguAj3H2c=;
        b=VKcU7dEWU6b61xLYMQWCZmiBHRtVV/Xh3yEGC/p+8c1cGXhOzMyzjUB9zg947Nqcwh
         F85QL8bonOKjAv2jQP1AHDDwec/d2UAxSUsxsKL1nOB652VybAzLQ1kFNX/IFt7She7d
         87CtwPlq9b6RfxF+lruMKuEeDv2h5gwM3fDgU=
Received: by 10.224.126.79 with SMTP id b15mr2481202qas.206.1310321271310;
        Sun, 10 Jul 2011 11:07:51 -0700 (PDT)
Received: from [192.168.1.101] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id u10sm6381160qct.33.2011.07.10.11.07.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Jul 2011 11:07:49 -0700 (PDT)
X-X-Sender: martin@debian
In-Reply-To: <7vzkkog3ia.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176825>

Hi Junio,

On Fri, 8 Jul 2011, Junio C Hamano wrote:

> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
> 
> >  --skip::
> >  	Restart the rebasing process by skipping the current patch.
> > diff --git a/git-rebase.sh b/git-rebase.sh
> > index d7855ea..f2d4c72 100755
> > --- a/git-rebase.sh
> > +++ b/git-rebase.sh
> > @@ -58,7 +58,7 @@ ignore-whitespace! passed to 'git apply'
> >  C=!                passed to 'git apply'
> >   Actions:
> >  continue!          continue rebasing process
> > -abort!             abort rebasing process and restore original branch
> > +abort!             abort rebasing process and reset HEAD to <branch>
> >  skip!              skip current patch and continue rebasing process
> >  "
> 
> I don't think it is quite right to use placeholder notation here, unless
> you are talking about "git rebase --abort <branch>", and you are of course
> not in this case. Perhaps
> 
> 	abort and check out the original branch
> 
> might be slightly better. I dunno.

Good point. I tried to find something that would fit in 80 characters
and still not use the term "check out", but I agree that using the
placeholder notation was a bad idea. I would be happy to change to
your proposed text. Drew, I hope you don't mind.

> As the user knows these help text are all about "rebase", I do not think
> it is worth repeating "rebasing process" over and over again.

I was thinking about changing "rebasing process" to "rebase", but
removing it completely is probably good idea.

Patch coming up.
