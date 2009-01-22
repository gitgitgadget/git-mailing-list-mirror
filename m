From: Brent Goodrick <bgoodr@gmail.com>
Subject: Re: CR codes from git commands
Date: Thu, 22 Jan 2009 08:13:20 -0800
Message-ID: <18808.39712.351656.138702@hungover.brentg.com>
References: <18805.64312.289059.660023@hungover.brentg.com>
	<alpine.LNX.1.00.0901212319310.19665@iabervon.org>
	<e38bce640901212334v1e672d48t81d5c81fecd929eb@mail.gmail.com>
	<alpine.LNX.1.00.0901220238380.19665@iabervon.org>
	<7vbptzahra.fsf@gitster.siamese.dyndns.org>
	<e2b179460901220204x7b6a43b5hddfee623d2425429@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Brent Goodrick <bgoodr@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 17:15:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ2Ce-0002bB-Kq
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 17:14:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756264AbZAVQNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 11:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbZAVQNZ
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 11:13:25 -0500
Received: from rv-out-0506.google.com ([209.85.198.236]:35628 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756228AbZAVQNY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 11:13:24 -0500
Received: by rv-out-0506.google.com with SMTP id k40so4205482rvb.1
        for <git@vger.kernel.org>; Thu, 22 Jan 2009 08:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:mime-version
         :content-type:content-transfer-encoding:message-id:date:to:cc
         :subject:in-reply-to:references:x-mailer;
        bh=g1CvHM19pU2aSNz87RR2r8XiPZNF8H4xYiUJGPO2OVo=;
        b=DJtvtid4CRHKaJL20UMqYIp0e2X7Y8AnMNysxi56P4dDh/Jpv+vw4Peu59Tx1eNUSx
         QuTQEelAPtpEJTL8PBYYtCjZ8Fk+WfGqDInGLAOJBlrTaGG+/InI/bY/sT+TE0zvajaq
         NrJ/h5HkfHAWwKqpvQsMaeoll14Z0iL0ZUy+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:mime-version:content-type:content-transfer-encoding:message-id
         :date:to:cc:subject:in-reply-to:references:x-mailer;
        b=dfPq/Rc070UxLgep9uV/wHjz2byY73zJz+r0wP3NSMjE6T4W/lRHTBRDHaWec1IuZ0
         2oZt7RMwWoTskmsdOpjhTfWDKv7+pQ+bFM3BhcDZsdHTV1uhziw0Sa+qxd1AHo+BXl/z
         gXxmwwFSblnMQ+0WHMZBPDRc9mljsCG0euWfg=
Received: by 10.141.137.16 with SMTP id p16mr46084rvn.180.1232640803125;
        Thu, 22 Jan 2009 08:13:23 -0800 (PST)
Received: from hungover.brentg.com.thisisbogus.com ([76.14.208.3])
        by mx.google.com with ESMTPS id b8sm19032160rvf.9.2009.01.22.08.13.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Jan 2009 08:13:22 -0800 (PST)
In-Reply-To: <e2b179460901220204x7b6a43b5hddfee623d2425429@mail.gmail.com>
X-Mailer: VM viewmail-606 under 23.0.60.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106757>


Mike Ralphson writes:
 > >2009/1/22 Brent Goodrick <bgoodr@gmail.com>:
 > > The environment I'm running git under is the Shell mode inside GNU
 > > Emacs. I can't tell you what type of terminal it is, because I believe
 > > that is defined deep in the guts of Emacs. Having read your reply
 > > above, I'm now wondering whether this is an Emacs issue versus a git
 > > issue. If it is an Emacs issue, then I am truly embarrassed for having
 > > wasted everyones time with it.
 > 
 > 2009/1/22 Junio C Hamano <gitster@pobox.com>:
 > > I think we pay attention to "dumb" when deciding if pager is useful and if
 > > we can do color, but I do not think we check anything beyond "is it a tty"
 > > when deciding to show progress or not.  The only thing we do differently
 > > for "dumb" terminal is if we use ANSI clear-to-eol escape sequence or fill
 > > with a run of SPs to overwrite trailing part of a line, and we assume even
 > > dumb terminals know how to do a carriage-return.
 > 
 > I think this earlier discussion is probably relevant... I'm guessing
 > though, $EDITOR is set correctly here 8-)

I do have EDITOR set to a home-built version of gnuclient, and git
talks to Emacs by way of that gnuclient just fine when I'm not using the
-m "commit_message" git-commit option.

 > 
 > 2008/12/17 Junio C Hamano <gitster@pobox.com>:
 > > Any semi-good emacs users (let alone hackers) export PAGER=cat to be used
 > > in compilation mode (and possibly shell mode), so this is not a problem in
 > > practice.
 > >
 > > I have something like this in my .emacs:
 > >
 > >    (setenv "PAGER" "cat")
 > >
 > > I suspect (I am just a user not a hacker) this will have bad interaction
 > > with emacs terminal emulation mode, but I do not use the mode, so it is
 > > enough for me.

I have PAGER set to "cat" in the environment before I run Emacs for
the same reason.

Unfortunately, this morning when I rebooted and reloaded from scratch,
I am now unable to reproduce the CR codes output from "git pull" no
matter what I do. I even tried the older git installed on Debian Linux
"testing", and tried unsetting PAGER and GIT_PAGER, and saw the pager
prompts and the terminal escape sequence output as I expected to
(which is not the issue here).  I can't expect anyone else to help me
debug this problem further if I can't even reproduce it
anymore. Frustrating.

I do have automatic updates turned on, so perhaps something changed in
the termcap or how terminal I/O is being done outside of git in my
system.  Emacs would not have changed since I build Emacs from top of
trunk CVS, and it only uses local Elisp packages AFAIK.

I don't suppose git has any logic that emits the progress messages
based upon some estimate of amount of work it has to do, or has done,
does it?

Thanks,
Brent

P.S., for your reference, below is my evaluation script that
previously showed the CR code from git pull output. I even increased
the number of files added to the second repo up to 50 to see if the
quantity of files being pulled had any effect on the progress messages
output, but that didn't seem to have any effect. If anyone sees
anything bone-headed there, I'm all ears:

--- cut below this line --- 
#!/bin/sh
# -*-mode: Shell-script; indent-tabs-mode: nil; -*-

# I could have simply used "set -x" here but then I wouldn't see the
# redirection syntax like ">file1", so instead use a PrintRun
# function:
PrintRun ()
{
    echo "COMMAND: $*"
    eval "$*; exitcode=\$?"
    if [ $exitcode != 0 ]
    then
        echo "ERROR: Command failed: $*"
        exit 1
    fi
}

git_term_redirect=""
if [ "$USE_GIT_TERM_REDIRECT" = 1 ]
then
    git_term_redirect=" 2>&1 | cat"
    echo "Note: using git redirect on some git git commands: \"$git_term_redirect\""
fi

if [ "$USE_LOCALLY_BUILT_GIT" = 1 ]
then
    git_bin_dir="$HOME/git_from_source/install/bin"
    if [ -d "$git_bin_dir" ]
    then
        PATH="$HOME/git_from_source/install/bin:$PATH"; export PATH
    fi
fi

if [ "$SKIP_PAGER_HACK" = 1 ]
then
    unset PAGER
    echo "Note: setting PAGER to $PAGER"
else
    echo "Note: unsetting PAGER"
    PAGER=cat; export PAGER
fi

# Print out the git version as a double check on the above logic:
PrintRun git --version
# Clear out the scratch areas:
PrintRun rm -rf /tmp/git_area1
PrintRun rm -rf /tmp/git_area2
# Populate the initial area:
PrintRun mkdir -p /tmp/git_area1
PrintRun cd /tmp/git_area1
PrintRun git init
PrintRun "echo a new file 1 >file1"
PrintRun "echo a new file 2 >file2"
PrintRun git add file1
PrintRun git add file2
PrintRun git status
PrintRun "git commit -m \"first commit in git_area1\""
PrintRun find .
# Clone from the first area into a second area and add files there:
PrintRun rm -rf /tmp/git_area2
PrintRun cd /tmp
PrintRun git clone /tmp/git_area1 git_area2

PrintRun cd /tmp/git_area2
PrintRun find .
i=1
while [ $i -le 50 ]
do
    file="file_$i"
    echo "file==\"${file}\""
    PrintRun "echo a new file >$file"
    PrintRun git add $file
    PrintRun git status
    PrintRun "git commit -m \"committing new file $file but in git_area2\""
    #    PrintRun "git status; true" # true means don't fail inside PrintRun
    i=`expr $i + 1`
done

# Now attempt to pull the second repo changes back into into the first repo with a "git pull" operation:

PrintRun cd /tmp/git_area1
PrintRun "git status; true" # true means don't fail inside PrintRun
PrintRun "git diff; true" # true means don't fail inside PrintRun
if [ "$INJECT_TERM" != "" ]
then
    echo "Note: Exporting environment variable: TERM=\"$INJECT_TERM\""
    TERM="$INJECT_TERM"; export TERM
fi
PrintRun "git pull /tmp/git_area2 master $git_term_redirect"
# if [ "$STOP_AFTER_FIRST_GIT_PULL" = 1 ]
# then
#     echo "Note: Stopping after first git pull"
#     env | grep -i term
#     exit 0
# fi
PrintRun "git status; true" # true means don't fail inside PrintRun
PrintRun cat file_3
PrintRun "echo conflict1 >>file_3"
PrintRun git add file_3
PrintRun git status
PrintRun "git commit -m \"conflict1 added in git_area1\""

PrintRun cd /tmp/git_area2
PrintRun "echo conflict2 >>file_3"
PrintRun git add file_3
PrintRun git status
PrintRun "git commit -m \"conflict2 added in git_area2\""


PrintRun cd /tmp/git_area1
PrintRun "git status; true" # true means don't fail inside PrintRun
PrintRun "git diff; true" # true means don't fail inside PrintRun
# This git pull should show the conflict:
PrintRun "git pull /tmp/git_area2 master $git_term_redirect"
PrintRun cat file_3
PrintRun "echo conflict resolved > file_3"
# Running git commit now will fail:
### PrintRun "git commit -m \"conflict resolved\""
# Running git add on the file I just "resolved" by editing it directly above
PrintRun git add file_3
PrintRun "git status; true" # true means don't fail inside PrintRun
PrintRun "git commit -m \"conflict resolved\""
PrintRun "git log"
--- cut above this line --- 
