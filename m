From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Sun, 18 Apr 2010 14:22:20 +0530
Message-ID: <n2le72faaa81004180152pb84cef2cn2a7eb95da64420b1@mail.gmail.com>
References: <201004150630.44300.chriscool@tuxfamily.org>
	 <201004180246.18263.jnareb@gmail.com>
	 <20100418005917.GO10939@machine.or.cz>
	 <201004180324.54722.jnareb@gmail.com>
	 <20100418021223.GP10939@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, Sam Vilain <sam@vilain.net>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Apr 18 10:52:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3QFB-0007PN-A4
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 10:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754868Ab0DRIwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 04:52:25 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61327 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754105Ab0DRIwW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 04:52:22 -0400
Received: by gyg13 with SMTP id 13so2106741gyg.19
        for <git@vger.kernel.org>; Sun, 18 Apr 2010 01:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=mFbXZt6H5z0b8s/Q/+UUI75vTdiNnQlPlBtcLxix0Eo=;
        b=I+M0RRbFSYuaOvX53mcC2DNx2VkXcXLctZc/ohaZ0jZ4gyXwXr40o3jjFe7jAkt9Tr
         pXUXs/ldnZxf8kp8C/qYku4CXIwEHlsZAMTKJC9m6T+QzEZ2mzVZQ5K2vCxmmE0lzlsO
         FL2OT0bb6bCoTnliw1UXptkz/6zD3s8jmXjWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=PWFuivhpzaRB5vvB2iNW84ZuscxPCc/WNgiqMAEP//n81io+RLnf5iw9RsLzjJZ1GR
         c2Iv6USM6Debh3oiLj7p5qqQPQQnuS5ChNM6kVC2tao6OL2+ejbpfe+nQEfjebUYt2MV
         MLgkhk8R/GFi1CGnEk9A7Exl09rtHPhv5tkIA=
Received: by 10.90.118.4 with HTTP; Sun, 18 Apr 2010 01:52:20 -0700 (PDT)
In-Reply-To: <20100418021223.GP10939@machine.or.cz>
Received: by 10.91.59.6 with SMTP id m6mr2256847agk.4.1271580740932; Sun, 18 
	Apr 2010 01:52:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145217>

Here is my rewritten proposal as Christian and Petr asked me to write.
Please go through this.

Thanks

-pavan

=====================================================

Splitting gitweb and developing write functionalites
Student:        Pavan Kumar Sunkara

This project aims at splitting and organising the 6800 lines code of
gitweb.pl into a nicely structured set of files. Not only providing
the browsing functionalities in gitweb, but it also aims at developing
functionalities for working on a git repository.

First I will describe my project goals, giving an overview of what I
would like to contribute to git. Second I will give the proposed time
line of the project which includes all the information about the
project. Lastly I will give some information about myself.


Project Goals

1.What is the goal of your project?
The project goal is to try and implement write functionalities into
gitweb along with it's browsing functionalities. It also aims at
splitting and organising the structure of gitweb perl script.

I would like to split the gitweb script in such a way that, in the
future others will be able to develop more functionalities for gitweb
(let it be 'read' or 'write' actions) with the help of the framework
like structure of the new gitweb.

'read' means browsing through the code and repository
'write' means working on the code and repository.

2.How would you measure its success or failure?
There are two parameters which would majorly determine the success or
failure of the project.

   * Splitting gitweb such that there should be no problem with the
installation of gitweb across cross servers and cross systems.
   * It should be possible that the new gitweb requires less time to
work on a git repository than any other git client.
   * User friendly graphical interface with smart UI design when
compared to any other git clients or browsers.

3.Describe your project in more detail.
I would like to split the currently 6800 long piece of code in
gitweb.pl perl script into small files which will result in better
readability, maintainability and modifiability. The file structure of
the new gitweb is given below and I will explain the working after it.

(From now on, I would like to call the actions of gitweb as modules of gitweb)

a) File Structure:

   * gitweb.pl -- Main script parsing urls and calling required modules
   * gitweb.tpl -- The template of the web page (GUI) in which
modules are embedded
   * gitweb.css -- The style for the gitweb pages.
   * gitweb.js -- javascript to make gitweb more interactive
   * modules (dir) -- directory containing the write and read modules.
   * lib (dir) -- some basic files like config, error_handler,
templater, redirecter, htmlHelper etc..

The current gitweb makefile makes a gitweb.cgi from the perl script
and requires apache or lighttpd server for it's working. I would like
to continue this process but the change will be in the gitweb perl
script. The new script includes config and other basic files, checks
the URL, parses it, detects the module, manage session and includes
the proper module. It then retreives the output of the module and
substitutes it with the gitweb.tpl template file string and gives out
a proper HTML, CSS web page. It also contains some basic library files
in the lib directory. The new gitweb uses session variables to track
some of the variables rather than including them in the url. The write
modules need not be working in a gitweb installation like repo.or.cz,
so we will also have an option to disable the write modules.

b) Write modules of the client:

  1. Add Existing repositories to the gitweb -- This will list the
given repo into gitweb config
  2. Create new/Clone repositories into a given path [git init | git
clone] -- This will create new repo and list it
  3. Add/Remove/Move files [git add | git rm | git mv]
  4. Stage/Unstage files [git add | git reset]
  5. Add files to ignore list when u click on 'Ignore' link
  6. Discard changes to a file in working copy [git reset]
  7. Commit to the repository with a log message and an optional
sign-off [git commit]
  8. Switch branches [git branch]
  9. A simple branch merging* [git merge]
 10. Creating tags [git tag]
 11. Checkout code to a specific commit or branch or tag [git checkout]
 12. Push to a remote branch [git push]
 13. Fetch/Pull from a remote branch [git fetch | git pull]
 14. Garbage collection [git gc]
 15. Search for a part of code [git grep]

* - Merging two branches can be quite complicated

c) Read modules of the client: (most of this need not be written, just
need to be organised)

  1. See the status of repository [git status]
  2. Show diff of the current working file compared to HEAD [git diff]
  3. List all the commits with pagination [git log]
  4. With every commit we can
         * Visualise trees [git ls-tree]
         * Visualise files and diffs [git show]
         * Visualise annotations [git blame]
  5. List all branches including remote ones [git branch]
  6. Search commits, branches, authors etc..

d) Usage of the client:

This client can be used in 2 ways.

* Install a local version using instaweb - The gitweb will be only
accessible by you. You can browse through the git repository using
read modules and simultaneously work on them using write modules.
* Install on intranet - A company when installs this gitweb along with
some other login and account managing scripts will be able to order
their employees to login and ask them to work on the code with out the
security risk of providing ssh access to the git repository host.
* Install on web - Just like normal gitweb, or enable write modules to
look like gist.github.com

e) Future functionalities:

   * Implementing a file editor
   * Rebasing branches
   * Content History browser - (The gsoc 2010 idea in wiki)
   * Implementing git bisect
   * Cherry picking
   * Patches management along with email
   * Viewing git stats in an interactive user interface
   * Developing API to work with gitweb for storing information in
form of a git repository

If completed properly, this is going to be a combination of gitk,
git-gui and gitweb, giddy, git-age and other git tools into a great
code. Many of the current git users are dissatisfied with current git
clients and have always been complaining about them in the IRC. Also
some of them complain about the complexity of installation of gitweb.
This project will solve both the problems.

I will try to make sure that the patches to be as small as possible
and easily reviewable. Also my vacation starts on May 2nd and ends on
August 1st. So most of the project work will be done during the start
of the GSoC project rather than in the end.

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

   * Discuss the deliverables for the next iteration with the mentors
along with my daily report.
   * Work on the implementation and send patches on implemented
functionality in email to developers mailing list.
   * The developers and the mentors review it and try to merge it upstream
   * Fix bugs, tweak UI etc depending on the feedback. Also document
everything while its still fresh in my mind.

[Prior May 24]
Read and understand the code of current gitweb. Install it and play with it.

[May 4th week - June 1st week]
Split the whole code of gitweb into framework structure and setup
library files along with installation and configuration.

[June 2nd week]
Move the read modules accordingly

[June 3rd week]
Complete module from W1 to W3

[June 4th week]
Complete modules from W4 to W7

[July 1st week]
Complete module W8 and W9

[July 2nd week]
Check for any possible and potential security loopholes or bugs

[July 3rd week]
Complete modules W10 and W11

[July 4th week]
Complete modules W12 and W13

[Aug 1st week]
Complete mdoules W14 and W15

[Aug 2nd week]
Scrub code, Improve Documentation and last minute touches

-- W means write modules


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
project members or community. Theys should also be able to communicate
well. I believe I have all these mentioned qualities and have a keen
interest in field of OpenSource programming.

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
     Created a PHP based file system Database and Query Language for
small scale database applications.
     Designed and developed a fully valid CSS for wordpress, the
famous blogging platform.
     Developed a single page forum script to avoid space issues and
optimized database calls to reduce the execution time unlike the
traditional bulky forums.
     Incorporated a web-based application that offers flexibility in
presentation of the information to generate a structured resume
following pre-defined document standards

* Non-web related works
     Designed and implemented an 8 bit micro-processor using Verilog, a HWDL
     Developed an IRC bot for listening and logging a particular
channel given the required details.
     Developed an AI for 'Dots and Boxes' game in Java.
     Designed and developed a small TicTacToe Network game server and
client in Python

3. Academic Experience

I beleive I am a fast learner and have learnt most of the famous
programming languages in the coding world. Some of the courses which
are relevant to my GSoC project and proposal are:

   * Data Structures and Algortihms
   * Advanced Computer Programming
   * Introduction to Computer Programming

The other courses which I have taken and non-relevant to the project
are Languages Machines and Computations, Switching Circuits and Logic
Design, Computer Architecture and Organisation.

Different Programming languages which I am comfortable with:

   * Python
   * PHP
   * SQL
   * Javascript
   * AJAX
   * C
   * C++
   * HTML
   * CSS
   * Java
   * Verilog
   * Assembly language

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
