From: Tom Prince <tom.prince@ualberta.net>
Subject: Re: Stashing untracked files
Date: Sat, 29 Sep 2007 18:23:21 -0400
Message-ID: <20070929222320.GB2947@hermes.priv>
References: <46FE9924.7080006@theory.org> <Pine.LNX.4.64.0709292201400.28395@racer.site> <EEE8F630-AE62-4425-96A0-239D54724DF4@lrde.epita.fr> <Pine.LNX.4.64.0709292248400.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Benoit SIGOURE <tsuna@lrde.epita.fr>,
	Neil Macneale <mac4-git@theory.org>, git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Sep 30 00:21:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ibkge-0000eP-Jj
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 00:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756370AbXI2WVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 18:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752270AbXI2WVS
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 18:21:18 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:34320 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756507AbXI2WVR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 18:21:17 -0400
Received: by py-out-1112.google.com with SMTP id u77so6086557pyb
        for <git@vger.kernel.org>; Sat, 29 Sep 2007 15:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=K4jRrI7GJubdzB3hKlepH4kUgCrRnRqmjUdTszcvmLc=;
        b=TbYER3Etz3wAn08FgJTlFNJm6+1XQCmxOFZTBJF2amf6XFepJh4VsREKUETJUQIkKaZIxPbVdo+EHaS5kRSA6wx/hW5zX07bSUb9Fql35YDczosKe89XX3CLMdJuFeGXAtc5PqaCVpOUCsVD3BzGZaY6hLiZlGHDqznCq0TKgN8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=GNlJlKxzstB/LviM2sUlZB0nXFAPvE8GDNmnumALqf2isPpVi1MzpJ1YoDn+tvaKIfU3xAqDzrnOK6y6JGONYigQ5aklFyBZ5uLPpTYoHs63a0vFjgGE37iJ9p5u++DhBJrlyxfigqZIotvqXVoVwpvjM8uLIfYe4JIufYX7vVM=
Received: by 10.35.17.8 with SMTP id u8mr5553129pyi.1191104464502;
        Sat, 29 Sep 2007 15:21:04 -0700 (PDT)
Received: from hermes ( [65.95.175.80])
        by mx.google.com with ESMTPS id f75sm4439339pye.2007.09.29.15.21.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 29 Sep 2007 15:21:03 -0700 (PDT)
Received: by hermes (nbSMTP-1.00) for uid 500
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	Tom; Sat, 29 Sep 2007 18:23:22 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709292248400.28395@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59502>

> > You could stash untracked files that are not ignored (I personally 
> > ignore *.o, *.a and the like).
> 
> And what if you happen to forget to ignore that?  Or if you happen to 
> have an strace log in some file (which you did not ignore either)?
> 
> Thanks, but I think the semantics of git stash is pretty well defined.  
> And it means that you stash away _tracked_ content that was not yet 
> committed.
> 
> I mean, you can have your desired behaviour with
> 
> $ git add .
> $ git stash
> 
> but if we were to fulfil your wish and change the default behaviour, there 
> is no way back to the current behaviour (which I happen to find pretty 
> sane).

But

git add .
git stash
git stash apply

will not be a no-op any more.

It doesn't need to be a default, but there are certainly times when I would
find the option to stash untracked files convenient.

  Tom
