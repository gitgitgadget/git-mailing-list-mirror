From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFD/PATCH] submodule doc: describe where we can configure them
Date: Tue, 3 May 2016 16:56:53 -0700
Message-ID: <20160503235652.GA395@google.com>
References: <1462317985-640-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 04 01:57:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axkC5-0001ef-TC
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 01:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756868AbcECX5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 19:57:30 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36488 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756860AbcECX52 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 19:57:28 -0400
Received: by mail-pf0-f176.google.com with SMTP id c189so17936397pfb.3
        for <git@vger.kernel.org>; Tue, 03 May 2016 16:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qeMbU2s9ZyBPherXLxfOwxkSHb5Y7w8Q+P/E1H0yXJ0=;
        b=PHswNcQDx9SF/jPbA8ICjrLdGuC9TCjiOGegMTaj6pONvEeZs1oWKd78fn6rYm8J3E
         c9rKHPVu/fdniDMsL/brkABtcKnqt5LilRO4CpG6mdXQUt8vqLAoe/B1NsgsiGoWLzVf
         aZtNCUMPZB9wpBnY/2y3xD3PzoBsXqkJcwZAFioyM1gYyyoTW77f595uZ84p4izkjL3H
         JV3KeQUpPEbGGPOrFXQuYLoO4l7zvWHe0xLHZ7VbMtdqvnUqRk/4r92Lsd+0dCPtm7W3
         PAXKkaLblr/hM9FvWN2glA74QQkLsMcAdTAZqR/lPuwjUv8HhlgUZYqOOxlt5wlfKKMV
         UFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qeMbU2s9ZyBPherXLxfOwxkSHb5Y7w8Q+P/E1H0yXJ0=;
        b=aG3Pd2rZtsC+iDDA09lhqYJFSM+dtDNUuf48lJZH3wpKhOb+QzU/dAXbDPGDsJWavU
         1kkffyZPsSGnuKGdWYe354sXLpVWz7WA2zAFRu7OvgEWRrMfR+FwSY1+QLQCG5OKnHDO
         6sXA0ZLRTSJLX31+BgUPn+lG57fhv06AvCwotFlj0IuNeEuiFNLxxXcpaUOuJUw/3E4O
         MM5iSvCc36q51s4+CMlTAwdwHUWxjE516eh8cTMUt2+UumH0g3IS/3ZLcYAvLqKIwumo
         AH+k0T0U3T7ZWBueXh63jEp+pPBYCKCbIa+g2Vt9bXhoB+VK64zPzAAFGhgXmhULD8d6
         mF4Q==
X-Gm-Message-State: AOPr4FWnNES0vo8PqxSa6L3CXsfamU/e4+0OE/O5+Q1AVKm/PUUiZ0Q5Sw+7aBLDaQMhQQ==
X-Received: by 10.98.10.136 with SMTP id 8mr7785219pfk.67.1462319847886;
        Tue, 03 May 2016 16:57:27 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:4851:afc:d444:8a50])
        by smtp.gmail.com with ESMTPSA id e7sm800045pfa.28.2016.05.03.16.57.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 03 May 2016 16:57:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1462317985-640-1-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293481>

Stefan Beller wrote:

> This is similar to the gitignore document, but doesn't mirror
> the current situation. It is rather meant to start a discussion for
> the right approach for mirroring repositories with submodules.

Ooh.

[...]
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -59,6 +59,22 @@ instead of treating the other project as a submodule. Directories
>  that come from both projects can be cloned and checked out as a whole
>  if you choose to go that route.
>  
> +Submodule operations can be configured using the following mechanisms
> +(from highest to lowest precedence):
> +
> + * the command line for those commands that support taking submodule specs.
> +
> + * the configuration file `$GIT_DIR/config`.
> +
> + * the configuration file `config` found in the `refs/submodule/config` branch.
> +   This can be used to overwrite the upstream configuration in the `.gitmodules`
> +   file without changing the history of the project.
> +   Useful options here are overwriting the base, where relative URLs apply to,
> +   when mirroring only parts of the larger collection of submodules.
> +
> + * the `.gitmodules` file inside the repository. A project usually includes this
> +   file to suggest defaults for the upstream collection of repositories.

(This documentation probably belongs in gitmodules(5) --- then,
git-submodule(1) could focus on command-line usage and point there for
configuration information.)

There are two aspects of this to be separated: what governs the behavior
of commands running locally, and where we get information about
submodules from a remote repository.

Local commands
--------------
The original submodule design was that local commands rely on
information from .git/config, and that information gets copied there
from .gitmodules when a submodule is initialized.  That way, a local
user can specify their preferred mirror or other options using some
straightforward 'git config' commands.

As a side effect, the settings in .git/config tell git which submodules
to pay attention to (which submodules were initialized).

When .gitmodules changes, the settings in .git/config are left alone,
since the end user *might* have manually set something up and we don't
want to trample on it.

This design is somewhat problematic for a few reasons:

- When I want to stop paying attention to a particular submodule and
  start paying attention to it again later, all my local settings are
  gone.

- When upstream adds a new submodule, I have to do the same manual
  work to change the options for that new submodule.

- When upstream changes submodule options (perhaps to fix a URL
  typo), I don't get those updates.

A fix is to use settings from .git/config when present and fall back
to .gitmodules when not.  I believe the submodule code has been slowly
moving in that direction for new features.  Perhaps we can do so for
existing features (like submodule.*.url) too.

An alternative would have been to introduce a .git/info/submodules
file that overrides settings from .gitmodules, analagous to
.git/info/excludes overriding .gitignore and .git/info/attributes
overriding .gitattributes.  We are already using .git/config for
this so that doesn't seem necessary.

Remote repositories
-------------------
The .gitmodules file has some odd properties as a place to put
configuration:

- it is versioned.  There is no way to change URLs in an old version
  of .gitmodules retroactively when a URL has changed.

- it is controlled by whoever writes history.  There is no way for me
  to change the URLs in my mirror of https://gerrit.googlesource.com/gerrit
  to match my mirror's different filesystem layout without producing
  my own history that diverges from the commits I am mirroring.

When the URLs in .gitmodules are relative URLs, this means that if
I mirror a superproject, I have to mirror all its submodules, too,
with the same layout.  It's not so easy for me to publish my copy
of the parent project and the one subproject I made changes in --- I
have to mirror everything.  In particular, this means I can't mirror
https://gerrit.googlesource.com/gerrit to github.

When the URLs in .gitmodules are absolute URLs, this means that if
I mirror a superproject, I cannot ask people consuming my mirror to
use my mirrors of child projects, too.  I cannot publish my copy of
the parent project and the one subproject I made changes in and
expect people to be able to "git clone --recurse-submodules" the
result successfully.

It is as though refs were stored in a .gitrefs file, with all the
attendant disadvantages, instead of being a separate component of
the repository that a particular repository owner can manipulate
without changing history.

To fix this, we could allow additional .gitmodules settings to be put
in another ref (perhaps something like "refs/repository/config" to allow
sharing additional repository-specific configuration in other files
within the same tree --- e.g., branch descriptions).  The semantics:

* If there is a gitmodules file in refs/repository/config in the
  repository I clone, then the submodule settings from it are stored
  locally somewhere that overrides .gitmodules.  Perhaps
  .git/info/<remotename>/gitmodules?

* Later fetches from the remote would also update this gitmodules
  file.

* Settings from this gitmodules file can be overridden locally
  using 'git config' until an explicit "git submodule sync" to
  override the local configuration.

What do you think?

If two different remotes provide conflicting values for a setting
in their gitmodules files, git would error out and ask the user
to intervene with a tie-breaking "git config" setting.

Thanks,
Jonathan
