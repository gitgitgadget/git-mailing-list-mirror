From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Sun, 18 Apr 2010 23:22:58 +0200
Message-ID: <201004182323.02311.jnareb@gmail.com>
References: <201004150630.44300.chriscool@tuxfamily.org> <20100418021223.GP10939@machine.or.cz> <n2le72faaa81004180152pb84cef2cn2a7eb95da64420b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, Sam Vilain <sam@vilain.net>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 18 23:47:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3cL7-0000l5-UB
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 23:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021Ab0DRVrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 17:47:37 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:8314 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753906Ab0DRVrf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 17:47:35 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1574669fga.1
        for <git@vger.kernel.org>; Sun, 18 Apr 2010 14:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Ah4EeDB1COgnU6CM32Dpzwq3ZvwZByo+eDwcjYfpOJ0=;
        b=mwhdYetQTMV8lEnEGVjA2aIfdzTis+Oz79w+YQ4+GG3xZ94kcH3+gIHg1bUW2vkTKH
         JDegS2+ebxIrL8zBV7EiAi6PcKoqEuqnEEANrh5FBMpr8AxB9sU9gJqZpCpmRR2aUPCN
         C76xxm8yjDpIkdUgdJKEFep28MAesmb1fBu0I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=wFwe8CmPAP1fjfEs/97zAhP+HNsYRAA7HLRSfv1lcmFqd6+7hS2hbX272lKxEtztbA
         aVDMUZZuLb5QpgWMLLq+/sJTxi7f/OdGRYmTYNqwbJykJW89vcfdytTcIDK6i5+bsZ12
         IPjebpV9goGFjB0NKiISXa3yPKgAxJyneMi+I=
Received: by 10.87.58.6 with SMTP id l6mr3412959fgk.15.1271625792355;
        Sun, 18 Apr 2010 14:23:12 -0700 (PDT)
Received: from [192.168.1.13] (abwr2.neoplus.adsl.tpnet.pl [83.8.241.2])
        by mx.google.com with ESMTPS id d8sm8113274fga.11.2010.04.18.14.23.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 18 Apr 2010 14:23:11 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <n2le72faaa81004180152pb84cef2cn2a7eb95da64420b1@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145250>

On Sun, 18 April 2010, Pavan Kumar Sunkara wrote:

> Here is my rewritten proposal as Christian and Petr asked me to write.
> Please go through this.

Thanks for sending this to git mailing list for review.

> =====================================================
> 
> Splitting gitweb and developing write functionalites
> Student:        Pavan Kumar Sunkara
> 
> This project aims at splitting and organising the 6800 lines code of
> gitweb.pl into a nicely structured set of files. Not only providing
> the browsing functionalities in gitweb, but it also aims at developing
> functionalities for working on a git repository.

First, a question: do you feel proficient enough in Perl (and in web
scripting in Perl), or do you prefer other programming language for
web, like e.g. Python?  If you feel like you would do better programming
in Python (or PHP, or Ruby) rather than in Perl, you could write the
main part of this GSoC project in said language, and provide only hooks
into gitweb (with the help of developers on git mailing list).

Second, it would probably be not "splitting ... into ... a set of 
files", but rather "splitting gitweb into modules" (see e.g. 
Web::Simple, SVN::Web, etc).  

I don't understand "providing the browsing functionalities in gitweb":
gitweb *has* browsing functionalities.  The whole idea of integrating
your "Web CLient" with gitweb was to avoid duplicating repository 
browsing and vieweing functionality, and to concentrate on the "edit" 
part.

"It aims at developing functionalities for working on a git repository."
Not only this is not grammatical, but also doesn't tell us the goal
of your project.  Is it something to edit files and create commits via
web, be to git-gui what git-instaweb is to gitk?  Is it about editing
gitweb-specific configuration, like README/README.html and 'description' 
file from web browser?  Is it managing git repositories, i.e. create, 
fork or clone and mirror repositories, something that Gerrit does for
repo.or.cz (repo.or.cz uses gitweb for viewing repositories)?

> 
> First I will describe my project goals, giving an overview of what I
> would like to contribute to git. Second I will give the proposed time
> line of the project which includes all the information about the
> project. Lastly I will give some information about myself.

This paragraph is in my opinion a bit unnecessary.  It would be useful
if it was 50+ pages book, or even 10+ pages article.
 
> 
> Project Goals
> 
> 1. What is the goal of your project?
>
> The project goal is to try and implement write functionalities into

What are those "write functionalities"?  There are many different 
features that can be described as "write functionalities": what exactly 
do you want to do?  This description is a bit too generic.

> gitweb along with it's browsing functionalities.

You probably meant here "into gitweb to go along with its browsing
capabilities".

> It also aims at splitting and organising the structure of gitweb
> perl script. 

Grammar.  "Another goal is to split gitweb Perl script and reorganize 
its structure".

> 
> I would like to split the gitweb script in such a way that, in the
> future others will be able to develop more functionalities for gitweb
> (let it be 'read' or 'write' actions) with the help of the framework
> like structure of the new gitweb.

O.K.

One of the goals for splitting gitweb is, I think, making it easier to 
manage gitweb codebase, i.e  making it easier to contribute to gitweb,
and to add extra features to it.

> 
> * 'read' means browsing through the code and repository
> * 'write' means working on the code and repository.

This doesn't tell us much.

> 
> 2.How would you measure its success or failure?
>
> There are two parameters which would majorly determine the success or
> failure of the project.
> 
>    * Splitting gitweb such that there should be no problem with the
> installation of gitweb across cross servers and cross systems.

That is a good idea: the requirement that installing gitweb should
be easy after splitting it, and it should work for many different
web servers, and across different systems.  Perhaps it would be good
idea to add that we want to be able to install gitweb as non root.

>    * It should be possible that the new gitweb requires less time to
> work on a git repository than any other git client.

I don't understand this sentence.  Could you rephrase this goal?
Did you wanted to say here that working with new addition to gitweb
would be as easy as working with other git GUIs (git commit tools)?

>    * User friendly graphical interface with smart UI design when
> compared to any other git clients or browsers.

This is rather vague for a goal.  Do you want to be able to edit
files and commit them?  To add new files and remove tracked files
(or just untrack them)?  To cherry-pick, revert, amend commit?
To switch between branches and reqwind a branch?  To run and visualize
git-bisect?  To merge branches and resolve merge conflicts?  To rebase
and resolve rebase conflicts?

> 
> 3.Describe your project in more detail.
>
> I would like to split the currently 6800 long piece of code in
> gitweb.pl perl script into small files which will result in better
> readability, maintainability and modifiability. The file structure of
> the new gitweb is given below and I will explain the working after it.

O.K. this describes the new goal: splitting gitweb to make it easier to
add new features, like the example "write" feature.

> 
> (From now on, I would like to call the actions of gitweb as modules of 
gitweb)
> 
> a) File Structure:
> 
>    * gitweb.pl -- Main script parsing urls and calling required
>      modules

O.K.  This would be the main application: the one responsible for 
dispatch (and perhaps parsing command line options, like git-instaweb).

>    * gitweb.tpl -- The template of the web page (GUI) in which
>      modules are embedded

Errrr... what?  Gitweb currently does not use templating engine.
There are no templating engines in Perl core, writing yet another one
only for gitweb would be stupid, and choosing one would I guess result
in bikeshedding spanning whole summer and then some (which one to
choose: Template Toolkit with its domain specific language,  Haml-like 
perlish templates of Template::Declare and Markapl, or pure (X)HTML
templates of Template::Semantic and HTML::Zoom?).

Or did you mean lib/Gitweb/View/Default.pm - the view part of MVC 
model, containing subroutines responsible for the look of gitweb?

>    * gitweb.css -- The style for the gitweb pages.
>    * gitweb.js -- javascript to make gitweb more interactive

You forgot other static files: git-logo.png and git-favicon.png.

You also forgot the build system: Makefile, or Makefile.PL (if gitweb
is to use ExtUtils::MakeMaker like Git.pm does), or Build.PL (if
gitweb is to use Module::Build instead).  The very important part.

>    * modules (dir) -- directory containing the write and read modules.
>    * lib (dir) -- some basic files like config, error_handler,
> templater, redirecter, htmlHelper etc..

I'm not sure about modules/ directory: wouldn't lib/ be enough?
What needs to be in modules/ that cannot be put in lib/?

Also you wouldn't want to split gitweb into files each containing single
subroutine, but in packages such like Gitweb::Utils, Gitweb::Repo,
Gitweb::Action::ProjectsList (this is only a proposal).

> 
> The current gitweb makefile makes a gitweb.cgi from the perl script
> and requires apache or lighttpd server for it's working.

Errr... gitweb Makefile does not require Apache or lighttpd server
(that is what you sentence seems to imply).  

What is more, gitweb requires to run any web server that supports CGI 
(including but *not limited to* Apache, lighttpd, nginx,...) or Apache 
with mod_perl (via ModPerl::Registry handler).  It s not limited to
Apache or lighttpd.

> I would like 
> to continue this process but the change will be in the gitweb perl
> script.

I don't quite understand this sentence.  What would be the build 
procedure for new gitweb + "Web Client", and how such new gitweb (with 
or without "Web Client" can be installed, optionally how such new 
gitweb with "Web Client" can be run (like git-instaweb.sh)?

> The new script includes config and other basic files, checks 
> the URL, parses it, detects the module, manage session and includes
> the proper module.

O.K., so after splitting the main gitweb.perl file (from which 
gitweb.cgi would be created during build) includes configuration
(hmmm... shouldn't default configuration and perhaps reading 
site-specific configuration too be put into separate Perl module?),
dispatch (checking and parsing URL, verifying parameters, and
choosing action to run), and checking which extra modules (and
therefore which actions) are available.

"Manage session"... err, current gitweb does not need session 
management.  Would the "write" module require it, even if we can assume 
that you are the only client like with git-instaweb, and authentication 
is not required?  I would also recommend to not reinwent the wheel,
and if you feel that "write" module really needs session management,
use some existing CPAN module for it like e.g. CGI::Session, or at least 
borrow (some) code from it.

> It then retreives the output of the module and 
> substitutes it with the gitweb.tpl template file string and gives out
> a proper HTML, CSS web page.

As I said gitweb currently do not use templating engine.  Currently 
subroutines that render gitweb actions use git_header_html and 
git_footer_html and similar subroutines... if needed.

Sidenote: I'd prefer that gitweb do not loose ability to stream its 
response, at least for some actions like 'blob_plain', 'patches', and 
what's most important for performance reasons 'snapshot' view.

> It also contains some basic library files 
> in the lib directory.

The new split gitweb, or the new gitweb.perl script?  It is not clear 
what "it" refers to here.  What does "some basic library files" means?
If you want for functional groups of subroutines from gitweb to be split 
into separate files/modules, like Gitweb::Utils with href() etc, like 
Gitweb::Repo with parse_commit and similar, please say it explicitely.

> The new gitweb uses session variables to track 
> some of the variables rather than including them in the url.

Why?  If it is possible and feasible to be sessionless, then it is 
better to do so.  Session state consumes resources on the server.
HTTP protocol is naturally stateless.

> The write 
> modules need not be working in a gitweb installation like repo.or.cz,
> so we will also have an option to disable the write modules.

That is a good idea: if "write" module is not installed, its features 
are not available.

> 
> b) Write modules of the client:
> 
>   1. Add existing repositories to the gitweb -- This will list the
>      given repo into gitweb config

Note that if gitweb scans for repositories ($projects_list is
a directory, not a file with the list of projects), gitweb would detect 
new repository automatically.  This feature (autodetecting 
repositories) is fore example requirement on git.kernel.org.

>   2. Create new/Clone repositories into a given path [git init |
>     git clone] -- This will create new repo and list it

"Create new repository" and "fork it", like Girocco does for 
repo.or.cz...

>   3. Add/Remove/Move files [git add | git rm | git mv]
>   4. Stage/Unstage files [git add | git reset]
>   5. Add files to ignore list when you click on 'Ignore' link

All the above require ability to display a state of a working directory, 
i.e. something like 'tree' view but for working area of repository (or 
the index) rather than taken from some commit.

>   6. Discard changes to a file in working copy [git reset]

O.K.

>   7. Commit to the repository with a log message and an optional
>      sign-off [git commit]

You would probably want also to display status of the files in the 
working directory (this goes along with 'tree' view for files in 
working area: we would probably want to display state for those files),
and to display diff between current HEAD and working area.  Gitweb can 
display commitdiff for a given commit, and (what is less known) diff 
between two arbitrary commits only.

>   8. Switch branches [git branch]

You would probably want creating new branches here, too.

>   9. A simple branch merging* [git merge]

Do you mean here by "simple" merge that does not lead to merge 
conflicts?

>  10. Creating tags [git tag]

O.K.  Does it include creating signed tags?

>  11. Checkout code to a specific commit or branch or tag
>      [git checkout] 

Note that "git checkout <branch>" is switching branches.

>  12. Push to a remote branch [git push]
>  13. Fetch/Pull from a remote branch [git fetch | git pull]

Yo would need support for either editing config, or for interface to 
[git remote add] first, otherwise the only remote available would be 
'origin'.  Unless you are interested in pushing to / fetching from
repository given by URL...

>  14. Garbage collection [git gc]

You would probably want to be able to gather statistics, a la
[git count-objects -v].

>  15. Search for a part of code [git grep]

Note that current gitweb includes some support for 'grep' search,
but obviously you can only search repository (some specified commit),
not index nor working area.

> 
> * - Merging two branches can be quite complicated
> 
> c) Read modules of the client: (most of this need not be written, just
> need to be organised)
> 
>   1. See the status of repository [git status]

New, needed for commit.

>   2. Show diff of the current working file compared to HEAD [git diff]

New, needed for commit.

>   3. List all the commits with pagination [git log]

Exists in gitweb.

>   4. With every commit we can
>          * Visualise trees [git ls-tree]
>          * Visualise files and diffs [git show]
>          * Visualise annotations [git blame]

All those exists already in gitweb.

>   5. List all branches including remote ones [git branch]

Remote tracking branches are not currently supported, but gitweb can 
display local branches and tags.

>   6. Search commits, branches, authors etc..

Exists in gitweb.

> 
> d) Usage of the client:
> 
> This client can be used in 2 ways.
> 
> * Install a local version using instaweb - The gitweb will be only
> accessible by you. You can browse through the git repository using
> read modules and simultaneously work on them using write modules.

This part could be doeable dusing GSoC 2010 (if this project gets 
accepted), I think.

> * Install on intranet - A company when installs this gitweb along with
> some other login and account managing scripts will be able to order
> their employees to login and ask them to work on the code with out the
> security risk of providing ssh access to the git repository host.
> * Install on web - Just like normal gitweb, or enable write modules to
> look like gist.github.com

This would require authentication support, which I think might be too 
much for GSoC.

> e) Future functionalities:
> 
>    * Implementing a file editor

O.K., although without at least being able to edit file in textarea,
or to upload new version of a file you would need something outside
"write" module to create new commits anyway.

>    * Rebasing branches
>    * Content History browser - (The gsoc 2010 idea in wiki)
>    * Implementing git bisect
>    * Cherry picking
>    * Patches management along with email

O.K.

>    * Viewing git stats in an interactive user interface

O.K.

>    * Developing API to work with gitweb for storing information in
> form of a git repository

What you mean by that?

[...]
> f) Sample Work - Mockup:
> 
> A small pre-version smaple of the project can seen in my github
> repository named 'gittor' here. It is written in python and just a
> small sampe of my work in write modules. This client is capable of
> building any other functionality and can integrate the functionalities
> of any other git tools.

That is very good... but see the question at the beginning of my email.

> TimeLine

[...]
> [June 3rd week]
> Complete module from W1 to W3

Don't forget to write automated tests, if it is possible.

Also, W1 to W3 do not tell me much here.

> 3. Academic Experience
> 
> I beleive I am a fast learner and have learnt most of the famous
> programming languages in the coding world. Some of the courses which
> are relevant to my GSoC project and proposal are:
> 
>    * Data Structures and Algortihms
>    * Advanced Computer Programming
>    * Introduction to Computer Programming
> 
> The other courses which I have taken and non-relevant to the project
> are Languages Machines and Computations, Switching Circuits and Logic
> Design, Computer Architecture and Organisation.
> 
> Different Programming languages which I am comfortable with:
> 
>    * Python
>    * PHP
>    * SQL
>    * Javascript
>    * AJAX
>    * C
>    * C++
>    * HTML
>    * CSS
>    * Java
>    * Verilog
>    * Assembly language

Unfortunately Perl (the language gitweb is written in) is missing...
See also first question in this email of mind.

AJAX is not programming language: it is technique.  (Also neither
HTML nor CSS are *programming* languages in strict sense, but that
is just nitpicking...).

[...]
> 4. Involvement with Git
> 
> I use git for most of my projects and am fascinated by it's speed and
> uasbility. I think it is and is going to be the best content tracker
> ever known to the world.
> 
> I have been subscribed to git mailing list for 2 months and have
> already put one of my ideas forward to the git developers in the
> thread linked here
> 
> I also submitted a patch which advices the users in git status to add
> a file to gitignore if he want to ignore it permanently. It can seen
> in this mailing list thread here.

Good.

-- 
Jakub Narebski
Poland
