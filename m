From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Status of all files (was: Re: How can I tell if a file is ignored by git?
Date: Fri, 09 Apr 2010 05:56:09 -0700 (PDT)
Message-ID: <m3sk74hjkg.fsf@localhost.localdomain>
References: <20100409040434.8602620CBBC@snark.thyrsus.com>
	<j2z8c9a061004082110se894f925i80c1389cd4e247f@mail.gmail.com>
	<20100409113248.GB27353@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jacob Helwig <jacob.helwig@gmail.com>,
	Eric Raymond <esr@snark.thyrsus.com>, git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Fri Apr 09 14:56:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0Dkw-0007yo-H8
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 14:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593Ab0DIM4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 08:56:13 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:61886 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077Ab0DIM4M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 08:56:12 -0400
Received: by fxm23 with SMTP id 23so2810338fxm.21
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 05:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=kZvTw+jaHeV4BQBnPEUW7G81CNE+N878M7LwIn9yrhE=;
        b=IhoCj8jhs7zNGH9uTO8A6qe9SkWe+UQ0bNttBw4JwZKjDCARvm7T3WoTyyo2PRpOkq
         Y/Yg9vwrvgfkr/Tf3tzLJNvNHKoxTq35/BBSarR4sqD8uT21BNv3OPu0/Xhr3RrIk31w
         tQFgIpLRcKY5qgb5bk0za29oebubfFSEPJLVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=MfGh933+ywHZl/fV9k35Fir49hUAItwbCaUCyKp7tC9xjTOCjefbFe2JxbygseGKzr
         NmJVnlD7dKAKufciTWnmqvqT9AhHsMWVUM1CjfmIXIEEph8CjSBs2/Rz1pUSOwgH1BoG
         TkR4/LVEUdh0xs3ryPqyRRJCCQNqRo0tfDV8U=
Received: by 10.102.17.29 with SMTP id 29mr20710muq.45.1270817769991;
        Fri, 09 Apr 2010 05:56:09 -0700 (PDT)
Received: from localhost.localdomain (abvc167.neoplus.adsl.tpnet.pl [83.8.200.167])
        by mx.google.com with ESMTPS id n10sm5158341mue.12.2010.04.09.05.56.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Apr 2010 05:56:08 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o39CtaA3011919;
	Fri, 9 Apr 2010 14:55:41 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o39CtC4d011911;
	Fri, 9 Apr 2010 14:55:12 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100409113248.GB27353@thyrsus.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144431>

Eric Raymond <esr@thyrsus.com> writes:

> Jacob Helwig <jacob.helwig@gmail.com>:
> > On Thu, Apr 8, 2010 at 21:04, Eric Raymond <esr@snark.thyrsus.com> wrote:
> > > I'm planning some work on Emacs VC mode.
> > >
> > > I need a command I can run on a path to tell if it's ignored by git.
> > 
> > What about a variant of:
> >     git ls-files -i -o --exclude-standard
> 
> That will do nicely, thank you.
> 
> There could be something better.  Emacs VC mode, and other similar
> front ends, would be greatly aided by a command that lists all files,
> each with a status code it can understand.

There is also

        git status --short

> Our canonical list (omitting two that apply only to locking systems)
> is:
> 
>   'up-to-date        The working file is unmodified with respect to the
>                      latest version on the current branch, and not locked.

In Git you don't have locking, but you have three versions: in the
working area (the working file), in the index, and latest version on
the current branch (the HEAD version).

So 'up-to-date in Git would probably mean working tree = cached = HEAD
version.

> 
>   'edited            The working file has been edited by the user.

Does this include stat-dirty files, i.e. if file has been modified
(mtime), but the contents is the same in working file and in HEAD
version?  See also 'git update-index --refresh' etc.

> 
>   'needs-update      The file has not been edited by the user, but there is
>                      a more recent version on the current branch stored
>                      in the master file.

Needs *update* looks like it came from centralized VCS like CVS and
Subversion, where you use update-the-commit method.  You can't say
that HEAD version is more recent that working file...

The rought equivalent would be that upstream branch for current branch
(e.g. 'origin/master' can be upstream for 'master' branch) is in
fast-forward state i.e. current branch is direct ancestor of
corresponding upstream branch, and the file was modified upstream.

> 
>   'needs-merge       The file has been edited by the user, and there is also
>                      a more recent version on the current branch stored in
>                      the master file.  This state can only occur if locking
>                      is not used for the file.

This, like 'needs-update, looks like it is relevant only in
update-the-commit workflow centralized VCS.

> 
>   'added             Scheduled to go into the repository on the next commit.
> 
>   'removed           Scheduled to be deleted from the repository on next commit.
> 
>   'conflict          The file contains conflicts as the result of a merge.

Note that with Git you can have other merge conflict than simple
CONFLICT(contents).  With CONFLICT(rename/rename) for example the file
would not contain textual conflict, so e.g. it won't have conflict
markers, etc.

> 
>   'missing           The file is not present in the file system, but the VC
>                      system still tracks it.

Note that file might be missing only in working directory, and can be
missing both in working directory and the index (staging area).

> 
>   'ignored           The file showed up in a dir-status listing with a flag
>                      indicating the version-control system is ignoring it,
> 
>   'unregistered      The file is not under version control.

[...]
> I am unclear on what your "unmerged" (M) status means.

Probably 'conflict.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
