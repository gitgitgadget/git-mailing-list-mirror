From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: A note from the maintainer
Date: Tue, 08 Jan 2008 01:57:16 -0800 (PST)
Message-ID: <m31w8socts.fsf@roke.D-201>
References: <7vir24vgmy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 10:58:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCBDf-00033Z-Rg
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 10:58:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbYAHJ5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 04:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbYAHJ5g
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 04:57:36 -0500
Received: from mu-out-0910.google.com ([209.85.134.191]:26407 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbYAHJ5T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 04:57:19 -0500
Received: by mu-out-0910.google.com with SMTP id i10so6627128mue.5
        for <git@vger.kernel.org>; Tue, 08 Jan 2008 01:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=+e1Jm+1GZ1U35eyJkZ/jThKYLjNGIjCWA0FLsL5Z28g=;
        b=USfY537Ve3Gnvr3YVaKPdR3v4JdIbpBdEsGYVSpcmaSQN4+qblm6FjBM7tYPmqunxZpKkA4t3XFYiklpaFb6SIxJUjF34v2+19V+CuttBN8nHgoVabyyaADcSABnXt7kUiUQPKQgzOo8HwCfFpyhCPIFJcEKIiVwRtPyCHl+guA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=Aou/OPVOg70qLAxxdXZc3xCn8fZR8s0qXAmVVG4CBgkKn6bSuurf4YCfJsxnukI8tRp/yEBIaVItjtHCWXbQM0L5vGIGWepKTaSlByukY5ihcbCij85DCqVFoR+GXCVdam1fgfaJ+csP4zJNBUXBawqdhuvT44W70+Jy1K/qimw=
Received: by 10.78.131.8 with SMTP id e8mr24379779hud.52.1199786237105;
        Tue, 08 Jan 2008 01:57:17 -0800 (PST)
Received: from roke.D-201 ( [83.8.234.59])
        by mx.google.com with ESMTPS id h1sm29543700nfh.20.2008.01.08.01.57.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Jan 2008 01:57:16 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id m08A1rdm001841;
	Tue, 8 Jan 2008 11:01:54 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m08A1qaY001838;
	Tue, 8 Jan 2008 11:01:52 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <7vir24vgmy.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69854>

Junio C Hamano <gitster@pobox.com> writes:

> * IRC and Mailing list
 
> When you point at a message in a mailing list archive, using
> gmane is often the easiest to follow by readers, like this:
> 
>         http://thread.gmane.org/gmane.comp.version-control.git/27/focus=217
> 
> as it also allows people who subscribe to the mailing list as
> gmane newsgroup to "jump to" the article.

Isn't it better to give Message-ID (perhaps with addition to
some archive URLs)? This way one can search his/her own mail
archive; also (I think) all git mail archives support finding
article with given Message-ID (e.g. http://mid.gmane.org/<msg-id>
for GMane).
 
> * Repositories, branches and documentation.

> There are four branches in git.git repository that track the
> source tree of git: "master", "maint", "next", and "pu".  I may
> add more maintenance branches (e.g. "maint-1.5.3") if we have
> hugely backward incompatible feature updates in the future to keep
> an older release alive; I may not, but the distributed nature of
> git means any volunteer can run a stable-tree like that himself.

What about "offcuts" branch?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
