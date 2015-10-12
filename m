From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-multimail: update to release 1.2.0
Date: Mon, 12 Oct 2015 09:03:56 -0700
Message-ID: <xmqqy4f8m5ub.fsf@gitster.mtv.corp.google.com>
References: <1444589000-28664-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Oct 12 18:04:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zlfa0-0005Ze-Ie
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 18:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515AbbJLQD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 12:03:59 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36475 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbbJLQD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 12:03:57 -0400
Received: by pacex6 with SMTP id ex6so3576291pac.3
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 09:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=6XMgfMAwqKn3s5zmrfhlkaQJMkreB2pRGhCldd7vAaY=;
        b=eYbNl+X1gsQObe+VEdgO/iGeliltpQW/voSVZIMb/S6uqRRlsgceyL5M610CVM+HYZ
         bZxnfvJxriRpbUb/m2ysEC2qigGBrk7KRwq3zr/NIuh4wk0n6POu0yJJSA3TPSiUfyRW
         mMCWVcOngUGABNv1Ym5pgBCY/BKudLAPgEZfDM077rq4wL+2y/I2rGCQ2oO386bRMcZ/
         Jg4DsyeWEP25abCvH8Vu4K7Ds5XkC6nfDV5+Ijke/XGzGIi7jZKG00uqtbcxR8K8KXtY
         vf2gWwS3e2ySzGZ7C8KFGtBmSrWKgJ54mIy8kpYEZVCCOyasJ1qSxDmObQywj778KqMU
         rYDw==
X-Received: by 10.68.65.13 with SMTP id t13mr35291875pbs.43.1444665837320;
        Mon, 12 Oct 2015 09:03:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:448f:3a3:d25a:82f])
        by smtp.gmail.com with ESMTPSA id bh4sm19098535pbb.62.2015.10.12.09.03.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 12 Oct 2015 09:03:56 -0700 (PDT)
In-Reply-To: <1444589000-28664-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Sun, 11 Oct 2015 20:43:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279378>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The changes are described in CHANGES.
>
> Contributions-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> Contributions-by: Elijah Newren <newren@palantir.com>
> Contributions-by: Edward d'Auvergne <edward@nmr-relax.com>
> Contributions-by: Vadim Zeitlin <vadim@zeitlins.org>
> Contributions-by: Paul Sokolovsky <paul.sokolovsky@linaro.org>
> Contributions-by: Michael Haggerty <mhagger@alum.mit.edu>
> Contributions-by: Elijah Newren <newren@gmail.com>
> Contributions-by: Richard Hansen <rhansen@rhansen.org>
> Contributions-by: Job Snijders <job@instituut.net>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>

Yay ;-)

Thanks.

> ---
>  contrib/hooks/multimail/CHANGES                 |  41 ++
>  contrib/hooks/multimail/CONTRIBUTING.rst        |  30 +
>  contrib/hooks/multimail/README                  | 258 ++++---
>  contrib/hooks/multimail/README.Git              |   4 +-
>  contrib/hooks/multimail/doc/gerrit.rst          |  56 ++
>  contrib/hooks/multimail/doc/gitolite.rst        | 109 +++
>  contrib/hooks/multimail/git_multimail.py        | 936 ++++++++++++++++++++----
>  contrib/hooks/multimail/migrate-mailhook-config |   2 +-
>  contrib/hooks/multimail/post-receive.example    |   8 +-
>  9 files changed, 1218 insertions(+), 226 deletions(-)
>  create mode 100644 contrib/hooks/multimail/CONTRIBUTING.rst
>  create mode 100644 contrib/hooks/multimail/doc/gerrit.rst
>  create mode 100644 contrib/hooks/multimail/doc/gitolite.rst
>
> diff --git a/contrib/hooks/multimail/CHANGES b/contrib/hooks/multimail/CHANGES
> index 6bb1230..bc77e66 100644
> --- a/contrib/hooks/multimail/CHANGES
> +++ b/contrib/hooks/multimail/CHANGES
> @@ -1,3 +1,44 @@
> +Release 1.2.0
> +=============
> +
> +* It is now possible to exclude some refs (e.g. exclude some branches
> +  or tags). See refFilterDoSendRegex, refFilterDontSendRegex,
> +  refFilterInclusionRegex and refFilterExclusionRegex.
> +
> +* New commitEmailFormat option which can be set to "html" to generate
> +  simple colorized diffs using HTML for the commit emails.
> +
> +* git-multimail can now be ran as a Gerrit ref-updated hook, or from
> +  Atlassian BitBucket Server (formerly known as Atlassian Stash).
> +
> +* The From: field is now more customizeable. It can be set
> +  independently for refchange emails and commit emails (see
> +  fromCommit, fromRefChange). The special values pusher and author can
> +  be used in these configuration variable.
> +
> +* A new command-line option, --version, was added. The version is also
> +  available in the X-Git-Multimail-Version header of sent emails.
> +
> +* Set X-Git-NotificationType header to differentiate the various types
> +  of notifications. Current values are: diff, ref_changed_plus_diff,
> +  ref_changed.
> +
> +* Preliminary support for Python 3. The testsuite passes with Python 3,
> +  but it has not received as much testing as the Python 2 version yet.
> +
> +* Several encoding-related fixes. UTF-8 characters work in more
> +  situations (but non-ascii characters in email address are still not
> +  supported).
> +
> +* The testsuite and its documentation has been greatly improved.
> +
> +Plus all the bugfixes from version 1.1.1.
> +
> +This version has been tested with Python 2.4 and 2.6 to 3.5, and Git
> +v1.7.10-406-gdc801e7, git-1.8.2.3 and 2.6.0. Git versions prior to
> +v1.7.10-406-gdc801e7 probably work, but cannot run the testsuite
> +properly.
> +
>  Release 1.1.1 (bugfix-only release)
>  ===================================
>  
