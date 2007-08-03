From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile git)
Date: Fri, 3 Aug 2007 07:17:15 -0400
Message-ID: <fcaeb9bf0708030417y39f84db2lb0b202af57d8fccb@mail.gmail.com>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site>
	 <46B2D547.6050406@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Marius Storm-Olsen" <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 13:17:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGv9q-0007KD-6h
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 13:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761530AbXHCLRT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 07:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761509AbXHCLRT
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 07:17:19 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:3536 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760794AbXHCLRS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 07:17:18 -0400
Received: by an-out-0708.google.com with SMTP id d31so153185and
        for <git@vger.kernel.org>; Fri, 03 Aug 2007 04:17:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AW+vB59UrxWT0Ds5iiy0FR38qzNa9x7/bUTYDG/wE/1GVPL5nVYZ0PMflUgI+owHdWm7UVXSIT/EtfA3TZ6ZjG13q09DwctaqBK81rgO9sM9QE/R3YWBYBDgUKWyuLhdT7eG7bZhLLH4LVMGrA3nNP4vgOXMvP5gmJUxbOwJxUA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tXJMc8VjHRLvOU0P23G+tsI/WBfeE4pTk7wdIkAoA3on2UbzF95PjtS4Sp9Il4oOOVAL9CFg/mmf0r+5+GEMtYonRcZIKpLJa/Jp7XR6vNSKi1Nl0SaYJE294K+lZETGA5Qn08F8KoA5GhqNkAWvpGtiHuux8xAvVnztkIJwvPs=
Received: by 10.100.9.19 with SMTP id 19mr1661838ani.1186139836031;
        Fri, 03 Aug 2007 04:17:16 -0700 (PDT)
Received: by 10.100.198.17 with HTTP; Fri, 3 Aug 2007 04:17:15 -0700 (PDT)
In-Reply-To: <46B2D547.6050406@trolltech.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54703>

On 8/3/07, Marius Storm-Olsen <marius@trolltech.com> wrote:
> > I finally broke down, waiting for the sourceforge project to get
> > granted. In the meantime, I registered a project at
> >
> > http://code.google.com/p/msysgit/
> >
> > (WARNING: temporary only!)
> >
> > Would you believe that Google code has a restriction to 20MB per
> > file, and 100MB in total, and you cannot remove files?  The same
> > Google that gives you 1TB mail space and counting?  Yes, it is
> > ludicrous.
> >
> > Anyway, you can get a complete Development environment in 3 files
> > (because one would be too large), and... oh well, just read what is
> > written on the website if you're really interested.
>
> Great effort Johannes!
> The package work perfectly on XP.
> I'm trying to get it to work under Wine, but it (Wine) is not playing
> nice with me at the moment. (The whole system barfs of "Access Denied"
> and other things. Grrr)

Even if it installs ok under Wine, git may not work properly because a
bug in dup2() not duplicating to 0-2 and some others that I think only
affect tests. So get XP if you can or prepare to fix Wine along the
way.

-- 
Duy
