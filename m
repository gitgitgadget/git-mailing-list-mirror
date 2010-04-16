From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [spf:guess,iffy] Re: "Integrated Web Client for git" GSoC proposal
Date: Fri, 16 Apr 2010 11:18:30 +0200
Message-ID: <201004161118.32163.jnareb@gmail.com>
References: <201004130403.42179.chriscool@tuxfamily.org> <201004150204.42813.jnareb@gmail.com> <1271293123.6248.147.camel@denix>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Hawley <warthog9@eaglescrag.net>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Fri Apr 16 11:18:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2hhL-0006rU-GC
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 11:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757669Ab0DPJSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 05:18:45 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:27950 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753924Ab0DPJSn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 05:18:43 -0400
Received: by fg-out-1718.google.com with SMTP id d23so184077fga.1
        for <git@vger.kernel.org>; Fri, 16 Apr 2010 02:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=W3Bu8jrDGwFSPrer8xZYMgcxrZT6J/XB8JUsxXgo1fI=;
        b=WfvCpAh8KHLFvh46DLVKH1MgVQ+44E6qyW+rA0hKFF9/o4F2I0C4VcGNW2yf9zWV5k
         CITqRO1IXR6l4FdmRIPC8rkt/gHDjT8qx+rYAu6UbOzyC0yuOMgVOVTf6jv7rG4QT/oR
         e3hGYX55UnzQvGH8ar6BDhiM+43uqIfrPGb6k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Ai/7scl++yQCH8BO980cnppyy2yk4xJgyNYEyHwdlQJduvLmqScdIiBe98jQgyC8Pt
         Tv/tCfx4+jvozQPMBjhR7H4HI6n8wjHtefXC73Cz2ZHgucGidHqrkDY8hUydh6sqQeOG
         7KBEbnAvNwd6z42KOSDjRwC/IJx9z7jCFEvss=
Received: by 10.87.8.4 with SMTP id l4mr1067087fgi.1.1271409521183;
        Fri, 16 Apr 2010 02:18:41 -0700 (PDT)
Received: from [192.168.1.13] (abvv243.neoplus.adsl.tpnet.pl [83.8.219.243])
        by mx.google.com with ESMTPS id d8sm4921248fga.16.2010.04.16.02.18.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 16 Apr 2010 02:18:39 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1271293123.6248.147.camel@denix>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145059>

On Thu, 15 April 2010, Sam Vilain wrote:
> On Thu, 2010-04-15 at 02:04 +0200, Jakub Narebski wrote:

> > gitweb was and is meant to be simple, easy to install git web interface
> > (single script + some static files), with minimal dependencies outside
> > Perl core, and running with as old Perl as feasible (good Unicode support
> > is requirement that forces minimal Perl version).

By the way, is the above statement correct?  What should be the *goal*
for gitweb?  Is it running on oldest Perl possible (which IIRC is Perl
5.8.6, because gitweb needs good Unicode support)?  Is it minimal 
required non-core dependencies (core as of Perl 5.8.6)?  Is it being
easy to install (single monolithic script + some minimal number of static
files like CSS, JavaScript, images + perhaps extra files with optional
features like output caching) by hand?  Is it being easy to configure
by hand?

With local::lib it is easy to install Perl modules from CPAN locally
(in home directory), so perhaps we could ease on minimal dependencies
rule.  On the other hand gitweb is web app, and one would have to be
able to configure web server to use locally installed Perl modules,
which might be not possible; this swicthes the problem from "not being
able to install Perl modules as non-root" to "not being able to install
Perl modules that web server can use without help from sysadmin".


One of requirements is backwards compatibility of gitweb links (URLs),
both query string based, and path_info URLs.  Yet another is ability
to *scan* for projects (this is IIRC requirement for git.kernel.org),
rather than using project index file (perhaps (re)generated 
(semi)automatically).

> > 
> > Gitalist requires Catalyst web framework, which while it is (one of)
> > modern Perl web frameworks is not exactly lightweight.
> 
> Ok, I just re-checked the dependencies and my assertion that a pure-perl
> Gitalist would be possible is indeed wrong.  It certainly is though with
> very lightweight frameworks like CGI::Application.  If you are splitting
> the script up, all the best to you, but please do consider something
> like that rather than re-inventing the wheel!

There exists very many web frameworks in Perl[1][2][3][4]: Catalyst
(one of more popular, used by Gitalist), Jifty, CGI::Application (and
its offshot Titanium), Mojolicus, Dancer, Squatting, Web::Simple,...

Nowadays many (all mentioned) of those web frameworks are either built
on top of PSGI / Plack (Perl Superglue for Web Frameworks and Web Servers),
or have PSGI / Plack adapter (see http://plackperl.org).  So another
solution would be to use bare-bones Plack instead of CGI with help
of CGI.pm, perhaps also using one of URI dispatchers[5][6].  Plack/PSGI
looks like the future of Perl web scripting... but is currently quite new,
at version 0.9930.

[1]: http://www.perlfoundation.org/perl5/index.cgi?web_frameworks
[2]: http://plackperl.org/ ("Frameworks" section)
[3]: http://perl.worldken.org/search?q=web+framework
[4]: http://search.cpan.org/search?query=web+framework&mode=all

[5]: http://www.perlfoundation.org/perl5/index.cgi?web_application_dispatchers
[6]: http://github.com/miyagawa/plack-dispatching-samples


As to splitting gitweb into smaller modules (like e.g. SVN::Web)...
Gitweb isn't the largest script in git sources: gitk is.  But splitting
gitk should be much easier - git-gui is already split.  Close after
gitweb is git-svn, which probably also need splitting; and again it
would be easier to split parts of git-svn e.g into Git::SVN module,
as git-svn already depends on Git.pm.

The trouble with splitting is installing split web script.  I have no
idea how to do this in cross-webserver way, cross-distribution and
cross-system way (the filesystem hierarchy used by web server may
differ from distribution to distribution, and from operating system
to operating system).

-- 
Jakub Narebski
Poland
