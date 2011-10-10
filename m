From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5/RFC 3/6] gitweb: Add manpage for gitweb
Date: Tue, 11 Oct 2011 00:02:24 +0200
Message-ID: <201110110002.24665.jnareb@gmail.com>
References: <1318098723-12813-1-git-send-email-jnareb@gmail.com> <1318098723-12813-4-git-send-email-jnareb@gmail.com> <7vr52kk1jj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 11 00:02:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDNvh-00025r-GJ
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 00:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744Ab1JJWCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 18:02:32 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47114 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540Ab1JJWCb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 18:02:31 -0400
Received: by eye27 with SMTP id 27so1853550eye.19
        for <git@vger.kernel.org>; Mon, 10 Oct 2011 15:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=evv+XzcvzlhRwTpmPZZgXkXUBzacrCtU+PCvtes1Ing=;
        b=P49y5Cm+6DiXpoePoJA4BoNnRcnwTEur5deWzjhey49wGG/k84Azv3R478dZDAoWYX
         fCGQEMSyO/U441k1ofYe75BGXGt1r5QXVmMWJCY+Xc113Z6H8FtlDV0w28d9TAzD3pG3
         0zJL5dOjhjdZfrScZd61xKT+FPYQ32JiEdNHc=
Received: by 10.223.75.137 with SMTP id y9mr34900774faj.14.1318284150038;
        Mon, 10 Oct 2011 15:02:30 -0700 (PDT)
Received: from [192.168.1.13] (abvx204.neoplus.adsl.tpnet.pl. [83.8.221.204])
        by mx.google.com with ESMTPS id b10sm33953506fam.1.2011.10.10.15.02.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 10 Oct 2011 15:02:29 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vr52kk1jj.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183261>

On Mon, 10 Oct 2011, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
> > new file mode 100644
> > index 0000000..2acdb3b
> > --- /dev/null
> > +++ b/Documentation/gitweb.txt
> > @@ -0,0 +1,703 @@
> > +gitweb(1)
> > +=========
> > +
> > +NAME
> > +----
> > +gitweb - Git web interface (web frontend to Git repositories)
> > +
> > +SYNOPSIS
> > +--------
> > +To get started with gitweb, run linkgit:git-instaweb[1] from a git repository.
> > +This would configure and start your web server, and run web browser pointing to
> > +gitweb page.
> > +
> > +See http://git.kernel.org/?p=git/git.git;a=tree;f=gitweb[] or
> > +http://repo.or.cz/w/git.git/tree/HEAD:/gitweb/[] for gitweb source code,
> > +browsed using gitweb itself.
> 
> This doesn't quite look like a "SYNOPSIS" section. Shouldn't everything
> after the first line be at the beginning of "DESCRIPTION"?

Did you mean something like (it would have to be slightly adjusted,
of course):
 
    +SYNOPSIS
    +--------
    +To get started with gitweb, run linkgit:git-instaweb[1] from a git repository.
    +
    +DESCRIPTION
    +-----------
    +This would configure and start your web server, and run web browser pointing to
    +gitweb page.

The problem is that catering to old AsciiDoc (but still used by some of
long-term-support Linux distributions) requires to have "SYNOPSIS"
section... but there is no natural synopsis for non self-hostable web
application, is there?

-- 
Jakub Narebski
Poland
