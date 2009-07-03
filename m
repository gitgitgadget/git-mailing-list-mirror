From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2009 - second trial run, and question about announcing it
Date: Sat, 4 Jul 2009 00:23:56 +0200
Message-ID: <200907040023.57825.jnareb@gmail.com>
References: <200907030130.24417.jnareb@gmail.com> <7v1voyzkcg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 04 00:24:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMrB3-0008TZ-KX
	for gcvg-git-2@gmane.org; Sat, 04 Jul 2009 00:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757545AbZGCWYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2009 18:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753694AbZGCWYF
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jul 2009 18:24:05 -0400
Received: from mail-bw0-f207.google.com ([209.85.218.207]:37507 "EHLO
	mail-bw0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755087AbZGCWYE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2009 18:24:04 -0400
Received: by bwz3 with SMTP id 3so601543bwz.37
        for <git@vger.kernel.org>; Fri, 03 Jul 2009 15:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=aBd81s78SAZ4v/r3OU4cvrQF37+ghXSVjD7jxiM+RaE=;
        b=mR27hC6/ushhlhlVzQQAyFLI2ExOr69eaHnuhq6jv1IfnYo2sUKAoWnK46SdlJyAAi
         AZYfRZayiPK1TBBrJIlCe+uLnRQ2eq0oBjtnDFkqN+tfW+eG/3tKaF7lEooOjb7Aqjsn
         vThqupA8DPiw4QAnVzwUVXrvHp4OgNQAqzHWY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Q1onzgfE96eeTfmhrUUSRCwEPtxZT8H5ZBcnNCNLekZKO4eHCl7sJqBXii0PoquHDY
         oySgNSB/TgEfNTmO2HYPcSRYEmCZpg4mEy9oDN9J3AdhC7Ttv8xYj8x3IjRI+PyBzojW
         V2Ue1ojM9p42O46zWS49G7iWMCA4iVtBSw8bU=
Received: by 10.204.118.134 with SMTP id v6mr1756729bkq.31.1246659846802;
        Fri, 03 Jul 2009 15:24:06 -0700 (PDT)
Received: from ?192.168.1.13? (abvn98.neoplus.adsl.tpnet.pl [83.8.211.98])
        by mx.google.com with ESMTPS id 35sm7176126fkt.20.2009.07.03.15.24.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Jul 2009 15:24:05 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v1voyzkcg.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122710>

On Fri, 3 July 2009, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > 8. How do/did you obtain Git (install and/or upgrade)?
> >     * binary package (includes automatic updates in usual situation)
> >     * source package or script
> >     * source tarball
> >     * pull from (main) repository
> >
> > Explanation: binary package covers pre-compiled binary (e.g. from rpm
> > or deb binary packages); source package covers things like deb-src and
> > SRPMS/src.rpm; source script is meant to cover installation in
> > source-based distributions, like 'emerge' in Gentoo, and it includes
> > automatic update in source-based Linux distributions.
> >
> > Note that this question is multiple choices question because one can
> > install Git in different ways on different machines or on different
> > operating systems.
> 
> Could we please have "None of the above" here ;-)?  Just kidding.

I guess from "Just kidding" comment that you thought about "None of
the above" answer as not having git installed... which of course
doesn't make sense if one is answering "Git _User's_ Survey 2009".

But this comment brought to mind other legitimate "None of the above"
namely
  * preinstalled / sysadmin job
for the situation where either Git was preinstalled on system one
uses to work with git, or installing and upgrading programs like git
is system administrator job.


BTW. what is the situation with msysGit?  Times ago WinGit was in
"source script" category, as installing git meant compiling it,
and then installing just build version.

> > 17. How often do you use the following forms of git commands
> >     or extra git tools? (continued)
> > ...
> > Note: git-subtree is managed out of tree, as a separate project (not
> > in git.git repository, not even in contrib/ area).
> 
> Is there a reason why this particular out-of-tree script was singled out,
> and no other goodies are listed?

Originally git-subtree was submitted for inclusion, and if I remember
correctly later was considered for 'contrib/', but it was decided that
it would be better if it mature out-of-tree.  I still think (correct
me if I am wrong) that git-subtree is meant to be in git core, similar
to "git remote" and "git submodule".

> > 23. How do you compare current version with version from year ago?
> >     * better
> >     * no changes
> >     * worse
> >     * cannot say
> 
> Which version was that?  v1.5.6?  v1.6.0?  I think you would want to
> explicitly say v1.6.0 (mid Aug 2008), and it might even make sense to link
> to a list of changes since then (relnotes to 1.6.[123], at least, but
> perhaps more condensed).

Good catch!

Unfortunately links have to be plain text links only, as Survs.com
currently does not provide rich layout/language for 'text' element.

> I see you dropped "How did you hear about git" from the questionaire.  It
> was a good way to spot which response was from Linus who answered "I wrote
> it" to the question ;-).

It was dropped mainly because it doesn't, in my opinion, gives us back
some valuable information, and I tried to cut number of questions to 30.

Also git is not news now (it was born 3.5 years ago); it has wide enough
use base.  We don't need to advertise git more (I think), and searching
best avenues for that.  "How did you heard about this survey?" would
help to concentrate on best announcement channels... of course if we did
repeating "Git User's Survey" next year.


Thank you very much for all your comments!
-- 
Jakub Narebski
Poland
