From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git version numbers
Date: Mon, 30 May 2011 07:40:44 -0700 (PDT)
Message-ID: <m3ipssxnf4.fsf@localhost.localdomain>
References: <20110528201321.GA26017@Imperial-SD-Longsword>
	<20110530033428.GB27691@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Mazid <timmazid@hotmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 30 16:40:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR3eG-0008EI-7A
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 16:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756690Ab1E3Okr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 10:40:47 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36604 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609Ab1E3Okr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 10:40:47 -0400
Received: by fxm17 with SMTP id 17so2491846fxm.19
        for <git@vger.kernel.org>; Mon, 30 May 2011 07:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=qX2OPGkzJZFkxAg+PzPYHEnQsTtlWwcwnJajwZtDnk8=;
        b=gcAL0N8PsRsFqO5kzBSh1brjh3077m72mnJInBaWQnxNDUzcACE67oss7sgCh/yOSC
         7gTfHi1f0E5ri/oAQo5ODBEm6zppMQngSuNPhzzUVSo2pzPZgdmC5CV6a8FsppEJxRdM
         OdnDlVCgeH5FSjRVV/iYfulEpJZZxx4CpwuGA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=A+FD37qJ1Y4LJgCO2fWFgyvhTBqOEYJXg4hS4Ivrh5UPB7+u51Rmv6rXtRx2ZEAOVW
         v6WW3GjIbhM9pSJhPzsre6TyDhSUJKprtfwjUUMfNpTNYrmb4yTiPfEFj7ZCFuIot/X+
         67Vo3rZ/JZsF2NAtuGCajkOoqcvutOqB0EiAA=
Received: by 10.223.24.134 with SMTP id v6mr5650079fab.146.1306766445690;
        Mon, 30 May 2011 07:40:45 -0700 (PDT)
Received: from localhost.localdomain (abvg56.neoplus.adsl.tpnet.pl [83.8.204.56])
        by mx.google.com with ESMTPS id l26sm764420fam.45.2011.05.30.07.40.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 30 May 2011 07:40:44 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p4UEe8ae013394;
	Mon, 30 May 2011 16:40:19 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p4UEdjXY013386;
	Mon, 30 May 2011 16:39:45 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20110530033428.GB27691@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174749>

Jeff King <peff@peff.net> writes:

> On Sun, May 29, 2011 at 06:13:22AM +1000, Tim Mazid wrote:
> 
> > I was just looking at various versioning schemes, and I came to wonder
> > about git's one.  Most of the ones out there are of the form
> > <major>.<minor>.<optional revision> (j.n.r), but git seems to have four,
> > as in 1.7.5.1.
> > 
> > So, I was wondering what you call each number in the git version; does
> > the usual j.n.r apply to the last three and the first one is a
> > "mystery"?  What is the official versioning scheme?  Does each number
> > have any particular name?
> 
> In "git w.x.y.z", the decoding is:
> 
>   w: not likely to change short of a complete rewrite or something that
>      is quite incompatible (i.e., will probably remain "1" for quite a
>      while)
> 
>   x: when this jumps, it is a "big" version change, meaning there may be
>      some minor incompatibilities or new ways of doing things. For
>      example, 1.5.0 introduced a lot of usability changes and the
>      separate-remotes layout became the default. In 1.6.0, we stopped
>      shipping "git-*" in the PATH, and started using some new packfile
>      features by default. And so on. If you want to know more, see
>      Documentation/RelNotes/1.?.0.txt.
> 
>   y: when this jumps, it is a new release cut from master that does not
>      have any "big" changes as above. There will be new features and
>      some bugfixes. See RelNotes/1.7.?.txt for examples of what gets
>      included.
> 
>   z: when this jumps, it is a bugfix release based on the feature
>      release w.x.y. See RelNotes/1.7.5.?.txt for examples.
> 
> Getting more to your actual question, I don't know that we ever use any
> particular name like "major" or "minor" for any of them. We do tend to
> use the terms "feature release" for w.x.y releases and "bugfix release"
> for w.x.y.z.

I think that Git numbering scheme actually follows semver pattern used
by Linux kernel... which just moved to  scheme: x.y[.z] from w.x.y[.z]
one

  https://lkml.org/lkml/2011/5/29/204 == http://lwn.net/Articles/445222/
  http://lwn.net/Articles/445223/  

Though git still breaks backward compatibility from time to time
(separate remotes by default, not shipping git-xxx n PATH,
deltabaseoffset, submodules, packed refs, push safeties, status !=
commit --dry-run) which change 'x'... though probably could change 'w'
(thought we be then at 7.x with git codebase still in flux...).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
