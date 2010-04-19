From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: GSoC 2010: "Integrated Web Client for git" proposal
Date: Mon, 19 Apr 2010 12:05:54 +0530
Message-ID: <q2se72faaa81004182335r29505960lcc956e981673de7@mail.gmail.com>
References: <201004150630.44300.chriscool@tuxfamily.org>
	 <20100418021223.GP10939@machine.or.cz>
	 <n2le72faaa81004180152pb84cef2cn2a7eb95da64420b1@mail.gmail.com>
	 <201004182323.02311.jnareb@gmail.com>
	 <w2pe72faaa81004182334xd6fc56d7o31420ca4af867cc2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 19 08:36:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3kaV-0002oy-Kv
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 08:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282Ab0DSGf7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Apr 2010 02:35:59 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60027 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018Ab0DSGf7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Apr 2010 02:35:59 -0400
Received: by gwj19 with SMTP id 19so87449gwj.19
        for <git@vger.kernel.org>; Sun, 18 Apr 2010 23:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=C1y6SNxnBELfDso88cNCPElD1E8ue3uL3HxhCBx9wfU=;
        b=kln3TOxVIQnpGzTghZnzeh5Vb9unC+dJ7Npu8WQ9CdJFT5mFYwe92d1p9R4FZ3yhYJ
         kazHEwwWaXfy34uQ8ODLbZU91BA7nKzIxMlqLKF8vzFcm0HDTv6IfFS+J23Pz19pK1sx
         YDHKhHXVGXwq50pGDA+6Fp6CD+FZYU/A5u7VM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=jxcHVeqv4x9XsF+X5R4wHlUuwEQ1xHHyZBSbiO1ZkLoEcK/hK3Xs2Y89TS3HosW6Ze
         s+J/41YlrJUN9GDNb33sIMwq5TsX58LX1HLghSV2w1J9yr5txQK9EjCs0jII6P6tOgWv
         WDRMRXbO1NRxlaaV9i7mvkz9fRW8xwetjX8L0=
Received: by 10.90.118.4 with HTTP; Sun, 18 Apr 2010 23:35:54 -0700 (PDT)
In-Reply-To: <w2pe72faaa81004182334xd6fc56d7o31420ca4af867cc2@mail.gmail.com>
Received: by 10.91.55.17 with SMTP id h17mr2900671agk.57.1271658954579; Sun, 
	18 Apr 2010 23:35:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145266>

On Mon, Apr 19, 2010 at 2:52 AM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
>
> On Sun, 18 April 2010, Pavan Kumar Sunkara wrote:
>
> > Here is my rewritten proposal as Christian and Petr asked me to wri=
te.
> > Please go through this.
>
> Thanks for sending this to git mailing list for review.
>
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >
> > Splitting gitweb and developing write functionalites
> > Student: =A0 =A0 =A0 =A0Pavan Kumar Sunkara
> >
> > This project aims at splitting and organising the 6800 lines code o=
f
> > gitweb.pl into a nicely structured set of files. Not only providing
> > the browsing functionalities in gitweb, but it also aims at develop=
ing
> > functionalities for working on a git repository.
>
> First, a question: do you feel proficient enough in Perl (and in web
> scripting in Perl), or do you prefer other programming language for
> web, like e.g. Python? =A0If you feel like you would do better progra=
mming
> in Python (or PHP, or Ruby) rather than in Perl, you could write the
> main part of this GSoC project in said language, and provide only hoo=
ks
> into gitweb (with the help of developers on git mailing list).
>

I don't know perl but learning it an d becoming proficient in it won't
be a matter for me. I believe I am a fast learner and I am a computer
science student in the top university of India. I learnt python in an
hour and became proficient in it by a week. So learning perl won't be
a matter for me.

>
> Second, it would probably be not "splitting ... into ... a set of
> files", but rather "splitting gitweb into modules" (see e.g.
> Web::Simple, SVN::Web, etc).
>

I would like to take the majority opinion on how to split gitweb.

>
> I don't understand "providing the browsing functionalities in gitweb"=
:
> gitweb *has* browsing functionalities. =A0The whole idea of integrati=
ng
> your "Web CLient" with gitweb was to avoid duplicating repository
> browsing and vieweing functionality, and to concentrate on the "edit"
> part.
>

It's an error with my grammar. I actually mean to concentrate on "edit"=
 part.
I am not a native english speaker. So, there might be problems with my =
grammar.

>
> "It aims at developing functionalities for working on a git repositor=
y."
> Not only this is not grammatical, but also doesn't tell us the goal
> of your project. =A0Is it something to edit files and create commits =
via
> web, be to git-gui what git-instaweb is to gitk? =A0Is it about editi=
ng
> gitweb-specific configuration, like README/README.html and 'descripti=
on'
> file from web browser? =A0Is it managing git repositories, i.e. creat=
e,
> fork or clone and mirror repositories, something that Gerrit does for
> repo.or.cz (repo.or.cz uses gitweb for viewing repositories)?
>

I think you understood it from the later part of my proposal.

>
> >
> > First I will describe my project goals, giving an overview of what =
I
> > would like to contribute to git. Second I will give the proposed ti=
me
> > line of the project which includes all the information about the
> > project. Lastly I will give some information about myself.
>
> This paragraph is in my opinion a bit unnecessary. =A0It would be use=
ful
> if it was 50+ pages book, or even 10+ pages article.

Yeah, you are right but I would like to give some introduction.

>
> >
> > Project Goals
> >
> > 1. What is the goal of your project?
> >
> > The project goal is to try and implement write functionalities into
>
> What are those "write functionalities"? =A0There are many different
> features that can be described as "write functionalities": what exact=
ly
> do you want to do? =A0This description is a bit too generic.
>
> > gitweb along with it's browsing functionalities.
>
> You probably meant here "into gitweb to go along with its browsing
> capabilities".

Yes.

>
> > It also aims at splitting and organising the structure of gitweb
> > perl script.
>
> Grammar. =A0"Another goal is to split gitweb Perl script and reorgani=
ze
> its structure".
>

Sorry again. As I said, I am not very good in english. I can just commu=
nicate.

>
> >
> > I would like to split the gitweb script in such a way that, in the
> > future others will be able to develop more functionalities for gitw=
eb
> > (let it be 'read' or 'write' actions) with the help of the framewor=
k
> > like structure of the new gitweb.
>
> O.K.
>
> One of the goals for splitting gitweb is, I think, making it easier t=
o
> manage gitweb codebase, i.e =A0making it easier to contribute to gitw=
eb,
> and to add extra features to it.
>

Yeah.

>
> >
> > * 'read' means browsing through the code and repository
> > * 'write' means working on the code and repository.
>
> This doesn't tell us much.
>
> >
> > 2.How would you measure its success or failure?
> >
> > There are two parameters which would majorly determine the success =
or
> > failure of the project.
> >
> > =A0 =A0* Splitting gitweb such that there should be no problem with=
 the
> > installation of gitweb across cross servers and cross systems.
>
> That is a good idea: the requirement that installing gitweb should
> be easy after splitting it, and it should work for many different
> web servers, and across different systems. =A0Perhaps it would be goo=
d
> idea to add that we want to be able to install gitweb as non root.
>
> > =A0 =A0* It should be possible that the new gitweb requires less ti=
me to
> > work on a git repository than any other git client.
>
> I don't understand this sentence. =A0Could you rephrase this goal?
> Did you wanted to say here that working with new addition to gitweb
> would be as easy as working with other git GUIs (git commit tools)?

yes. I mean it.

>
> > =A0 =A0* User friendly graphical interface with smart UI design whe=
n
> > compared to any other git clients or browsers.
>
> This is rather vague for a goal. =A0Do you want to be able to edit
> files and commit them? =A0To add new files and remove tracked files
> (or just untrack them)? =A0To cherry-pick, revert, amend commit?
> To switch between branches and reqwind a branch? =A0To run and visual=
ize
> git-bisect? =A0To merge branches and resolve merge conflicts? =A0To r=
ebase
> and resolve rebase conflicts?

Yes, exactly. I think you haven't read the whole proposal before
writing this. :-)

>
> >
> > 3.Describe your project in more detail.
> >
> > I would like to split the currently 6800 long piece of code in
> > gitweb.pl perl script into small files which will result in better
> > readability, maintainability and modifiability. The file structure =
of
> > the new gitweb is given below and I will explain the working after =
it.
>
> O.K. this describes the new goal: splitting gitweb to make it easier =
to
> add new features, like the example "write" feature.
>
> >
> > (From now on, I would like to call the actions of gitweb as modules=
 of
> gitweb)
> >
> > a) File Structure:
> >
> > =A0 =A0* gitweb.pl -- Main script parsing urls and calling required
> > =A0 =A0 =A0modules
>
> O.K. =A0This would be the main application: the one responsible for
> dispatch (and perhaps parsing command line options, like git-instaweb=
).
>
> > =A0 =A0* gitweb.tpl -- The template of the web page (GUI) in which
> > =A0 =A0 =A0modules are embedded
>
> Errrr... what? =A0Gitweb currently does not use templating engine.
> There are no templating engines in Perl core, writing yet another one
> only for gitweb would be stupid, and choosing one would I guess resul=
t
> in bikeshedding spanning whole summer and then some (which one to
> choose: Template Toolkit with its domain specific language, =A0Haml-l=
ike
> perlish templates of Template::Declare and Markapl, or pure (X)HTML
> templates of Template::Semantic and HTML::Zoom?).
>
> Or did you mean lib/Gitweb/View/Default.pm - the view part of MVC
> model, containing subroutines responsible for the look of gitweb?
>

I would like to add a small 50 lines code for templater class which
does string substitution and embed the module output into tpl file.
This method reduces the subroutines like git_header_html etc.. A small
example of templater class can be found at
http://matetelki.com/blog/?p=3D71. It isn't exactly the same i use but
you get the basic idea. right ?

>
> > =A0 =A0* gitweb.css -- The style for the gitweb pages.
> > =A0 =A0* gitweb.js -- javascript to make gitweb more interactive
>
> You forgot other static files: git-logo.png and git-favicon.png.
>
> You also forgot the build system: Makefile, or Makefile.PL (if gitweb
> is to use ExtUtils::MakeMaker like Git.pm does), or Build.PL (if
> gitweb is to use Module::Build instead). =A0The very important part.

Sorry. I forgot to mention them.

>
> > =A0 =A0* modules (dir) -- directory containing the write and read m=
odules.
> > =A0 =A0* lib (dir) -- some basic files like config, error_handler,
> > templater, redirecter, htmlHelper etc..
>
> I'm not sure about modules/ directory: wouldn't lib/ be enough?
> What needs to be in modules/ that cannot be put in lib/?
>
> Also you wouldn't want to split gitweb into files each containing sin=
gle
> subroutine, but in packages such like Gitweb::Utils, Gitweb::Repo,
> Gitweb::Action::ProjectsList (this is only a proposal).
>

As i said above, I would like to take the majority opinion on how to
split gitweb.

>
> >
> > The current gitweb makefile makes a gitweb.cgi from the perl script
> > and requires apache or lighttpd server for it's working.
>
> Errr... gitweb Makefile does not require Apache or lighttpd server
> (that is what you sentence seems to imply).
>
> What is more, gitweb requires to run any web server that supports CGI
> (including but *not limited to* Apache, lighttpd, nginx,...) or Apach=
e
> with mod_perl (via ModPerl::Registry handler). =A0It s not limited to
> Apache or lighttpd.

Sorry for my grammar.

>
> > I would like
> > to continue this process but the change will be in the gitweb perl
> > script.
>
> I don't quite understand this sentence. =A0What would be the build
> procedure for new gitweb + "Web Client", and how such new gitweb (wit=
h
> or without "Web Client" can be installed, optionally how such new
> gitweb with "Web Client" can be run (like git-instaweb.sh)?
>

I would like it to run new gitweb like git-instaweb.sh

>
> > The new script includes config and other basic files, checks
> > the URL, parses it, detects the module, manage session and includes
> > the proper module.
>
> O.K., so after splitting the main gitweb.perl file (from which
> gitweb.cgi would be created during build) includes configuration
> (hmmm... shouldn't default configuration and perhaps reading
> site-specific configuration too be put into separate Perl module?),
> dispatch (checking and parsing URL, verifying parameters, and
> choosing action to run), and checking which extra modules (and
> therefore which actions) are available.
>
> "Manage session"... err, current gitweb does not need session
> management. =A0Would the "write" module require it, even if we can as=
sume
> that you are the only client like with git-instaweb, and authenticati=
on
> is not required? =A0I would also recommend to not reinwent the wheel,
> and if you feel that "write" module really needs session management,
> use some existing CPAN module for it like e.g. CGI::Session, or at le=
ast
> borrow (some) code from it.
>

I mean wouldn't using session be good thing to add. It doesn't need to
use parameters like project name all the time in the URL.

>
> > It then retreives the output of the module and
> > substitutes it with the gitweb.tpl template file string and gives o=
ut
> > a proper HTML, CSS web page.
>
> As I said gitweb currently do not use templating engine. =A0Currently
> subroutines that render gitweb actions use git_header_html and
> git_footer_html and similar subroutines... if needed.
>
> Sidenote: I'd prefer that gitweb do not loose ability to stream its
> response, at least for some actions like 'blob_plain', 'patches', and
> what's most important for performance reasons 'snapshot' view.
>

It will be just a string substitution by a small templater class.

>
> > It also contains some basic library files
> > in the lib directory.
>
> The new split gitweb, or the new gitweb.perl script? =A0It is not cle=
ar
> what "it" refers to here. =A0What does "some basic library files" mea=
ns?
> If you want for functional groups of subroutines from gitweb to be sp=
lit
> into separate files/modules, like Gitweb::Utils with href() etc, like
> Gitweb::Repo with parse_commit and similar, please say it explicitely=
=2E
>

The basic library files like errorhandlers, session manager,
templater, redirecter, Gitweb::Utils and Gitweb::repo etc..

>
> > The new gitweb uses session variables to track
> > some of the variables rather than including them in the url.
>
> Why? =A0If it is possible and feasible to be sessionless, then it is
> better to do so. =A0Session state consumes resources on the server.
> HTTP protocol is naturally stateless.
>
> > The write
> > modules need not be working in a gitweb installation like repo.or.c=
z,
> > so we will also have an option to disable the write modules.
>
> That is a good idea: if "write" module is not installed, its features
> are not available.
>

Thanks.

>
> >
> > b) Write modules of the client:
> >
> > =A0 1. Add existing repositories to the gitweb -- This will list th=
e
> > =A0 =A0 =A0given repo into gitweb config
>
> Note that if gitweb scans for repositories ($projects_list is
> a directory, not a file with the list of projects), gitweb would dete=
ct
> new repository automatically. =A0This feature (autodetecting
> repositories) is fore example requirement on git.kernel.org.
>

Let us say if there are multiple repositories in multiple paths,
wouldn't it be good to add a single project. This option will be
available along with scanning $projects_root.

>
> > =A0 2. Create new/Clone repositories into a given path [git init |
> > =A0 =A0 git clone] -- This will create new repo and list it
>
> "Create new repository" and "fork it", like Girocco does for
> repo.or.cz...

When used as a client, it will be cloning from a URL. right ?

>
> > =A0 3. Add/Remove/Move files [git add | git rm | git mv]
> > =A0 4. Stage/Unstage files [git add | git reset]
> > =A0 5. Add files to ignore list when you click on 'Ignore' link
>
> All the above require ability to display a state of a working directo=
ry,
> i.e. something like 'tree' view but for working area of repository (o=
r
> the index) rather than taken from some commit.
>

All the above actions will have link from git status view.

>
> > =A0 6. Discard changes to a file in working copy [git reset]
>
> O.K.
>
> > =A0 7. Commit to the repository with a log message and an optional
> > =A0 =A0 =A0sign-off [git commit]
>
> You would probably want also to display status of the files in the
> working directory (this goes along with 'tree' view for files in
> working area: we would probably want to display state for those files=
),
> and to display diff between current HEAD and working area. =A0Gitweb =
can
> display commitdiff for a given commit, and (what is less known) diff
> between two arbitrary commits only.

As I said above, it will be available to commit from git status view.

>
> > =A0 8. Switch branches [git branch]
>
> You would probably want creating new branches here, too.

Yeah, I mean it.

>
> > =A0 9. A simple branch merging* [git merge]
>
> Do you mean here by "simple" merge that does not lead to merge
> conflicts?

It can lead to merge conflicts but what I mean is you cannot solve it
from the client.

>
> > =A010. Creating tags [git tag]
>
> O.K. =A0Does it include creating signed tags?

Yes.

>
> > =A011. Checkout code to a specific commit or branch or tag
> > =A0 =A0 =A0[git checkout]
>
> Note that "git checkout <branch>" is switching branches.

Yes. Sorry for repeating it.

>
> > =A012. Push to a remote branch [git push]
> > =A013. Fetch/Pull from a remote branch [git fetch | git pull]
>
> Yo would need support for either editing config, or for interface to
> [git remote add] first, otherwise the only remote available would be
> 'origin'. =A0Unless you are interested in pushing to / fetching from
> repository given by URL...
>

I think i missed that point. all functionalites with "git remote" will
be added too.

>
> > =A014. Garbage collection [git gc]
>
> You would probably want to be able to gather statistics, a la
> [git count-objects -v].

Nice idea.

>
> > =A015. Search for a part of code [git grep]
>
> Note that current gitweb includes some support for 'grep' search,
> but obviously you can only search repository (some specified commit),
> not index nor working area.
>

I want to include this so that in future it can integrated with
pickaxe interface.

>
> >
> > * - Merging two branches can be quite complicated
> >
> > c) Read modules of the client: (most of this need not be written, j=
ust
> > need to be organised)
> >
> > =A0 1. See the status of repository [git status]
>
> New, needed for commit.
>
> > =A0 2. Show diff of the current working file compared to HEAD [git =
diff]
>
> New, needed for commit.
>
> > =A0 3. List all the commits with pagination [git log]
>
> Exists in gitweb.
>
> > =A0 4. With every commit we can
> > =A0 =A0 =A0 =A0 =A0* Visualise trees [git ls-tree]
> > =A0 =A0 =A0 =A0 =A0* Visualise files and diffs [git show]
> > =A0 =A0 =A0 =A0 =A0* Visualise annotations [git blame]
>
> All those exists already in gitweb.

Yes. i will just copy the code from the current gitweb.

>
> > =A0 5. List all branches including remote ones [git branch]
>
> Remote tracking branches are not currently supported, but gitweb can
> display local branches and tags.
>
> > =A0 6. Search commits, branches, authors etc..
>
> Exists in gitweb.
>
> >
> > d) Usage of the client:
> >
> > This client can be used in 2 ways.
> >
> > * Install a local version using instaweb - The gitweb will be only
> > accessible by you. You can browse through the git repository using
> > read modules and simultaneously work on them using write modules.
>
> This part could be doeable dusing GSoC 2010 (if this project gets
> accepted), I think.

Yes. This is the main thing that is needed for a average git user.

>
> > * Install on intranet - A company when installs this gitweb along w=
ith
> > some other login and account managing scripts will be able to order
> > their employees to login and ask them to work on the code with out =
the
> > security risk of providing ssh access to the git repository host.
> > * Install on web - Just like normal gitweb, or enable write modules=
 to
> > look like gist.github.com
>
> This would require authentication support, which I think might be too
> much for GSoC.

Yes. I will not be doing it in GSoC and it won't be a part of gitweb,
But I hope to provide an authentication wrapper for gitweb in future.

>
> > e) Future functionalities:
> >
> > =A0 =A0* Implementing a file editor
>
> O.K., although without at least being able to edit file in textarea,
> or to upload new version of a file you would need something outside
> "write" module to create new commits anyway.
>
> > =A0 =A0* Rebasing branches
> > =A0 =A0* Content History browser - (The gsoc 2010 idea in wiki)
> > =A0 =A0* Implementing git bisect
> > =A0 =A0* Cherry picking
> > =A0 =A0* Patches management along with email
>
> O.K.
>
> > =A0 =A0* Viewing git stats in an interactive user interface
>
> O.K.
>
> > =A0 =A0* Developing API to work with gitweb for storing information=
 in
> > form of a git repository
>
> What you mean by that?
>

I mean, I will be providing an web API wrapper for gitweb which can be
used by other web developers to store any information they get into a
git repository form and can use it to see the changes they made to the
information step=A0 by step.

>
> [...]
> > f) Sample Work - Mockup:
> >
> > A small pre-version smaple of the project can seen in my github
> > repository named 'gittor' here. It is written in python and just a
> > small sampe of my work in write modules. This client is capable of
> > building any other functionality and can integrate the functionalit=
ies
> > of any other git tools.
>
> That is very good... but see the question at the beginning of my emai=
l.

I already answered it. :-)

>
> > TimeLine
>
> [...]
> > [June 3rd week]
> > Complete module from W1 to W3
>
> Don't forget to write automated tests, if it is possible.
>
> Also, W1 to W3 do not tell me much here.
>
> > 3. Academic Experience
> >
> > I beleive I am a fast learner and have learnt most of the famous
> > programming languages in the coding world. Some of the courses whic=
h
> > are relevant to my GSoC project and proposal are:
> >
> > =A0 =A0* Data Structures and Algortihms
> > =A0 =A0* Advanced Computer Programming
> > =A0 =A0* Introduction to Computer Programming
> >
> > The other courses which I have taken and non-relevant to the projec=
t
> > are Languages Machines and Computations, Switching Circuits and Log=
ic
> > Design, Computer Architecture and Organisation.
> >
> > Different Programming languages which I am comfortable with:
> >
> > =A0 =A0* Python
> > =A0 =A0* PHP
> > =A0 =A0* SQL
> > =A0 =A0* Javascript
> > =A0 =A0* AJAX
> > =A0 =A0* C
> > =A0 =A0* C++
> > =A0 =A0* HTML
> > =A0 =A0* CSS
> > =A0 =A0* Java
> > =A0 =A0* Verilog
> > =A0 =A0* Assembly language
>
> Unfortunately Perl (the language gitweb is written in) is missing...
> See also first question in this email of mind.
>
> AJAX is not programming language: it is technique. =A0(Also neither
> HTML nor CSS are *programming* languages in strict sense, but that
> is just nitpicking...).

I use this sentence on others and now you are using it on me :-)
Sorry for including them. I thought that they are important for this
project so I included the too.

>
> [...]
> > 4. Involvement with Git
> >
> > I use git for most of my projects and am fascinated by it's speed a=
nd
> > uasbility. I think it is and is going to be the best content tracke=
r
> > ever known to the world.
> >
> > I have been subscribed to git mailing list for 2 months and have
> > already put one of my ideas forward to the git developers in the
> > thread linked here
> >
> > I also submitted a patch which advices the users in git status to a=
dd
> > a file to gitignore if he want to ignore it permanently. It can see=
n
> > in this mailing list thread here.
>
> Good.
>
> --
> Jakub Narebski
> Poland

Please ask me if you have any other doubts regarding this project.
