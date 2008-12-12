From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Clarifying "invalid tag signature file" error message from git filter-branch (and others)
Date: Fri, 12 Dec 2008 08:53:40 -0800 (PST)
Message-ID: <m3bpvhgws3.fsf@localhost.localdomain>
References: <c5df85930812110214k2e12d926m60856fb630d45e80@mail.gmail.com>
	<P7E-5meNX4tXFurN9mnRguFHdJG1jaZYTn6WxFFpECSJ68KyYT3wqQ@cipher.nrlssc.navy.mil>
	<c5df85930812111434m879f1faq80c64286714c3a1f@mail.gmail.com>
	<LhfS_uc2B_Gje7rXd1882RMsQfSRjOEsBT24Z1Yza_bWhgl9lI-ZhQ@cipher.nrlssc.navy.mil>
	<c5df85930812111559p287ea6afk54a9759302288d5e@mail.gmail.com>
	<87zlj1hd0r.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "James Youngman" <jay@gnu.org>,
	"Brandon Casey" <casey@nrlssc.navy.mil>, git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Fri Dec 12 17:55:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBBIN-0005oG-0Z
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 17:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759434AbYLLQxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 11:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759432AbYLLQxp
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 11:53:45 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:4857 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757773AbYLLQxn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 11:53:43 -0500
Received: by fg-out-1718.google.com with SMTP id 19so741765fgg.17
        for <git@vger.kernel.org>; Fri, 12 Dec 2008 08:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=tfSAZSKVc2i7QyAdY9UvGmtx4V9jqL4zu17FWp8nKdA=;
        b=bccF4SIv61yL5EfT3AyAYAn6nmVTY9zDDOICGNhCC9QsoZqLG/AEMopPjUcw45epz0
         7Ptyro5MW4HwPQ3mNGxs82iBe5PtF6RxuxG0xhtpFdtSaJ0A/rBzyup4G44uaiZi7tHk
         tEIY5SkiYgYktBuafHhbkH1JjlfpcvtD7Avas=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=kk+s+bCssObE7X/llRBGx99LpCeECIJduPgMpF8M3H5cwA+NhbElenT88K5S2KZa19
         u4Zr8p4C0N6K+1aKzhYXNdVju2bCjEJTmqLM4wfQkTk3O750+m2cRto61C4CdXJ757pQ
         NZ9RIufiOoOCw3dHKzlzvvUIKc51JbjzLQZRk=
Received: by 10.86.59.18 with SMTP id h18mr2121910fga.77.1229100822135;
        Fri, 12 Dec 2008 08:53:42 -0800 (PST)
Received: from localhost.localdomain (abvt119.neoplus.adsl.tpnet.pl [83.8.217.119])
        by mx.google.com with ESMTPS id l12sm1660889fgb.14.2008.12.12.08.53.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Dec 2008 08:53:40 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBCGrbYc000854;
	Fri, 12 Dec 2008 17:53:38 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBCGrXqp000850;
	Fri, 12 Dec 2008 17:53:33 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <87zlj1hd0r.fsf@rho.meyering.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102916>

Jim Meyering <jim@meyering.net> writes:

> I used parsecvs, probably with git-master from the date of
> the initial conversion (check the archives for actual date).
> That was long enough ago that it was almost certainly before
> git-mktag learned to be more strict about its inputs.
> 
> James, since you're about to rewrite the history, you may want to
> start that process from a freshly-cvs-to-git-converted repository.
> 
> I'm not very happy about using parsecvs (considering it's not
> really being maintained, afaik), so if the git crowd
> can recommend something better, I'm all ears.

The page you might want to consult is

  http://git.or.cz/gitwiki/InterfacesFrontendsAndTools

There you have listed git-cvsimport, which uses cvsps to extract
patchset, is in git, and is as far as I know the only tool that allow
incremental import; parsecvs which requires access to *,v files you
use; cvs2svn (cvs2git) which have learned fast-import format and can
be used to import (fast) CVS repositories, but incremental import
(difficult that it is) is only in plans, AFAIK.

So I would recommend trying cvs2svn / cvs2git.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
