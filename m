From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: serious problem with `git format-patch' & `git am'
Date: Thu, 26 Feb 2009 17:11:45 -0800 (PST)
Message-ID: <m3ljrsvg0e.fsf@localhost.localdomain>
References: <20090225.230352.177616203.wl@gnu.org>
	<6HVVE8kW9V0CsNfW21a_Tqpt2s-IrJbt2_qdAvQ8r1tetEhb6jr18g@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Werner LEMBERG <wl@gnu.org>, git@vger.kernel.org, keithp@keithp.com
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Feb 27 02:13:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcrHy-0007jz-RR
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 02:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321AbZB0BLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 20:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751967AbZB0BLv
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 20:11:51 -0500
Received: from mail-bw0-f178.google.com ([209.85.218.178]:44043 "EHLO
	mail-bw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbZB0BLt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 20:11:49 -0500
Received: by bwz26 with SMTP id 26so801761bwz.37
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 17:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=VlLSKFC04C1F10Gw/OYtoo8rvChfK7zBDsHx600CIC0=;
        b=RYbcticUSCZlpEu/WDPfU92lUT89m+ThtoRSjE2oy5B3xH5qLC/bOQVbXDwxYouoQs
         bJ8iUIrBFIcb5xLJGI9WDnHVlyZA8ygSj7zua9LmhJXSF+StQHmY+KfDFvNzl0SQOjJ8
         R3qp4e6dfUwm4vDpKXSfHy35BmyexDWnpk5Vo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=SmuYZI/CQlA7MN+tvBI4BjJ/ew8rIl4dk+Pc2uY8oBhU/JxDwaj9jLxY+tQeoJmK4q
         sRru7wL+XUQGSri3c9NJeLLTlAk/LVxE2hxyv1Fs1LMIBt2A9z/87FttTCxHJy33Zm5E
         5Vuvv0dbzliWwrYM3ANmy7pvzc+2A49Gdm5f0=
Received: by 10.103.115.12 with SMTP id s12mr984216mum.89.1235697105971;
        Thu, 26 Feb 2009 17:11:45 -0800 (PST)
Received: from localhost.localdomain (abvt245.neoplus.adsl.tpnet.pl [83.8.217.245])
        by mx.google.com with ESMTPS id y2sm1052301mug.45.2009.02.26.17.11.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Feb 2009 17:11:45 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n1R1DOLW011959;
	Fri, 27 Feb 2009 02:13:24 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n1R1DL1D011956;
	Fri, 27 Feb 2009 02:13:21 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <6HVVE8kW9V0CsNfW21a_Tqpt2s-IrJbt2_qdAvQ8r1tetEhb6jr18g@cipher.nrlssc.navy.mil>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111625>

Brandon Casey <casey@nrlssc.navy.mil> writes:
> Werner LEMBERG wrote:
> > [both version 1.6.0.2 and git from 2009-01-24]
> >
> > I'm going to convert the FreeType CVS repository to git, using Keith
> > Packard's `parsecvs'.

>From what I understand it is not maintained, is not incremental, and
requires access to *,v files.  Why not use more modern and actively
developed cvs2git tool from cvs2svn project[1]?

[1] http://cvs2svn.tigris.org
[2] http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
    "Interaction with other Revision Control Systems" section

> >  It sometimes happens that there are git entries
> > titled
> > 
> >   *** empty log message ***
> > 
> > I want to massage the git repository before publishing it, replacing
> > those entries with something more meaningful.
> > 
> > The last time I tested this (using git 1.5.something, I no longer
> > remember the exact version) I did the following:
> > 
> >   . git format-patch <start>..HEAD
> >     git reset --hard <start>
> > 
> >   . Edit the `Subject:' field in the created *.patch files where
> >     necessary.
> > 
> >   . git am --whitespace=nowarn *.patch

You can use the following alternate solutions:

 * git rebase --interactive (perhaps with --root option if your git
   supports it, or cherry-pick root commit by hand if it does not),
   changing 'pick' to 'edit' for patches (commits) that you want to
   modify commit message.

 * if you can automate the changes, i.e. if you can script it, the
   best solution would be to use git-filter-branch instead; or use
   fast-export / fast-import pair with your filter in the middle.

> > 
> > Unfortunately, this no longer works as before, and since I can't find
> > a hint in the docs about this change I wonder whether it is a bug.
> > 
> > With git 1.5.something, if the first paragraph of the commit message
> > (as output by parsecvs) looks like this
> > 
> >    foo foo foo foo
> >    bar bar bar bar
> >    baz baz baz baz
> > 
> > it is emitted exactly as-is (after `git format-patch' & `git am');
> > gitk shows `foo foo foo foo' as the first line.  However, git version
> > 1.6.0.2 and the current git both convert newlines to spaces in the
> > first paragraph!  I now get
> > 
> >   foo foo foo foo bar bar bar bar baz baz baz baz
> > 
> > as the beginning of the commit message which is VERY bad since
> > CVS-style entries often have a long first paragraph, causing
> > ugly-looking, overlong lines.

This is caused by the fact that git-am assumes that subject line goes
as first line of commit message, with empty line separating it from
the rest of commit message which comes from the body of email.

It used to preserve line breaking in Subject: line, if it was broken
into lines using continuation style for email headers, but that was
wrong solution in the intended use case (applying patches from email,
patches conforming to git commit message conventions), as Subject:
line could have been broken into multiple lines by the _transport_
layer, and not intended to be broken.

> > 
> > In case this is an intended change I ask you urgently to provide an
> > option to get back the old behaviour of `git format-patch' & `git am'.
> 
> I was not aware of this behavior, but it looks like the '-k' option for
> both format-patch and git-am is what you want to use.  It will prevent
> mailinfo from munging the commit message.

I think you want undocumented but for the git-am usage (e.g. 'git am
-h') --rebasing option to git-am, which makes git-am preserve Subject:
line formatting, _including_ line breaking (I think that -k/--keep
does preserve subject, but does not preserve line breaking; I haven't
checked this, though).  Note that in this case you would have to make
git-format-patch to not output subject prefix ([PATCH]).

See how git-rebase.sh does it.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
