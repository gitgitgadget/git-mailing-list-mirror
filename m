From: Javier Domingo Cansino <javierdo1@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Fri, 25 Apr 2014 04:22:23 +0200
Message-ID: <CALZVapn0gEHc7t2fjk7YGd2o0yfpGLu0JCgUtdREvROC8_mqXg@mail.gmail.com>
References: <20140422213039.GB21043@thunk.org> <alpine.DEB.2.02.1404221523060.14881@nftneq.ynat.uz>
 <53588713347b7_59ed83d308cf@nysa.notmuch> <CAHYYfeHeJYZ67chSTQk2grsFGr07KXcVNR-T6kOPo0bVYDm59g@mail.gmail.com>
 <53588f448d817_59ed83d3084e@nysa.notmuch> <CAHYYfeFKW93GH+6-ssR5L_uoo3OL2-LFAsj-4+8uEmL0BhT3ow@mail.gmail.com>
 <5358bae8ab550_1f7b143d31037@nysa.notmuch> <877g6fb2h6.fsf@fencepost.gnu.org>
 <5358ca1a55a69_1f7b143d3101c@nysa.notmuch> <20140424134106.GA27035@thunk.org> <20140424195559.GA1336@luc-arch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 25 04:22:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdVms-00042B-J5
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 04:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbaDYCWp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 22:22:45 -0400
Received: from mail-ve0-f176.google.com ([209.85.128.176]:39018 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbaDYCWn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 22:22:43 -0400
Received: by mail-ve0-f176.google.com with SMTP id db11so3885132veb.21
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 19:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=QlkeXkVmSMyh6T1W/tlq0upvun02CEGychmn41/VWOM=;
        b=nog9ONf8S/VMNOpsVtOYuhRgQyXhIJkj9HQmNh3nUa4CnLgT9uHAjmVSsXVgmiUkhN
         UFjr3ansLkePH11sbZaMJWvf7HqVTCI+fIBy+oq1G+q208kHRj/xQ3+5dhJUECALHydM
         6RgKDrDE38k/uhOwhewqGoVRQUslF4aSo3bYEqUloB8h9ox5xVqkGWTtMHFkheYelFr2
         jpHz8lxClbQ6ibl2NmfxLSJSsdMqULKJnj7c4gAk0fjrK2hxmNjaTwhFEWo+J1iH4i4D
         Xqh9PmgkJyGcqiTO1MDP7KDscJHZVIOh0w6yKok8R2nRb9Q9VBCcSRSNIlPcTBDbCfgN
         DL/w==
X-Received: by 10.220.190.197 with SMTP id dj5mr4098414vcb.19.1398392563066;
 Thu, 24 Apr 2014 19:22:43 -0700 (PDT)
Received: by 10.220.251.199 with HTTP; Thu, 24 Apr 2014 19:22:23 -0700 (PDT)
In-Reply-To: <20140424195559.GA1336@luc-arch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247028>

Felipe's
=======

= The publish tracking branch =
I still have problems getting upstream branches correctly configured
as to have this introduced, anyway, I suppose it's optional, so
nothing to add on that.

By the way, remote branch managing has improved a lot,  one of the
best things I see for branching and remotes is the "git remote show"
command, but I think further work should be done. Help messages FTW!

= Reject non-fast-forward pulls by default =
Not having this introduced yet allows newbie people to use git with
just 4 commands, without bothering around with fetch and merge and so.

= Use "stage" instead of "index" =
Totally agree with this.

= Default aliases =
I hate aliases, make scripts more difficult to read and understand. I
would instead try to improve knowledge on this feature. I have to
agree with David Lang's first message, and

The cherry-pick => pick thing would be the only thing I would see with
good eyes, just because it's too long and has a dash.


Juno's
======
The idea about ~/.gitconfig seems incredible simple and effective to
me. I would however try to keep it simple, and minimize the form.


Mine
====
I have taught (or tried to) a lot of people Git. And this is some of
the stuff I have seen they have difficulties with:
- Remembering the commands, for example, remembering add, commit push
and pull, which I think we can all agree is the most core and simple
combination of Git commands.
- What command comes for what they need. If I want to share
everything, what should I do?
- Most of them, have real difficulties on remembering the flows. There
are too many commands for the start.

I wouldn't nevertheless suppress any of them, I would rather do a tuto
on-the-go.

Here are some ideas I have thought of:

== Command Output==
At the moment, there are several commands that don't output any help
text, and many others, that although they have become more verbose
with the years, they aren't too verbose yet.

One of the things I most recommend to anyone is to run "git status"
just before any command (push, commit, add, etc.) to get sure they are
doing what they thing they will.

For example, running git add won't tell you what you just added, nor
what you could do now. I would put some output there, maybe the git
status output or something similar that helps the user to know what
just happened.

Git status doesn't say much about remotes, and suggesting pushing if a
remote is outdated, would be fantastic.

Checkout command has decreased verbosity from a previous version,
where it stated which branch it came from and to which branch it was
switching to.

As an extreme thing, I would consider adding a configuration parameter
default, core.helptext=True that could switch off all this stuff.

==Running git==
This is a very basic idea, and I suppose it isn't too helpful or
realistic, but might give someone an idea.

I would first make that running git, just git, tell the user the
possibilities he has. I don't know of any power user that uses git to
remember the commands. At the moment, git[1] just tells many of the
commands available, without any classification, maybe classifying them
as "commiting" "branching" and "remote" could help a little.

Regards,

Javier Domingo Cansino

[1] git output:
----------------------------------------------------
javier@frodo:~$ git
usage: git [--version] [--help] [-C <path>] [-c name=value]
           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
           [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]
           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
           <command> [<args>]

The most commonly used git commands are:
   add        Add file contents to the index
   bisect     Find by binary search the change that introduced a bug
   branch     List, create, or delete branches
   checkout   Checkout a branch or paths to the working tree
   clone      Clone a repository into a new directory
   commit     Record changes to the repository
   diff       Show changes between commits, commit and working tree, etc
   fetch      Download objects and refs from another repository
   grep       Print lines matching a pattern
   init       Create an empty Git repository or reinitialize an existing one
   log        Show commit logs
   merge      Join two or more development histories together
   mv         Move or rename a file, a directory, or a symlink
   pull       Fetch from and integrate with another repository or a local branch
   push       Update remote refs along with associated objects
   rebase     Forward-port local commits to the updated upstream head
   reset      Reset current HEAD to the specified state
   rm         Remove files from the working tree and from the index
   show       Show various types of objects
   status     Show the working tree status
   tag        Create, list, delete or verify a tag object signed with GPG

'git help -a' and 'git help -g' lists available subcommands and some
concept guides. See 'git help <command>' or 'git help <concept>'
to read about a specific subcommand or concept.
----------------------------------------------------
