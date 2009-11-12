From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Re: Unhelpful "branch.master.remote = <nickname>" advice?
Date: Thu, 12 Nov 2009 16:03:18 +0100
Message-ID: <27579251-CF07-4C65-8CE1-AE912BCF3243@dbservice.com>
References: <1257945756.26362.79.camel@heerbeest> <48B54636-1825-48B3-BECD-4150A55B013F@dbservice.com> <1257965806.26362.132.camel@heerbeest> <D6B0AE61-6CA3-4F79-BB50-B8795415BAB7@dbservice.com> <1257968052.26362.155.camel@heerbeest> <AC99BA30-A36D-4798-8E7D-9D69EFE99D55@dbservice.com> <1258035449.26362.273.camel@heerbeest>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
X-From: git-owner@vger.kernel.org Thu Nov 12 16:03:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8bCs-00089J-J5
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 16:03:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950AbZKLPDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 10:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752701AbZKLPDS
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 10:03:18 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:44599 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752750AbZKLPDS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 10:03:18 -0500
Received: by fxm21 with SMTP id 21so2339168fxm.21
        for <git@vger.kernel.org>; Thu, 12 Nov 2009 07:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=bEISXJ+BBV8I6v5WQqIF7JM8NBNTBJkf1x4Byw4v5dY=;
        b=FRI2w8xaTmoH2Yn1NpwI4++cSfChgcnYmOfIxPrL1U7gy91icwGN+DwEng5esLMmNS
         gvpYKs7GXj1hf6qcM5Dt0jMOWkn4Fkc8FB552tsD833HogRs867oUhDoj8pjEKfPBmQn
         TbHmppqiw7AfqV5ZDSsBURcHRgB++HlRuxrWY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=U/tUSpbWZ5Y8lzihA6MHZJqwfBl6daRjxhE/d95vw4xoOpg75jbNPLooGHHQVODqjB
         wD/DP0IsNxjPvNcxCXqTOGrdeaBYbEy7Ib+DUBACs9BAS4dPhr1FUhRxtSjPu+hFEEPe
         +ExxnM19je5rnhPIxxtsV6eIzYc7OanB6nlHw=
Received: by 10.204.4.144 with SMTP id 16mr3280597bkr.116.1258038201590;
        Thu, 12 Nov 2009 07:03:21 -0800 (PST)
Received: from ?10.3.112.244? ([147.88.200.112])
        by mx.google.com with ESMTPS id 9sm1569233fks.34.2009.11.12.07.03.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Nov 2009 07:03:19 -0800 (PST)
In-Reply-To: <1258035449.26362.273.camel@heerbeest>
X-Mailer: Apple Mail (2.1076)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132771>


On Nov 12, 2009, at 3:17 PM, Jan Nieuwenhuizen wrote:
>
> Okay, so now I have
>
>    [branch "master"]
> 	    remote = origin
> 	    merge = refs/heads/master
>    [remote "origin"]
> 	    url = git@github.com:janneke/gub.git
> 	    fetch = +refs/heads/*:refs/remotes/origin/*
>    # advise from git pull, using <nickname> = eddy
>    #        branch.master.remote = <nickname>
>    #        branch.master.merge = <remote-ref>
>    #        remote.<nickname>.url = <url>
>    #        remote.<nickname>.fetch = <refspec>
>    #[branch "master"]
>    #	remote = eddy
>    #	merge = refs/heads/master
>    [remote "eddy"]
> 	    url = http://github.com/epronk/gub.git
>    #use remote.eddy.fetch to +refs/heads/*:refs/remotes/eddy/*.
> 	    fetch = +refs/heads/*:refs/remotes/eddy/*
>
> It looked promising, but still get
>
>    15:00:20 janneke@peder:~/vc/gub
>    $ git pull -r --verbose
>    From git@github.com:janneke/gub
>     = [up to date]      lilypond-release-branch -> origin/lilypond- 
> release-branch
>     = [up to date]      master     -> origin/master
>    Current branch master is up to date.
>    15:00:26 janneke@peder:~/vc/gub
>    $ git pull -r --verbose eddy
>    From http://github.com/epronk/gub
>     = [up to date]      lilypond-release-branch -> eddy/lilypond- 
> release-branch
>     = [up to date]      master     -> eddy/master
>    You asked me to pull without telling me which branch you
>    want to merge with, and 'branch.master.merge' in
>    your configuration file does not tell me either.	Please
>    specify which branch you want to merge on the command line and
>    try again (e.g. 'git pull <repository> <refspec>').
>    See git-pull(1) for details.
>
>    If you often merge with the same branch, you may want to
>    configure the following variables in your configuration
>    file:
>
> 	branch.master.remote = <nickname>
> 	branch.master.merge = <remote-ref>
> 	remote.<nickname>.url = <url>
> 	remote.<nickname>.fetch = <refspec>
>
>    See git-config(1) for details.
>    [1]15:00:33 janneke@peder:~/vc/gub
>    $

Do you want to rebase on top of origin or eddy? It doesn't make sense  
to rebase on top of both.

With git you usually develop new features in branches and then merge  
the result into the master branch once it's ready. So you would use a  
branch 'feature-X' and there you work on your feature. Since it's your  
private/local branch, you can rebase it however you want. In the  
meantime eddy has also worked on some new cool features, and now that  
he's ready he told you to pull from his branch. So you 'git checkout  
master; git pull eddy master' to merge his new features. Then you can  
push the result into your github repo, checkout feature-X and rebase  
that on top of the new origin/master. Once your feature is done, you  
can checkout master, merge feature-X and push that to github.

Another reason not to rebase on top of eddy's master branch is this:  
if is master is behind your master (eg. your master has commits that  
his master doesn't), and you rebase on top of his master, you loose  
the commits.

>
> After this I started to re-read git-config's man page
> again.  There is something strange that I do not understand
>
>    branch.<name>.merge
>        Defines, together with branch.<name>.remote, the upstream
>        branch for the given branch.  It tells git-fetch/git-pull
>        which branch to merge and can also affect git-push (see
>        push.default).
>
> this seems to imply that the merge variable here
>
>   [branch "master"]
>       remote = FOOBAR
>       merge = refs/heads/master
>
> is somehow tied to the remote nick FOOBAR.  That would
> mean it is actually taken as
>
>     branch.<name>.<nickname>.merge
>
> and also that it's impossible to specify more than one
> <nickname>.  That would be make nicknames unusable and
> thus silly, so I cannot be right?

It seems like 'git pull <remote>' doesn't work. Either use 'git pull',  
in which case git takes the needed info from  
branch.<name>.remote/.merge, or use 'git pull <remote> <branch>' in  
which case git will use the info from the commandline. It doesn't make  
much sense to say 'pull from X but rebase on top of the same remote  
branch name as if you'd pull from Y'.

tom
