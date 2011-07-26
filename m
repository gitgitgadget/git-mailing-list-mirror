From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Questions for "Git User's Survey 2011"
Date: Tue, 26 Jul 2011 12:37:42 +0200
Message-ID: <201107261237.43140.jnareb@gmail.com>
References: <201107252233.02088.jnareb@gmail.com> <4E2DE708.8050805@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Tue Jul 26 12:37:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qlf1O-0003sm-G1
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 12:37:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130Ab1GZKhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 06:37:50 -0400
Received: from mail-ey0-f171.google.com ([209.85.215.171]:40663 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211Ab1GZKhs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 06:37:48 -0400
Received: by eye22 with SMTP id 22so419724eye.2
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 03:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=tmtGG2bs1sgoYMZyiV9Zu4KwX6msyJfv9e5pXL35K0o=;
        b=qpiz7mfrCkJH2oZRPfAROHBhz8KmSLO1cAOznKV+Tq/QeMGa05DXZti1/eVhwuXqy5
         KNJw5jAylSTHohEJnTo+6/AD0Qe4LkX4MmP0AaWVH08obu0sRJfa5FI7rMHlrXXlDLfA
         L15cDNc+DiJ5vIm946n55Q0OLDPwRaoAtH0LM=
Received: by 10.14.9.93 with SMTP id 69mr2020808ees.203.1311676667503;
        Tue, 26 Jul 2011 03:37:47 -0700 (PDT)
Received: from [192.168.1.13] (abvw23.neoplus.adsl.tpnet.pl [83.8.220.23])
        by mx.google.com with ESMTPS id c18sm261985eeb.4.2011.07.26.03.37.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Jul 2011 03:37:46 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4E2DE708.8050805@cisco.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177853>

On Mon, 25 Jul 2011, Phil Hord wrote:
> On 07/25/2011 04:33 PM, Jakub Narebski wrote:

> > NOTES:
> > ^^^^^^
> > How to detect if it is msysGit or Cygwin from within?  Perhaps we
> > should have just "MS Windows"...
> 
> I think it's useful to know which build they're using, cygwin or msys. 
> Hopefully it's not too confusing for them and they can answer correctly.

Well, there is this option for those confused:

 + some MS Windows (unknown or other)

I should probably add

 + operating system independent (JGit, Dulwich, git.js, ...)
 
> > === 11. What Git interfaces, implementations and frontends do you use? ===
> > (multiple choice, with other)
> >
> >  + JGit (Java implementation), e.g. via Eclipse plugin
> >  + NGit or Git# (C# implementation)
> >  + Dulwich (pure-Python implementation)
> >  + Git::PurePerl (Perl implementation)
> >  + git.js (JavaScript)
> >  + libgit2 bindings
> >
> >  + git (core) commandline
> >  + Cogito (DEPRECATED)
> >  + Easy Git
> >  + Pyrite
> >  + I don't know, I only use (graphical) tools
> >
> >  + pg aka Patchy Git (DEPRECATED)
> >  + StGIT
> >  + Guilt
> >  + TopGit
> >
> >  + Zit
> >
> >  + other (please specify)
> 
> You can probably drop pg and Cogito now, yes?

Yes, I think they can be dropped now.  They were important in previous
years to check if people are still using those deprecated porcelains,
but nowadays I don't think it is necessary.
 
> Looking at the 2010 results, I would add these GUIs to the main list:
> git-gui (core)
> gitk (core)
> gitX
> gitg
> git-cola
> TortoiseGit
> SmartGit
> Git Extensions
> Giggle

Hmmm... they can be considered "frontends", but there are too many GUIs
there to add them all.  They are in a way in "12. What kind of Git tools
do you use?"

Perhaps it would be good idea to add free-form (because of sheer number
of git tools) to write git tools etc. that one uses.
 
> Is there room for Gerrit here, or maybe in one of the other questions?
> Also, cgit and other web interfaces, I suppose.

They are in "12. What kind of Git tools do you use?".

> > === 16. Which of the following Git features do you use? ===
> > (multiple choice, with other)
> >
> >  + localization of command-line messages (i18n)
> >  + git bundle (off-line transport)
[...]
> >  + one-way interaction with other SCMs (from SCM to git)
> >  + two-way interaction with other SCMs (from SCM to git, from git to SCM)
> >
> >  + git-cvsserver
> >  + git notes
> >
> >
> >  + Other, please specify
> >
> > NOTES:
> > ^^^^^^
> > The problem is come up not with exhaustive list of features: there are
> > too many of them to list.  The problem is coming up with list of
> > important and used enough often features.
> >
> > So: what features should be included in this list?  What features
> > should be removed from above list of answers?
> 
> bridges (git-svn, hg-git, git-p4, etc.)

I think they are included in "two-way interaction with other SCMs",
but perhaps that should be made more clear.

> IDE integration (Eclipse, Netbeans, etc.)

This isn't strictly _git_ feature, and is in "12. What kind of Git tools
do you use?" anyway.


Thank you very much for your comments.
-- 
Jakub Narebski
Poland
