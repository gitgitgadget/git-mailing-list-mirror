From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Mon, 19 Apr 2010 23:25:56 +0530
Message-ID: <u2ze72faaa81004191055t13ad6f2hbdcc319260cbabcf@mail.gmail.com>
References: <201004150630.44300.chriscool@tuxfamily.org>
	 <201004182323.02311.jnareb@gmail.com>
	 <w2pe72faaa81004182334xd6fc56d7o31420ca4af867cc2@mail.gmail.com>
	 <201004191900.12529.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, Sam Vilain <sam@vilain.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 19 19:56:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3vCb-0000aG-LH
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 19:56:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912Ab0DSR4B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Apr 2010 13:56:01 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:61135 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799Ab0DSR4A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Apr 2010 13:56:00 -0400
Received: by yxe29 with SMTP id 29so2602081yxe.4
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 10:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DyysohviOHLtyvWUDvtk7kTt3SJT8HgvoxEEKFBY0E0=;
        b=Ez7YGgEHRmYr2BwCpb8qT6uEK/l73ye0nJMG8idhlfZ/3E7LvClMg5nfqclA066moI
         piPSJ4tzGHaeOKCGJ1XSuTcrQOcxRwVfg3LPgZRy+a8+1zUioPTUPKnWJx8Pslwj/G4Z
         I1yN4EV5ls/p3m8/0EdmRnEd5hzsww6yNTEsE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sdjrbd8ayCUGiN9vicFzujTGD5NWRiHtIQbMgGpl566CDGihMb1LFD1Vres6ILNhdk
         PcpTnwSJZXMujmWcUH1OSUJ51ZBYAGagtq8TDGvK96moKNuz1z2vVmNINSV6v0kPbvFW
         /rHHSTDDUxUBgyxSL92djHyCzqrmyex87D8Ek=
Received: by 10.90.118.4 with HTTP; Mon, 19 Apr 2010 10:55:56 -0700 (PDT)
In-Reply-To: <201004191900.12529.jnareb@gmail.com>
Received: by 10.91.37.1 with SMTP id p1mr3327572agj.47.1271699757135; Mon, 19 
	Apr 2010 10:55:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145319>

2010/4/19 Jakub Narebski <jnareb@gmail.com>:
> On Mon, 19 Apr 2010, Pavan Kumar Sunkara wrote:
>> On Mon, Apr 19, 2010 at 2:52 AM, Jakub Narebski <jnareb@gmail.com> w=
rote:
>>> On Sun, 18 April 2010, Pavan Kumar Sunkara wrote:
>
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>>>
>>>> Splitting gitweb and developing write functionalites
>>>> Student: =A0 =A0 =A0 =A0Pavan Kumar Sunkara
>>>>
>>>> This project aims at splitting and organising the 6800 lines code =
of
>>>> gitweb.pl into a nicely structured set of files. Not only providin=
g
>>>> the browsing functionalities in gitweb, but it also aims at develo=
ping
>>>> functionalities for working on a git repository.
>>>
>>> First, a question: do you feel proficient enough in Perl (and in we=
b
>>> scripting in Perl), or do you prefer other programming language for
>>> web, like e.g. Python? =A0If you feel like you would do better prog=
ramming
>>> in Python (or PHP, or Ruby) rather than in Perl, you could write th=
e
>>> main part of this GSoC project in said language, and provide only h=
ooks
>>> into gitweb (with the help of developers on git mailing list).
>>
>> I don't know perl but learning it and becoming proficient in it won'=
t be a
>> matter for me. I believe I am a fast learner and I am a computer sci=
ence
>> student in the top university of India. I learnt python in an hour a=
nd
>> became proficient in it by a week. So learning perl won't be a matte=
r for
>> me.
>
> I can agree that you would be able to learn Perl in a week. =A0I do n=
ot
> think however that you can become proficient in Perl (and neither in =
any
> other non-trivial programming language) in such short time. =A0The qu=
estion
> remains if you can be proficient enough for the task in question...

I can learn perl in 3 hours. Becoming proficient in perl is just
knowing about all the majorly used inbuilt functions and libraries.
Coming to the concepts of programming, I already know a lot about it
along with Data structures and algortihms. So you need not doubt me on
this.

>>> Second, it would probably be not "splitting ... into ... a set of
>>> files", but rather "splitting gitweb into modules" (see e.g.
>>> Web::Simple, SVN::Web, etc).
>>>
>> I would like to take the majority opinion on how to split gitweb.
>
> Errr... my comment was about technical language / jargon used...
>
> As to "I would like to take the majority opinion on how to split gitw=
eb":
> in my opinion you would need to have your own idea on how to split gi=
tweb
> yourself, to avoid possibility of wasting time on bikeshedding[1].
> Of course this would be based on discussion here on git mailing list.
> All of this assuming that this project would get accepted.
>
> [1] http://en.wikipedia.org/wiki/Bikeshed

Sorry about that.

I have already given my idea in the proposal. I would like to hear
your opinions and implement the majority opinion if my  idea is full
of flaws. That is what I meant by the line.

>>> "It aims at developing functionalities for working on a git reposit=
ory."
>>> Not only this is not grammatical, but also doesn't tell us the goal
>>> of your project. =A0Is it something to edit files and create commit=
s via
>>> web, be to git-gui what git-instaweb is to gitk? =A0Is it about edi=
ting
>>> gitweb-specific configuration, like README/README.html and 'descrip=
tion'
>>> file from web browser? =A0Is it managing git repositories, i.e. cre=
ate,
>>> fork or clone and mirror repositories, something that Gerrit does f=
or
>>> repo.or.cz (repo.or.cz uses gitweb for viewing repositories)?
>>>
>> I think you understood it from the later part of my proposal.
>
> Yes, I found it in later parts of proposal, but don't you think that
> this goal of this project should be stated upfront, so that one can
> know what this project is to be about from project description itself=
?

I thought it should be described later in the "Describe your project
in more detail" section.  So, I didn't go into details here.

>>>> =A0 =A0* User friendly graphical interface with smart UI design wh=
en
>>>> compared to any other git clients or browsers.
>>>
>>> This is rather vague for a goal. =A0Do you want to be able to edit
>>> files and commit them? =A0To add new files and remove tracked files
>>> (or just untrack them)? =A0To cherry-pick, revert, amend commit?
>>> To switch between branches and reqwind a branch? =A0To run and visu=
alize
>>> git-bisect? =A0To merge branches and resolve merge conflicts? =A0To=
 rebase
>>> and resolve rebase conflicts?
>>
>> Yes, exactly. I think you haven't read the whole proposal before wri=
ting
>> this. :-)
>
> I have not. =A0I got it from discussion in parallel subthread, so I a=
sked
> for clarification. =A0But I should have to read the whole proposal, o=
r
> know extra information to get what you were trying to say here.
> Be specific (but not too detailed), not vague in describing goals.

OK.

>>>> =A0 =A0* gitweb.tpl -- The template of the web page (GUI) in which
>>>> =A0 =A0 =A0modules are embedded
>>>
>>> Errrr... what? =A0Gitweb currently does not use templating engine.
>>> There are no templating engines in Perl core, writing yet another o=
ne
>>> only for gitweb would be stupid, and choosing one would I guess res=
ult
>>> in bikeshedding spanning whole summer and then some (which one to
>>> choose: Template Toolkit with its domain specific language, =A0Haml=
-like
>>> perlish templates of Template::Declare and Markapl, or pure (X)HTML
>>> templates of Template::Semantic and HTML::Zoom?).
>>>
>>> Or did you mean lib/Gitweb/View/Default.pm - the view part of MVC
>>> model, containing subroutines responsible for the look of gitweb?
>>>
>> I would like to add a small 50 lines code for templater class which =
does
>> string substitution and embed the module output into tpl file. This =
method
>> reduces the subroutines like git_header_html etc.. A small example o=
f
>> templater class can be found at http://matetelki.com/blog/?p=3D71. I=
t isn't
>> exactly the same i use but you get the basic idea. right ?
>
> Currently gitweb does not use any templating engine. =A0Adding it wou=
ld
> be additional work, in my opinion not really necesary for the goals o=
f
> project (splitting gitweb is more on less needed to be able to add
> large new feature, such as committool / "write" bit). =A0I don't thin=
k
> there is enough time to (optionally) code and add templating to gitwe=
b.
>
> Additionally, while adding very simple templating class wouldn't be
> to much violation of programming guidelines (and for example both
> Mojolicius and Dancer web micro-frameworks include their own simple
> templating system), I am afraid that simple string / variable
> substitution would be not enough for gitweb: loops and conditionals
> would also be required. =A0Also we would probably want for templating
> system to automatically escape (when requested). =A0So templating eng=
ine
> grows... and then it would really be better to just use one of existi=
ng
> templating modules from CPAN (http://search.cpan.org), or add adapter
> to one of templating system from CPAN (like Catalyst web framework
> does it).
>
> Also if you are not proficient in Perl, I would be aftraid that your
> homebrew templating engine would affect gitweb performance...
>
>
> In short: no time to add templating support to gitweb.

Ok. If everyone feels the same I would like remove it from the proposal=
=2E

>
>>>> =A0 =A0* modules (dir) -- directory containing the write and read =
modules.
>>>> =A0 =A0* lib (dir) -- some basic files like config, error_handler,
>>>> templater, redirecter, htmlHelper etc..
>>>
>>> I'm not sure about modules/ directory: wouldn't lib/ be enough?
>>> What needs to be in modules/ that cannot be put in lib/?
>
> I guess (please correct me if I am wrong) that lib/ would contain mod=
ules
> *required* by gitweb, and modules/ would contain *optional* modules
> needed for extra functionality (for extra features).

You are half correct.
lib/ contains modules *required* by gitweb
modules/ contains actions *performed* in gitweb like commitlog,
snapshot etc.. (write actions too)

Maybe I will rename it to actions/ to not to be confused.

>>>> The new script includes config and other basic files, checks
>>>> the URL, parses it, detects the module, manage session and include=
s
>>>> the proper module.
>>>
>>> O.K., so after splitting the main gitweb.perl file (from which
>>> gitweb.cgi would be created during build) includes configuration
>>> (hmmm... shouldn't default configuration and perhaps reading
>>> site-specific configuration too be put into separate Perl module?),
>>> dispatch (checking and parsing URL, verifying parameters, and
>>> choosing action to run), and checking which extra modules (and
>>> therefore which actions) are available.
>>>
>>> "Manage session"... err, current gitweb does not need session
>>> management. =A0Would the "write" module require it, even if we can =
assume
>>> that you are the only client like with git-instaweb, and authentica=
tion
>>> is not required? =A0I would also recommend to not reinwent the whee=
l,
>>> and if you feel that "write" module really needs session management=
,
>>> use some existing CPAN module for it like e.g. CGI::Session, or at =
least
>>> borrow (some) code from it.
>>>
>> I mean wouldn't using session be good thing to add. It doesn't need =
to use
>> parameters like project name all the time in the URL.
>
> Using sessions is not without cost: you would (usually) need to store
> extra information on the server.
>
> Also one usually wants for URLs to be bookmarkeable. =A0One would wan=
t
> to be able to send link to be copy'n'pasted.
>
> If sessions are to make gitweb URLs shorter: forget it. =A0First, it =
would
> be not necessary for your project. =A0Second, this is not the way to =
have
> shorter URLs.
>
> See also the whole idea of stateless REST interface.

Yeah, we have already discussed about it in previous mails. The final
conclusion is not to use session manager in gitweb. But let's include
a module for it so that it can be used when others build
authentication support.

>>>> b) Write modules of the client:
>>>>
>>>> =A0 1. Add existing repositories to the gitweb -- This will list t=
he
>>>> =A0 =A0 =A0given repo into gitweb config
>>>
>>> Note that if gitweb scans for repositories ($projects_list is
>>> a directory, not a file with the list of projects), gitweb would de=
tect
>>> new repository automatically. =A0This feature (autodetecting
>>> repositories) is fore example requirement on git.kernel.org.
>>>
>> Let us say if there are multiple repositories in multiple paths, wou=
ldn't it
>> be good to add a single project. This option will be available along=
 with
>> scanning $projects_root.
>
> If gitweb is configured to scan for repositories, adding existing git
> repository to gitweb doesn't make sense. =A0If gitweb is configured t=
o
> use static file with list of repositories, of course it would make
> sense... but then the question is how would one specify location of
> a new repository to add.

How about like this ?
We will have a static file with list of projects. All the repositories
in scan path will be added to this list. Then we will also have an
option to add an existing repository which can be done when the user
specifies a relative or full path to the repository.

>
>>>> =A012. Push to a remote branch [git push]
>>>> =A013. Fetch/Pull from a remote branch [git fetch | git pull]
>>>
>>> You would need support for either editing config, or for interface =
to
>>> [git remote add] first, otherwise the only remote available would b=
e
>>> 'origin'. =A0Unless you are interested in pushing to / fetching fro=
m
>>> repository given by URL...
>>>
>> I think i missed that point. all functionalites with "git remote" wi=
ll be
>> added too.
>
> Good.
>
>>>> d) Usage of the client:
>>>>
>>>> This client can be used in 2 ways.
>>>>
>>>> * Install a local version using instaweb - The gitweb will be only
>>>> accessible by you. You can browse through the git repository using
>>>> read modules and simultaneously work on them using write modules.
>>>
>>> This part could be doable during GSoC 2010 (if this project gets
>>> accepted), I think.
>>
>> Yes. This is the main thing that is needed for a average git user.
>
> The main simplification is that we do not need authentication here,
> only perhaps requirement that server is 'localhost'.

Yes, it wouldn't need authentication because the server will be localho=
st.

>>>> * Install on intranet - A company when installs this gitweb along =
with
>>>> some other login and account managing scripts will be able to orde=
r
>>>> their employees to login and ask them to work on the code with out=
 the
>>>> security risk of providing ssh access to the git repository host.
>>>> * Install on web - Just like normal gitweb, or enable write module=
s to
>>>> look like gist.github.com
>>>
>>> This would require authentication support, which I think might be t=
oo
>>> much for GSoC.
>>
>> Yes. I will not be doing it in GSoC and it won't be a part of gitweb=
, But I
>> hope to provide an authentication wrapper for gitweb in future.
>
> Well, unless there would be time for it after you finish all other wo=
rk,
> but it is a bit unlikely.

I don't think so. I would like to constantly contribute to gitweb.

>>>> =A0 =A0* Developing API to work with gitweb for storing informatio=
n in
>>>> form of a git repository
>>>
>>> What you mean by that?
>>>
>> I mean, I will be providing an web API wrapper for gitweb which can =
be used
>> by other web developers to store any information they get into a git
>> repository form and can use it to see the changes they made to the
>> information step =A0by step.
>
> It doesn't tell me much either. =A0Do you mean some kind of REST API =
here,
> to be used from other clients, or something like that?

Yes, Exactly.

> Anyway I'd rather you put it in "if I have time" pile...

Yes, I already mentioned it in the proposal. It is under the section
"Future functionalities"

-pavan
