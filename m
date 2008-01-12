From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Project Hosting with git ?
Date: Sat, 12 Jan 2008 09:46:01 -0800 (PST)
Message-ID: <m3fxx3lyz0.fsf@roke.D-201>
References: <912ec82a0801120553u3621c991u7c4cb4793960159c@mail.gmail.com>
	<9b3e2dc20801120845n15d59fe6q178ba257c12a28e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Neshama Parhoti" <pneshama@gmail.com>, git@vger.kernel.org
To: "Stephen Sinclair" <radarsat1@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 18:46:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDkRO-0007Sg-BI
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 18:46:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755141AbYALRqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 12:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752301AbYALRqH
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 12:46:07 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:54873 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754781AbYALRqF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 12:46:05 -0500
Received: by ug-out-1314.google.com with SMTP id z38so627156ugc.16
        for <git@vger.kernel.org>; Sat, 12 Jan 2008 09:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=E9gT3/P6JUt2kjyBHsEpFYBuJvRqqqQHxQ1nUc+gsDA=;
        b=TPYH7fYDgzTmxZJ9eOcTi1+8oJMMZdiujacPOobGudjyB9wQ2V7sZHjqWe3AWwK/nIzfjlqNoM74LkXLBW8op6gAdhRLmoQO30R+aQ0cmGsHb4OFK5kHFwDapIEvEid9/pebFAIKnyvdPcVkKQts/c5g+QMAhVp7XLBKBRpReeI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=Os4doVe5Ju0+KArBGEZNewmTVWKvkayCEnI6h1O2AA7lJP1lH4CWXwpxgrzpUvVtko46aEqv/DBR1q6LVD+IBkBU5L39NJcBEOiS7NqgwTGpfpFAsLtN2cSFnccseUq6smNt/bkhea8oe9JeQg8wuxLgisJdeUeCW83O2itSw20=
Received: by 10.67.20.3 with SMTP id x3mr1503393ugi.3.1200159963082;
        Sat, 12 Jan 2008 09:46:03 -0800 (PST)
Received: from roke.D-201 ( [83.8.190.231])
        by mx.google.com with ESMTPS id l20sm5278636uga.62.2008.01.12.09.46.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 12 Jan 2008 09:46:01 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id m0CHjlJj022573;
	Sat, 12 Jan 2008 18:45:47 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m0CHjOgf022568;
	Sat, 12 Jan 2008 18:45:24 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <9b3e2dc20801120845n15d59fe6q178ba257c12a28e0@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70336>

"Stephen Sinclair" <radarsat1@gmail.com> writes:
> Neshama Parhoti wrote:

> > I mean, if I open a SourceForge project, I have to use cvs/subversion right ?
> >
> > Is there any way to use git ?
> 
> There is currently an open feature request on sourceforge for git support.
> Please feel free to add a comment to the thread, hopefully if enough
> people do so they'll do something about it.
> (Though I wouldn't be surprised if they're working on it.)
> 
> https://sourceforge.net/tracker/?func=detail&atid=350001&aid=1828327&group_id=1

Savannah, which is FOSS hosting site using SourceForge derived engine
(named Savane) has Git support.  What is a bit strange is that its fork
Gna!, which also uses Savane, does not have Git support.  This is because
Savannah runs "cleanup" branch of Savane while Gna! runs plain (?) Savane;
see http://git.or.cz/gitwiki/InterfacesFrontendsAndToolsWishlist#Savane

Alioth (Debian related projects hosting only) uses modified GForge
engine, which in turn is some fork of SourceForge engine, also has
git support.

Not that it helps much in adding Git support to SourceForge, as both
Savane and GForge are GPL, and IIRC SF.net engine is now closed-source.

> However, git works fine over http.  I have a project on SF which I was
> using with subversion, but I recently switched the project over to
> git.
> 
> I simply posted a bare git repo on the project website, and bang it's
> "hosted" on sourceforge.  In order to automate things a bit, I set up
> a local repo which, when I push to it, runs git-update-server-info and

You need only to enable (chmod a+x) default update hook for that.

> then uses rsync to upload the repo changes to the SF web server.
> 
> It seems to work fine.  I do occasionally git-clone the http-hosted
> repo just to make sure things are still working, and so far no
> problems.

Nice solution, can be used in with any software hosting (BerliOS or
Sarovar for example) which provides rsync or other way of syncing.

> The downside is that SF will not collect statistics on the git repo.
> However, I've been using ohloh.net to track it instead, which works
> wonderfully.

You can use GitStat in the same way as you provide Git repository,
  http://tree.celinuxforum.org/gitstat/
  http://sourceforge.net/projects/gitstat/
  http://www.ohloh.net/projects/8207?p=gitstat
but Ohloh have quite a nice features.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
