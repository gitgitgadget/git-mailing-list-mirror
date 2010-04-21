From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Thu, 22 Apr 2010 02:19:02 +0530
Message-ID: <k2le72faaa81004211349o1628ed42s4fa0aa412006128@mail.gmail.com>
References: <201004150630.44300.chriscool@tuxfamily.org>
	 <201004191243.24209.jnareb@gmail.com>
	 <20100419115113.GC3563@machine.or.cz>
	 <201004202014.19477.jnareb@gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Apr 21 22:49:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4grC-0002Tr-5X
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 22:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756517Ab0DUUtH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Apr 2010 16:49:07 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:60094 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755146Ab0DUUtF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Apr 2010 16:49:05 -0400
Received: by yxe29 with SMTP id 29so3787030yxe.4
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 13:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VDKmmelw0jCa6yhoDBFBKtIdhafkFvS9OWsPNpmM8cY=;
        b=PGrZ6jczqfIhvilJzrmqUrx2UcJCetCMKLf/8RcOEwJ23u6YxyZosJPzkKR+XR3it9
         0c/aasrayWzvOcUCfu+mH4wiD2oC3jqocu19Dk792e0w7mi/DxwrBUwfzAfl9dcuCIEs
         CXS9enKWUMeCmopIP+B1zE5QJ60mD4tvdf/gg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oJs33pYWN0F9OFpMg2je94QZ0doi6CiflBLayaehcRvhgegHjnmEf5ze6Y8Rq6+JSE
         1xIzkFq958GeNcFUJAwqIF5f/1wq4kiWq5dtRbpPa/joL/6bHuigrsnND+46bcNilx60
         ILVEgwzc2YTOkw6nfmr093ZSyU/xxpQZgVquo=
Received: by 10.90.51.18 with HTTP; Wed, 21 Apr 2010 13:49:02 -0700 (PDT)
In-Reply-To: <201004202014.19477.jnareb@gmail.com>
Received: by 10.91.163.17 with SMTP id q17mr4730362ago.36.1271882942897; Wed, 
	21 Apr 2010 13:49:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145452>

Hi,
=A0According to advice from Christian and Petr, Here is my updated GSoC
proposal which has been a result of all the discussions in this
thread.
Thanks

-pavan

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Splitting gitweb and developing write functionalites
Student: =A0 =A0 =A0 =A0Pavan Kumar Sunkara

This project aims at splitting and organising the 6800 lines code of
gitweb.pl into modules. Not only providing the browsing
functionalities in gitweb, but it also aims at developing
functionalities for working on a git repository.


Project Goals

1.What is the goal of your project?
The project goal is to try and implement write functionalities into
gitweb to go along with it's browsing functionalities. Another goal is
to split gitweb Perl script and reorganize its structure. I would like
to split the gitweb script in such a way that, in the future others
will be able to develop more functionalities for gitweb (let it be
'read' or 'write' actions) with the help of the framework like
structure of the new gitweb.

'read' means browsing through the code and repository
'write' means working on the code and repository.

I will be describing about them detailedly in the later parts of the pr=
oposal.

2.How would you measure its success or failure?
There are two parameters which would majorly determine the success or
failure of the project.

=A0 =A0* Splitting gitweb such that there should be no problem with the
installation of gitweb across cross servers and cross systems.
=A0 =A0* Working with new addition to gitweb should be as easy as worki=
ng
with other git GUIs (git commit tools)
=A0 =A0* User friendly graphical interface with smart UI design

3.Describe your project in more detail.
I would like to split the currently 6800 long piece of code in
gitweb.pl perl script into small files which will result in better
readability, maintainability and modifiability. The file structure of
the new gitweb is given below and I will explain the working after it.

(From now on, I would like to call the actions of gitweb as modules of =
gitweb)

a) File Structure:

=A0 =A0* gitweb.pl -- Main script parsing urls and calling required mod=
ules
=A0 =A0* gitweb.css -- The style for the gitweb pages.
=A0 =A0* gitweb.js -- javascript to make gitweb more interactive
=A0=A0 * git-logo.png
=A0=A0 * git-favicon.png
=A0=A0 * Makefile --=A0 Responsible for installing gitweb
=A0 =A0* lib (dir) -- some basic files like config, view and other acti=
ons
=A0=A0=A0=A0=A0 * config.pm
=A0=A0=A0=A0=A0 * view.pm
=A0=A0=A0=A0=A0 * default.pm -- this just outputs the list of all proje=
cts.
=A0=A0=A0=A0=A0 * {actions}.pm -- One file for every action

The current gitweb makefile makes a gitweb.cgi from the perl script
and requires a server for it's working. I would like to continue this
process but the change will be in the gitweb perl script. The new
script includes config and other basic files, checks the URL, parses
it, detects the action, uses the output and along with view.pm gives
out a proper HTML, CSS web page. The lib directory will also contain
some basic modules like Gitweb::Repo, Gitweb::Commit which will make
developing further functionalities easier. The write actions need not
be working in a gitweb installation like repo.or.cz, so we will also
have an option to disable the write modules. I will be using a static
file to maintain the list of repositories which is obtained by
scanning repositories.

b) Read modules of the client: (most of this need not be written, just
need to be organised)

=A0 1. See the status of repository [git status]
=A0 2. Show diff of the current working file compared to HEAD [git diff=
]
=A0 3. List all the commits with pagination [git log]
=A0 4. With every commit we can
=A0 =A0 =A0 =A0 =A0* Visualise trees [git ls-tree]
=A0 =A0 =A0 =A0 =A0* Visualise files and diffs [git show]
=A0 =A0 =A0 =A0 =A0* Visualise annotations [git blame]
=A0 5. List all branches including remote ones [git branch]
=A0 6. Search commits, branches, authors etc.. [git grep]

c) Write modules of the client:

=A0 1. Add Existing repositories to the gitweb -- This will list the
given repo into static list of repos.
=A0 2. Create new/Clone repositories into a given path [git init | git
clone] -- This will create new repo and list it
=A0 3. Add/Remove/Move files [git add | git rm | git mv]
=A0 4. Stage/Unstage files [git add | git reset]
=A0 5. Add files to ignore list when u click on 'Ignore' link
=A0 6. Discard changes to a file in working copy [git reset]
=A0 7. Commit to the repository with a log message and an optional
sign-off [git commit]
=A0 8. Manage branches [git branch]
=A0 9. A simple branch merging* [git merge]
=A010. Creating tags [git tag]
=A011. Implementing a simple file editor
=A012. Checkout code to a specific commit or branch or tag [git checkou=
t]
=A013. Editing config for remotes [git remote]
=A014. Push to a remote branch [git push]
=A015. Fetch/Pull from a remote branch [git fetch | git pull]
=A016. Garbage collection [git gc | git count-objects | git fsck | git =
prune]
=A017. Search for a part of code using pickaxe

* - Merging two branches can be quite complicated. Simple merge
mentioned above will be just showing you that there are conflicts. But
you won't be having options to

d) Usage of the client:

This client can be used in 2 ways.

* Install a local version using instaweb - The gitweb will be only
accessible by you. You can browse through the git repository using
read modules and simultaneously work on them using write modules.
* Install on intranet - A company when installs this gitweb along with
some other login and account managing scripts will be able to order
their employees to login and ask them to work on the code with out the
security risk of providing ssh access to the git repository host. The
authentication support can be implemented as an optional part of my
proposal.
* Install on web - Just like normal gitweb, or enable write modules to
look like gist.github.com

e) Future functionalities:

=A0 =A0* Rebasing branches
=A0 =A0* Content History browser using pickaxe
=A0 =A0* Implementing git bisect
=A0 =A0* Cherry picking
=A0 =A0* Patches management along with email
=A0 =A0* Viewing git stats in an interactive user interface
=A0 =A0* Developing some kind of REST API to be used from other clients
for storing information in form of a git repository

If completed properly, this is going to be a combination of gitk,
git-gui and gitweb, giddy, git-age and other git tools into a great
code. Many of the current git users are dissatisfied with current git
clients and have always been complaining about them in the IRC. Also
some of them complain about the complexity of installation of gitweb.
This project will solve both the problems.

I don't know perl but I can learn it's syntax in less than a day and
as I know the concepts of programming I will try to become proficient
in perl starting from May 3rd.

I will try to make sure that the patches to be as small as possible
and easily reviewable. Also my vacation starts on May 2nd and ends on
August 1st. So most of the project work will be done during the start
of the GSoC project rather than in the end.

I agree that as soon as the GSoC really starts, time for abstract
planning and discussing should be mostly over. I will be ready to
code, create patches, even if only RFC patches, send them to the list,
and then discuss them, reply to reviews, improve them and resend and
try my best to merge them upstream.

f) Sample Work - Mockup:

A small pre-version smaple of the project can seen in my github
repository named 'gittor' here. It is written in python and just a
small sampe of my work in write modules. This client is capable of
building any other functionality and can integrate the functionalities
of any other git tools.


TimeLine

I strongly believe in Agile methodology and stick to it. Agile
practices make all the more sense in open source projects like Git,
where the features are added/modified on the basis of the user's
feedback. We should have the ability to swiftly modify the product or
feature on the basis of the feedback from the community.

The following gives a brief idea about the iteration cycle that I'll
be following during the development period: The iteration cycle is of
1 day duration

=A0 =A0* Discuss the deliverables for the next iteration with the mento=
rs
along with my daily report.
=A0 =A0* Work on the implementation and send patches on implemented
functionality in email to developers mailing list.
=A0 =A0* The developers and the mentors review it and try to merge it u=
pstream
=A0 =A0* Fix bugs, tweak UI etc depending on the feedback. Also documen=
t
everything while its still fresh in my mind.

[Prior May 24]
Read and understand the code of current gitweb. Discuss with mentors
and finish abstract planning.

[May 4th week - June 1st week]
Split the whole code of gitweb into proposed structure and setup
library files along with installation and configuration.

[June 2nd week]
Move the read modules accordingly

[June 3rd week]
Complete module from W1 to W3

[June 4th week]
Complete modules from W4 to W7

[July 1st week]
Complete module W8 to W10

[July 2nd week]
Check for any possible and potential security loopholes or bugs

[July 3rd week]
Complete modules W11 and W12

[July 4th week]
Complete modules W13 to W15

[Aug 1st week]
Complete mdoules W16 and W17

[Aug 2nd week]
Scrub code, Improve Documentation and last minute touches

-- W means write actions


About Me

I am an Indian student, doing my Bachelor's Degree in Computer Science
and Engineering at IIT Madras, one of the top Universities in the
World. I beleive I am a fast learner and have learnt most of the
famous programming languages in the coding world. I am 19 years old
and have a keen interest in field of Game programming.

1. Open Source Experience

Open Source Experience is one thing which everyone requires if he want
to participate in Google Summer of Code. We need to have knowledge of
version control systems, such as SVN, GIT etc.. . Also they need to
follow the standard coding pratices and methods either given by the
project members or community. They should also be able to communicate
well. I believe I have all these mentioned qualities and have a keen
interest in field of Open Source programming.

* LimeSurvey
LimeSurvey is self-described as the 'leading open source tool for
online surveys', which probably isn't much of an exaggeration. I have
already submitted many patches for bugs and committed a few changes
myself

* Charty - Google Wave Gadget
It is a Google Wave gadget for embedding interactive charts and
graphs. It uses methods like Google Wave API, XML, JSON and
javascript. It's source is made open for all.

* BBGFramework
Contributed to the open source PHP5 based Browser Based Gaming
framework by adding installation package and fixing bugs.

* Hackerz
It is an open source Hacking simulation game written in java and
currently in very early stage with short source control history.

2. Coding Expereince

There are more to my experience in programming than the ones listed in
above section. They all are in different languages of programming.

* My Sport Club Manager - Browser Based Game
It is browser based Ice hockey simulation game that runs on PHP and
mysql and uses other web technologies like AJAX and javascript
libraries like prototype. Designed a game flow and a database
structure and implemented the same. It offers a rich gameplay where
clubs can be managed with parameters like stadium, tactics, formation,
finance, stats etc.. A runtime commentatory is genertated
encapsulating all important movements of the game simulation.

* Web related works
=A0 =A0 =A0Created a PHP based file system Database and Query Language =
for
small scale database applications.
=A0 =A0 =A0Designed and developed a fully valid CSS for wordpress, the
famous blogging platform.
=A0 =A0 =A0Developed a single page forum script to avoid space issues a=
nd
optimized database calls to reduce the execution time unlike the
traditional bulky forums.
=A0 =A0 =A0Incorporated a web-based application that offers flexibility=
 in
presentation of the information to generate a structured resume
following pre-defined document standards

* Non-web related works
=A0 =A0 =A0Designed and implemented an 8 bit micro-processor using Veri=
log, a HWDL
=A0 =A0 =A0Developed an IRC bot for listening and logging a particular
channel given the required details.
=A0 =A0 =A0Developed an AI for 'Dots and Boxes' game in Java.
=A0 =A0 =A0Designed and developed a small TicTacToe Network game server=
 and
client in Python

3. Academic Experience

I beleive I am a fast learner and have learnt most of the famous
programming languages in the coding world. Some of the courses which
are relevant to my GSoC project and proposal are:

=A0 =A0* Data Structures and Algortihms
=A0 =A0* Advanced Computer Programming
=A0 =A0* Introduction to Computer Programming
=A0=A0 * Basic Graph Theory

The other courses which I have taken and non-relevant to the project
are Languages Machines and Computations, Switching Circuits and Logic
Design, Computer Architecture and Organisation.

Different Programming languages which I am comfortable with:

=A0 =A0* Python
=A0 =A0* PHP
=A0 =A0* SQL
=A0 =A0* Javascript
=A0 =A0* C
=A0 =A0* C++
=A0 =A0* Java
=A0 =A0* Verilog
=A0 =A0* Assembly language

I believe in taking initiatives and executing them. I have a natural
aptitude for technology as demonstrated by my numerous innovative
endeavors. I believe I am ambitious, creative and hardworking which
makes me an asset for any organization/team.

4. Involvement with Git

I use git for most of my projects and am fascinated by it's speed and
uasbility. I think it is and is going to be the best content tracker
ever known to the world.

I have been subscribed to git mailing list for 2 months and have
already put one of my ideas forward to the git developers in the
thread linked here

I also submitted a patch which advices the users in git status to add
a file to gitignore if he want to ignore it permanently. It can seen
in this mailing list thread here.
