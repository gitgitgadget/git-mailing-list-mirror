From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] Documentation: Use 'First Paragraph' instead of 'First Line'.
Date: Thu, 13 Sep 2012 19:45:50 +0100
Organization: OPDS
Message-ID: <AAA3E50085B245A18F97A80EB059F11D@PhilipOakley>
References: <5051D4A0.4060608@codeweavers.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Jeremy White" <jwhite@codeweavers.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 13 20:46:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCEQL-0004Mc-OI
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 20:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755758Ab2IMSpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 14:45:53 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:44748 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753883Ab2IMSpv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Sep 2012 14:45:51 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AsALAMEoUlBZ8rU+/2dsb2JhbABFi0avMwICeoEIghsFAQEEAQgBAS4RBQgBASYGAgMFAgEDDgMDAQEBCiUUAQQYAgYHDwgGAQcLCAIBAgMBDASHZgoHu2uLEFF5GxmDWWADiCCFRIkQjw2CZ4Fi
X-IronPort-AV: E=Sophos;i="4.80,418,1344207600"; 
   d="scan'208";a="403297312"
Received: from host-89-242-181-62.as13285.net (HELO PhilipOakley) ([89.242.181.62])
  by out1.ip02ir2.opaltelecom.net with SMTP; 13 Sep 2012 19:45:48 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205411>

From: "Jeremy White" <jwhite@codeweavers.com>
Sent: Thursday, September 13, 2012 1:42 PM
> The discussion of email subject throughout the documentation is
> misleading; it indicates that the first line will become the subject.
> In fact, the first and second and third lines will become the subject,
> up until the first full blank line.  Describing it as the first 
> paragraph

This  "up until the first full blank line" part should also be in the 
documentation itself to clarify how a 'paragraph' is delineated. I've 
shown one place it could go below.

> is more accurate.
>
> Signed-off-by: Jeremy White <jwhite@codeweavers.com>
> ---
> Documentation/git-commit.txt       |    2 +-
> Documentation/git-for-each-ref.txt |    2 +-
> Documentation/git-format-patch.txt |    8 +++++---
> Documentation/git-shortlog.txt     |    2 +-
> Documentation/gitcore-tutorial.txt |    2 +-
> Documentation/gittutorial.txt      |    2 +-
> Documentation/user-manual.txt      |    2 +-
> 7 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/git-commit.txt 
> b/Documentation/git-commit.txt
> index e99bb14..a61bca9 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -349,7 +349,7 @@ DISCUSSION
> Though not required, it's a good idea to begin the commit message
> with a single short (less than 50 character) line summarizing the
> change, followed by a blank line and then a more thorough description.
> -Tools that turn commits into email, for example, use the first line
> +Tools that turn commits into email, for example, use the first 
> paragraph
> on the Subject: line

    "up until the first full blank line"

>                               and the rest of the commit in the body.
>
> include::i18n.txt[]
> diff --git a/Documentation/git-for-each-ref.txt 
> b/Documentation/git-for-each-ref.txt
> index 7e83288..499c26a 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -100,7 +100,7 @@ Fields that have name-email-date tuple as its 
> value (`author`,
> `committer`, and `tagger`) can be suffixed with `name`, `email`,
> and `date` to extract the named component.
>
> -The first line of the message in a commit and tag object is
> +The first paragraph of the message in a commit and tag object is
> `subject`, the remaining lines are `body`.  The whole message
> is `contents`.
>
> diff --git a/Documentation/git-format-patch.txt 
> b/Documentation/git-format-patch.txt
> index 9674f9d..e6f6d0e 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -57,10 +57,12 @@ output, unless the `--stdout` option is specified.
> If `-o` is specified, output files are created in <dir>.  Otherwise
> they are created in the current working directory.
>
> -By default, the subject of a single patch is "[PATCH] First Line" and
> +By default, the subject of a single patch is "[PATCH] First 
> Paragraph" and
> the subject when multiple patches are output is "[PATCH n/m] First
> -Line". To force 1/1 to be added for a single patch, use `-n`.  To 
> omit
> -patch numbers from the subject, use `-N`.
> +Paragraph". Note that "First Paragraph" consists of text in the 
> commit message
> +prior to the first completely blank line (see the DISCUSSION section
> +in linkgit:git-commit[1]).  To force 1/1 to be added for a single 
> patch,
> +use `-n`.  To omit patch numbers from the subject, use `-N`.
>
> If given `--thread`, `git-format-patch` will generate `In-Reply-To` 
> and
> `References` headers to make the second and subsequent patch mails 
> appear
> diff --git a/Documentation/git-shortlog.txt 
> b/Documentation/git-shortlog.txt
> index dfd4d0c..9464932 100644
> --- a/Documentation/git-shortlog.txt
> +++ b/Documentation/git-shortlog.txt
> @@ -15,7 +15,7 @@ DESCRIPTION
> -----------
> Summarizes 'git log' output in a format suitable for inclusion
> in release announcements. Each commit will be grouped by author and
> -the first line of the commit message will be shown.
> +the first paragraph of the commit message will be shown.
>
> Additionally, "[PATCH]" will be stripped from the commit description.
>
> diff --git a/Documentation/gitcore-tutorial.txt 
> b/Documentation/gitcore-tutorial.txt
> index f7815e9..92f97e6 100644
> --- a/Documentation/gitcore-tutorial.txt
> +++ b/Documentation/gitcore-tutorial.txt
> @@ -956,7 +956,7 @@ $ git show-branch --topo-order --more=1 master 
> mybranch
> ------------------------------------------------
>
> The first two lines indicate that it is showing the two branches
> -and the first line of the commit log message from their
> +and the first paragraph of the commit log message from their
> top-of-the-tree commits, you are currently on `master` branch
> (notice the asterisk `\*` character), and the first column for
> the later output lines is used to show commits contained in the
> diff --git a/Documentation/gittutorial.txt 
> b/Documentation/gittutorial.txt
> index 1c16066..a1bc56c 100644
> --- a/Documentation/gittutorial.txt
> +++ b/Documentation/gittutorial.txt
> @@ -139,7 +139,7 @@ A note on commit messages: Though not required, 
> it's a good idea to
> begin the commit message with a single short (less than 50 character)
> line summarizing the change, followed by a blank line and then a more
> thorough description.  Tools that turn commits into email, for
> -example, use the first line on the Subject: line and the rest of the
> +example, use the first paragraph on the Subject: line and the rest of 
> the
> commit in the body.
>
> Git tracks content not files
> diff --git a/Documentation/user-manual.txt 
> b/Documentation/user-manual.txt
> index fe6fb72..dd2f985 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -1126,7 +1126,7 @@ Though not required, it's a good idea to begin 
> the commit message
> with a single short (less than 50 character) line summarizing the
> change, followed by a blank line and then a more thorough
> description.  Tools that turn commits into email, for example, use
> -the first line on the Subject line and the rest of the commit in the
> +the first paragraph on the Subject line and the rest of the commit in 
> the
> body.
>
> [[ignoring-files]]
> -- 
> 1.7.9.5
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> -----
> No virus found in this message.
> Checked by AVG - www.avg.com
> Version: 2012.0.2221 / Virus Database: 2437/5266 - Release Date: 
> 09/13/12
> 
