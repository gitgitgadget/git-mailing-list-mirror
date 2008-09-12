From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: configuring git public repository
Date: Fri, 12 Sep 2008 05:57:52 -0700 (PDT)
Message-ID: <m3vdx1o72x.fsf@localhost.localdomain>
References: <19449377.post@talk.nabble.com>
	<8e04b5820809120533o1e7da548l6868660767a5435d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sagi4 <geetha@angleritech.com>, git@vger.kernel.org
To: "Ciprian Dorin Craciun" <ciprian.craciun@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 14:59:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke8Eq-0001V3-U4
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 14:59:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753167AbYILM56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 08:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753002AbYILM56
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 08:57:58 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:63727 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752852AbYILM55 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 08:57:57 -0400
Received: by an-out-0708.google.com with SMTP id d40so95578and.103
        for <git@vger.kernel.org>; Fri, 12 Sep 2008 05:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=V9dWWxdH9eoG1nLs4AkJCrUtyAazUrTAlf0QlkmgpIc=;
        b=v2xLmMIFjLsRnQacW0OLDquVYmw2Pu2Nqes0bDDQmTpUyvnigzK4G9y2nWsvtK7jiw
         bqdfA3pLZ51AiVGJuqG/51wi3vZs+3L/jD3o/srdYARG2ompC5Dfe9KVHZbaK1n+NcF3
         dJ1/Gs0QPyKKrJLrv2L/z9an09ZOS8053JMxs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=kGzKS7WBtPEQlfYu0skslCfEZWw2VsmrRmRFnHaURrUZMIBMp2KgRRpSHg/en1gg3V
         1szun1Tuk0F/Z+CsC6drP2rEEsadFDi18NSkv+zs5HNG0syVkhWrpzYY7ytCG+V89Lt3
         dQnfuBu3N3OQ+eUwJMyBNBOTwp8m2RQKHK6ZM=
Received: by 10.103.249.19 with SMTP id b19mr2939504mus.50.1221224273994;
        Fri, 12 Sep 2008 05:57:53 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.211.228])
        by mx.google.com with ESMTPS id e10sm19310938muf.14.2008.09.12.05.57.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Sep 2008 05:57:52 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m8CCvS7g017947;
	Fri, 12 Sep 2008 14:57:39 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m8CCvBZl017942;
	Fri, 12 Sep 2008 14:57:11 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <8e04b5820809120533o1e7da548l6868660767a5435d@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95722>

"Ciprian Dorin Craciun" <ciprian.craciun@gmail.com> writes:

> On Fri, Sep 12, 2008 at 7:47 AM, sagi4 <geetha@angleritech.com> wrote:
> >
> > Hi all,
> >
> > I am new git..
> >
> > I would like to configure git as a public repository for my rails
> > application..
> >
> > Please help me..

First, I think you can find required information in many documentation
avaliable online, like "Git User's Manual" (distributed with Git), or
Got Community Book from http://git-scm.com
 
> If I'm correct, you have two major options:
> -- install your own git infrastructure:
>    -- by using git-daemon and serving the git repository throught
>       git://...;

Note that git:// protocol is meant only for _fetching_ (although you
can configure it for pushing, it is a good option only in very narrow
set of circumstances). And you would have ensure that your firewall
allows git traffic.

>    -- by using gitweb? and serving it as http://...;

Gitweb (and cgit, and git-php) is _web interface_ to repository, which
means that you can check the state of repository, view current version
and the log of changes, and many other things from a web browser.  All
of those require installing either as CGI module, or some other module
for web server having installed.

To have read-only HTTP access you only need to put your repository in
a place where your web server will see it.  Well, that and ensure that
git-update-server-info is run, for clients to be able to know latest
state of the repository.  Usually it is done using 'update' hook; it
should be enough to enable example hook (if you use bare repository as
published repository).

To be able to push via HTTP you have to set WebDAV and appropriate
permissions on web server. See the documentation.

>    -- by using ssh and serving it as ssh://... (this is
>       appropriate mostly for private repositories);

Usually you would want to restrict access by using git-shell, and
perhaps ease configuring permissions using either Gitosis (see also
BlogPosts on git wiki) or ssh_acl.

>  -- using an existing Git hosting service like:
>     -- (of course) http://repo.or.cz/
>     -- http://github.org/
>     -- http://gitorious.org/
>     -- see also http://git.or.cz/gitwiki/GitHosting
> 
> For open-source / public repositories I would opt for using an
> existing hosting service.

For Rails application I would check what other Ruby on Rails people
use. I would guess that it would be either Rubyforge or GitHub.
 
HTH.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
