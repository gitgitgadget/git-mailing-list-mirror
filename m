From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFD/PATCH] submodule doc: describe where we can configure them
Date: Tue, 3 May 2016 17:59:58 -0700
Message-ID: <CAGZ79kb4GNZi93JpsPKUb7ScmePqDC1Xp+WZTGD7hfPUn9tWaQ@mail.gmail.com>
References: <1462317985-640-1-git-send-email-sbeller@google.com>
	<20160503235652.GA395@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 03:00:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axlAc-0001KF-LH
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 03:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756924AbcEDBAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 21:00:00 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:34302 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756856AbcEDA77 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 20:59:59 -0400
Received: by mail-io0-f170.google.com with SMTP id 190so40039619iow.1
        for <git@vger.kernel.org>; Tue, 03 May 2016 17:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=svRlVrPwzkVetp6rSEZihCYt3VsFVZp7YjCUlOxFaeQ=;
        b=Cuo9iDNdogr4cSJssN2La8RZorcFB9OvTdReR4ImgYx+KNIXZCd72oEzoMYvuI8QrL
         cr4qum0IVBrkx9oCH68U02e/rYbX6NyQJFQXnNYGI11Oa49VUjvWSVbru3GL5oRKJBzF
         WP3Ci0LnJCECclB5H7LZqaDvtrqdZC/GBM41/eJMadSlkvP8oM8ECrc5YYEhSJzySTZj
         l2LoVvMXmyY8nSE2EgN0jrY35uQWiLnz8sumlSsLBaNGZe6gUxdkOUMjQjVGIg6lm4Jy
         AqK/airh8yLC44DRaeE7+s74CiE0yIy44IZAC0BYfByro7DoMKrLxMEXy4suWjX3K9qD
         1ftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=svRlVrPwzkVetp6rSEZihCYt3VsFVZp7YjCUlOxFaeQ=;
        b=gJJ8uJZvCmGx7/1mqTy+VDyt+jgyPLSel+e5O/YAp/s0fPY1Z1J54318AqLzt1o9ah
         kYfFoCk1HhO/u4mezD7RyJEkBIT5GvvhCIqELT0dte8WjFQTyh0OIsmXYUhur3ttihwb
         aAI5EeNfK98Cg5xe/jHAEA1GmBDeUQ1o5U7veQBFIb1vmMZZZdK/6H0DIroIdRHf7r7B
         2yvE3uPaTcBVBnbsp6FIH+TOyZyeBCjQb7LK7gcbBIqLAKJFbJTxbd2jTT60GRADCSGc
         BEy0wCcfNuMkwyXOmI8V2zS3hUdZu8iUYzJcv3hFNHDVPkz4zR4GQxsgHCJ54omoyP1B
         j5dg==
X-Gm-Message-State: AOPr4FWb0REynSgJzPDV79cQniLNO9lWlD2QG+FP3k+J6S25GY3b4zXHvVAQRQtO4YLNe52hDj+g7EblgkpWPQej
X-Received: by 10.107.53.204 with SMTP id k73mr6841842ioo.174.1462323598135;
 Tue, 03 May 2016 17:59:58 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Tue, 3 May 2016 17:59:58 -0700 (PDT)
In-Reply-To: <20160503235652.GA395@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293484>

On Tue, May 3, 2016 at 4:56 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Stefan Beller wrote:
>
>> This is similar to the gitignore document, but doesn't mirror
>> the current situation. It is rather meant to start a discussion for
>> the right approach for mirroring repositories with submodules.
>
> Ooh.

Thanks for writing such a detailed answer. :)

>
> [...]
>> --- a/Documentation/git-submodule.txt
>> +++ b/Documentation/git-submodule.txt
>> @@ -59,6 +59,22 @@ instead of treating the other project as a submodule. Directories
>>  that come from both projects can be cloned and checked out as a whole
>>  if you choose to go that route.
>>
>> +Submodule operations can be configured using the following mechanisms
>> +(from highest to lowest precedence):
>> +
>> + * the command line for those commands that support taking submodule specs.
>> +
>> + * the configuration file `$GIT_DIR/config`.
>> +
>> + * the configuration file `config` found in the `refs/submodule/config` branch.
>> +   This can be used to overwrite the upstream configuration in the `.gitmodules`
>> +   file without changing the history of the project.
>> +   Useful options here are overwriting the base, where relative URLs apply to,
>> +   when mirroring only parts of the larger collection of submodules.
>> +
>> + * the `.gitmodules` file inside the repository. A project usually includes this
>> +   file to suggest defaults for the upstream collection of repositories.
>
> (This documentation probably belongs in gitmodules(5) --- then,
> git-submodule(1) could focus on command-line usage and point there for
> configuration information.)

That makes sense!

>
> There are two aspects of this to be separated: what governs the behavior
> of commands running locally, and where we get information about
> submodules from a remote repository.

After reading the first time, this seems to also contain "historical context".

>
> Local commands
> --------------
> The original submodule design was that local commands rely on
> information from .git/config, and that information gets copied there
> from .gitmodules when a submodule is initialized.  That way, a local
> user can specify their preferred mirror or other options using some
> straightforward 'git config' commands.
>
> As a side effect, the settings in .git/config tell git which submodules
> to pay attention to (which submodules were initialized).
>
> When .gitmodules changes, the settings in .git/config are left alone,
> since the end user *might* have manually set something up and we don't
> want to trample on it.
>
> This design is somewhat problematic for a few reasons:
>
> - When I want to stop paying attention to a particular submodule and
>   start paying attention to it again later, all my local settings are
>   gone.
>
> - When upstream adds a new submodule, I have to do the same manual
>   work to change the options for that new submodule.
>
> - When upstream changes submodule options (perhaps to fix a URL
>   typo), I don't get those updates.
>
> A fix is to use settings from .git/config when present and fall back
> to .gitmodules when not.  I believe the submodule code has been slowly
> moving in that direction for new features.  Perhaps we can do so for
> existing features (like submodule.*.url) too.
>
> An alternative would have been to introduce a .git/info/submodules
> file that overrides settings from .gitmodules, analagous to
> .git/info/excludes overriding .gitignore and .git/info/attributes
> overriding .gitattributes.  We are already using .git/config for
> this so that doesn't seem necessary.

I don't know if it is a worthwhile goal nevertheless to move
the information about submodules to .git/info/submodules eventually
as that brings consistency across different features of Git?

>
> Remote repositories
> -------------------
> The .gitmodules file has some odd properties as a place to put
> configuration:
>
> - it is versioned.  There is no way to change URLs in an old version
>   of .gitmodules retroactively when a URL has changed.

I would not call it odd for having one versioned place. Consider your
build process is updated and the new build process produces new
intermediate files. You would add these files to the .gitignore file
eventually, but when building old revisions with the new build chain
you'd be surprised by all those untracked files being displayed.
Or another example: Recently in git.git some test helper files were moved.
By checking out an older version of git you see a lot of test-* files
in your worktree although they were ignored at another revision.

That paragraph got longer than expected, but I just wanted to say that
being versioned can be either good or bad.

>
> - it is controlled by whoever writes history.  There is no way for me
>   to change the URLs in my mirror of https://gerrit.googlesource.com/gerrit
>   to match my mirror's different filesystem layout without producing
>   my own history that diverges from the commits I am mirroring.

To come up with an analogy to ignored files:
If I use a project and use a different build system, I may see untracked
files as they are not ignored by the .gitignore file.

Then I have a way of ignoring them nevertheless in .git/info/excludes.
Sharing this information beyond this repository is hard though, but
that wasn't seen as a feature yet?

>
> When the URLs in .gitmodules are relative URLs, this means that if
> I mirror a superproject, I have to mirror all its submodules, too,
> with the same layout.  It's not so easy for me to publish my copy
> of the parent project and the one subproject I made changes in --- I
> have to mirror everything.  In particular, this means I can't mirror
> https://gerrit.googlesource.com/gerrit to github.

because the way repository URLs work are different for these 2 hosts.
googlesource.com allows to have URLs that are nested in another level
e.g. Gerrit references "../plugins/download-commands", such that
remote URL becomes https://gerrit.googlesource.com/plugins/download-commands

At Github we cannot create another level of nesting as their naming follows the
owner/name scheme.

>
> When the URLs in .gitmodules are absolute URLs, this means that if
> I mirror a superproject, I cannot ask people consuming my mirror to
> use my mirrors of child projects, too.  I cannot publish my copy of
> the parent project and the one subproject I made changes in and
> expect people to be able to "git clone --recurse-submodules" the
> result successfully.


>
> It is as though refs were stored in a .gitrefs file, with all the
> attendant disadvantages, instead of being a separate component of
> the repository that a particular repository owner can manipulate
> without changing history.
>
> To fix this, we could allow additional .gitmodules settings to be put
> in another ref (perhaps something like "refs/repository/config" to allow
> sharing additional repository-specific configuration in other files
> within the same tree --- e.g., branch descriptions).  The semantics:
>
> * If there is a gitmodules file in refs/repository/config in the
>   repository I clone, then the submodule settings from it are stored
>   locally somewhere that overrides .gitmodules.  Perhaps
>   .git/info/<remotename>/gitmodules?
>
> * Later fetches from the remote would also update this gitmodules
>   file.
>
> * Settings from this gitmodules file can be overridden locally
>   using 'git config' until an explicit "git submodule sync" to
>   override the local configuration.
>
> What do you think?
>
> If two different remotes provide conflicting values for a setting
> in their gitmodules files, git would error out and ask the user
> to intervene with a tie-breaking "git config" setting.

Let's look at an example with C mirroring from B, who mirrors from A.

The user who clones the superproject from C may want to obtain submodules
from either C or B or A. All this can be configured in
the refs/repository/config value of C, but in case it is not configured in C,
it may fall back to the same branch from B. When and how would B get
that branch?

Thanks for writing out this detailed brain dump :)
Stefan

>
> Thanks,
> Jonathan
