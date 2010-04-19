From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Mon, 19 Apr 2010 19:00:10 +0200
Message-ID: <201004191900.12529.jnareb@gmail.com>
References: <201004150630.44300.chriscool@tuxfamily.org> <201004182323.02311.jnareb@gmail.com> <w2pe72faaa81004182334xd6fc56d7o31420ca4af867cc2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, Sam Vilain <sam@vilain.net>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 19 19:02:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3uMj-0004TH-DJ
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 19:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754435Ab0DSRCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 13:02:25 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:30939 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754126Ab0DSRCW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 13:02:22 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2071138fgg.1
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 10:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=39AnLF9EOSXVtRkHV+Tn1My42o6t9s/fqUcEfGWXa0I=;
        b=MjLUIPuj7C0yqe+t2Xw8H5uLH1XeogYeXu/TSSsvVXj6EI4PkYdp+QokgaOLIC1Kyd
         IgTZgps8o7DImmu/eMRDa6jBv/Z2+ZpeO3lCnt0cH35R2mjiwmyHYx/lJIWiMV9ZE2b1
         P4QgZiwFx/NZvUsJFIqQfCmo+Xqd5MPtmTp1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Sf9KMDm0GHGX2YmbA1I5puEi/PMJivbjOjWgKGQEOqi1DmYMIh4vVxDjaPqwUwcGDB
         9YVc6KcxLxyppQHGqB4uClbtan9+8WkEW3Xzuig7lfgmicMkKDP/hEPZBUiFb1U5yZp/
         VATv3hAgYJvILEYQuco26WGbdN9ugpxNQ6Snw=
Received: by 10.223.92.136 with SMTP id r8mr130618fam.40.1271696418033;
        Mon, 19 Apr 2010 10:00:18 -0700 (PDT)
Received: from [192.168.1.13] (abvh23.neoplus.adsl.tpnet.pl [83.8.205.23])
        by mx.google.com with ESMTPS id g1sm499449muf.0.2010.04.19.10.00.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Apr 2010 10:00:14 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <w2pe72faaa81004182334xd6fc56d7o31420ca4af867cc2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145317>

On Mon, 19 Apr 2010, Pavan Kumar Sunkara wrote:
> On Mon, Apr 19, 2010 at 2:52 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Sun, 18 April 2010, Pavan Kumar Sunkara wrote:

>>> =====================================================
>>>
>>> Splitting gitweb and developing write functionalites
>>> Student:        Pavan Kumar Sunkara
>>>
>>> This project aims at splitting and organising the 6800 lines code of
>>> gitweb.pl into a nicely structured set of files. Not only providing
>>> the browsing functionalities in gitweb, but it also aims at developing
>>> functionalities for working on a git repository.
>>
>> First, a question: do you feel proficient enough in Perl (and in web
>> scripting in Perl), or do you prefer other programming language for
>> web, like e.g. Python?  If you feel like you would do better programming
>> in Python (or PHP, or Ruby) rather than in Perl, you could write the
>> main part of this GSoC project in said language, and provide only hooks
>> into gitweb (with the help of developers on git mailing list).
>
> I don't know perl but learning it and becoming proficient in it won't be a
> matter for me. I believe I am a fast learner and I am a computer science
> student in the top university of India. I learnt python in an hour and
> became proficient in it by a week. So learning perl won't be a matter for
> me.

I can agree that you would be able to learn Perl in a week.  I do not
think however that you can become proficient in Perl (and neither in any
other non-trivial programming language) in such short time.  The question
remains if you can be proficient enough for the task in question...

>> Second, it would probably be not "splitting ... into ... a set of
>> files", but rather "splitting gitweb into modules" (see e.g.
>> Web::Simple, SVN::Web, etc).
>>
> I would like to take the majority opinion on how to split gitweb.

Errr... my comment was about technical language / jargon used...

As to "I would like to take the majority opinion on how to split gitweb":
in my opinion you would need to have your own idea on how to split gitweb
yourself, to avoid possibility of wasting time on bikeshedding[1].  
Of course this would be based on discussion here on git mailing list.
All of this assuming that this project would get accepted.

[1] http://en.wikipedia.org/wiki/Bikeshed

>> "It aims at developing functionalities for working on a git repository."
>> Not only this is not grammatical, but also doesn't tell us the goal
>> of your project.  Is it something to edit files and create commits via
>> web, be to git-gui what git-instaweb is to gitk?  Is it about editing
>> gitweb-specific configuration, like README/README.html and 'description'
>> file from web browser?  Is it managing git repositories, i.e. create,
>> fork or clone and mirror repositories, something that Gerrit does for
>> repo.or.cz (repo.or.cz uses gitweb for viewing repositories)?
>>
> I think you understood it from the later part of my proposal.

Yes, I found it in later parts of proposal, but don't you think that
this goal of this project should be stated upfront, so that one can
know what this project is to be about from project description itself?

>>>    * User friendly graphical interface with smart UI design when
>>> compared to any other git clients or browsers.
>>
>> This is rather vague for a goal.  Do you want to be able to edit
>> files and commit them?  To add new files and remove tracked files
>> (or just untrack them)?  To cherry-pick, revert, amend commit?
>> To switch between branches and reqwind a branch?  To run and visualize
>> git-bisect?  To merge branches and resolve merge conflicts?  To rebase
>> and resolve rebase conflicts?
> 
> Yes, exactly. I think you haven't read the whole proposal before writing
> this. :-)

I have not.  I got it from discussion in parallel subthread, so I asked
for clarification.  But I should have to read the whole proposal, or
know extra information to get what you were trying to say here.  
Be specific (but not too detailed), not vague in describing goals.

>>>    * gitweb.tpl -- The template of the web page (GUI) in which
>>>      modules are embedded
>>
>> Errrr... what?  Gitweb currently does not use templating engine.
>> There are no templating engines in Perl core, writing yet another one
>> only for gitweb would be stupid, and choosing one would I guess result
>> in bikeshedding spanning whole summer and then some (which one to
>> choose: Template Toolkit with its domain specific language,  Haml-like
>> perlish templates of Template::Declare and Markapl, or pure (X)HTML
>> templates of Template::Semantic and HTML::Zoom?).
>>
>> Or did you mean lib/Gitweb/View/Default.pm - the view part of MVC
>> model, containing subroutines responsible for the look of gitweb?
>>
> I would like to add a small 50 lines code for templater class which does
> string substitution and embed the module output into tpl file. This method
> reduces the subroutines like git_header_html etc.. A small example of
> templater class can be found at http://matetelki.com/blog/?p=71. It isn't
> exactly the same i use but you get the basic idea. right ?

Currently gitweb does not use any templating engine.  Adding it would
be additional work, in my opinion not really necesary for the goals of
project (splitting gitweb is more on less needed to be able to add
large new feature, such as committool / "write" bit).  I don't think
there is enough time to (optionally) code and add templating to gitweb.

Additionally, while adding very simple templating class wouldn't be
to much violation of programming guidelines (and for example both
Mojolicius and Dancer web micro-frameworks include their own simple
templating system), I am afraid that simple string / variable 
substitution would be not enough for gitweb: loops and conditionals
would also be required.  Also we would probably want for templating
system to automatically escape (when requested).  So templating engine
grows... and then it would really be better to just use one of existing
templating modules from CPAN (http://search.cpan.org), or add adapter
to one of templating system from CPAN (like Catalyst web framework
does it).

Also if you are not proficient in Perl, I would be aftraid that your
homebrew templating engine would affect gitweb performance...


In short: no time to add templating support to gitweb.

>>>    * modules (dir) -- directory containing the write and read modules.
>>>    * lib (dir) -- some basic files like config, error_handler,
>>> templater, redirecter, htmlHelper etc..
>>
>> I'm not sure about modules/ directory: wouldn't lib/ be enough?
>> What needs to be in modules/ that cannot be put in lib/?

I guess (please correct me if I am wrong) that lib/ would contain modules
*required* by gitweb, and modules/ would contain *optional* modules
needed for extra functionality (for extra features).

>>> The new script includes config and other basic files, checks
>>> the URL, parses it, detects the module, manage session and includes
>>> the proper module.
>>
>> O.K., so after splitting the main gitweb.perl file (from which
>> gitweb.cgi would be created during build) includes configuration
>> (hmmm... shouldn't default configuration and perhaps reading
>> site-specific configuration too be put into separate Perl module?),
>> dispatch (checking and parsing URL, verifying parameters, and
>> choosing action to run), and checking which extra modules (and
>> therefore which actions) are available.
>>
>> "Manage session"... err, current gitweb does not need session
>> management.  Would the "write" module require it, even if we can assume
>> that you are the only client like with git-instaweb, and authentication
>> is not required?  I would also recommend to not reinwent the wheel,
>> and if you feel that "write" module really needs session management,
>> use some existing CPAN module for it like e.g. CGI::Session, or at least
>> borrow (some) code from it.
>>
> I mean wouldn't using session be good thing to add. It doesn't need to use
> parameters like project name all the time in the URL.

Using sessions is not without cost: you would (usually) need to store
extra information on the server.

Also one usually wants for URLs to be bookmarkeable.  One would want
to be able to send link to be copy'n'pasted.

If sessions are to make gitweb URLs shorter: forget it.  First, it would
be not necessary for your project.  Second, this is not the way to have
shorter URLs.

See also the whole idea of stateless REST interface.

>>> b) Write modules of the client:
>>>
>>>   1. Add existing repositories to the gitweb -- This will list the
>>>      given repo into gitweb config
>>
>> Note that if gitweb scans for repositories ($projects_list is
>> a directory, not a file with the list of projects), gitweb would detect
>> new repository automatically.  This feature (autodetecting
>> repositories) is fore example requirement on git.kernel.org.
>>
> Let us say if there are multiple repositories in multiple paths, wouldn't it
> be good to add a single project. This option will be available along with
> scanning $projects_root.

If gitweb is configured to scan for repositories, adding existing git
repository to gitweb doesn't make sense.  If gitweb is configured to
use static file with list of repositories, of course it would make
sense... but then the question is how would one specify location of
a new repository to add.
 

>>>  12. Push to a remote branch [git push]
>>>  13. Fetch/Pull from a remote branch [git fetch | git pull]
>>
>> You would need support for either editing config, or for interface to
>> [git remote add] first, otherwise the only remote available would be
>> 'origin'.  Unless you are interested in pushing to / fetching from
>> repository given by URL...
>>
> I think i missed that point. all functionalites with "git remote" will be
> added too.

Good.

>>> d) Usage of the client:
>>>
>>> This client can be used in 2 ways.
>>>
>>> * Install a local version using instaweb - The gitweb will be only
>>> accessible by you. You can browse through the git repository using
>>> read modules and simultaneously work on them using write modules.
>>
>> This part could be doable during GSoC 2010 (if this project gets
>> accepted), I think.
> 
> Yes. This is the main thing that is needed for a average git user.

The main simplification is that we do not need authentication here,
only perhaps requirement that server is 'localhost'.

>>> * Install on intranet - A company when installs this gitweb along with
>>> some other login and account managing scripts will be able to order
>>> their employees to login and ask them to work on the code with out the
>>> security risk of providing ssh access to the git repository host.
>>> * Install on web - Just like normal gitweb, or enable write modules to
>>> look like gist.github.com
>>
>> This would require authentication support, which I think might be too
>> much for GSoC.
> 
> Yes. I will not be doing it in GSoC and it won't be a part of gitweb, But I
> hope to provide an authentication wrapper for gitweb in future.
 
Well, unless there would be time for it after you finish all other work,
but it is a bit unlikely.

>>>    * Developing API to work with gitweb for storing information in
>>> form of a git repository
>>
>> What you mean by that?
>>
> I mean, I will be providing an web API wrapper for gitweb which can be used
> by other web developers to store any information they get into a git
> repository form and can use it to see the changes they made to the
> information step  by step.

It doesn't tell me much either.  Do you mean some kind of REST API here,
to be used from other clients, or something like that?  

Anyway I'd rather you put it in "if I have time" pile...

-- 
Jakub Narebski
Poland
