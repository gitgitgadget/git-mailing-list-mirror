From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Re* [PATCH] man: git pull -r is a short for --rebase
Date: Fri, 17 Aug 2012 21:22:32 +0100
Organization: OPDS
Message-ID: <907441D729554B0B8D876AD38B0FE7E0@PhilipOakley>
References: <20120816095018.GD5489@suse.cz> <7v1uj63iyx.fsf@alter.siamese.dyndns.org> <2BB1E674DD214C66B06660612F34109D@PhilipOakley> <7vk3wy1t7l.fsf@alter.siamese.dyndns.org> <B7310EA0CC00423EB5B26E3FAAB54541@PhilipOakley> <7vfw7mvy40.fsf_-_@alter.siamese.dyndns.org> <4E6C3BEFBD5345CC9FE0DC3C3AD41788@PhilipOakley> <7vk3wxti3f.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Miklos Vajna" <vmiklos@suse.cz>, "Git List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 22:22:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2T3x-00085G-P7
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 22:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758861Ab2HQUW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 16:22:28 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:36445 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758858Ab2HQUW1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Aug 2012 16:22:27 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArANAAynLlBZ8rLq/2dsb2JhbABFi0CuAQQBAQJ1gQiCGwUBAQQBCAEBLh4BARUHBQsCAwUCAQMRAQMBAQolFAEEGgYHCQYIBhMIAgECAwGGAIF2Cge6QosLAVktElE9g3RgA4gZhUKYBoJhgWA
X-IronPort-AV: E=Sophos;i="4.77,785,1336345200"; 
   d="scan'208";a="548224413"
Received: from host-89-242-178-234.as13285.net (HELO PhilipOakley) ([89.242.178.234])
  by out1.ip06ir2.opaltelecom.net with SMTP; 17 Aug 2012 21:22:24 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203641>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Friday, August 17, 2012 8:48 PM
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> diff --git a/Documentation/git.txt b/Documentation/git.txt
>> index ca85d1d..75b35ce 100644
>> --- a/Documentation/git.txt
>> +++ b/Documentation/git.txt
>> @@ -22,11 +22,13 @@ unusually rich command set that provides both
>> high-level operations
>>  and full access to internals.
>>
>>  See linkgit:gittutorial[7] to get started, then see
>> -link:everyday.html[Everyday Git] for a useful minimum set of
>> commands, and
>> -"man git-commandname" for documentation of each command.  CVS users
>> may
>> -also want to read linkgit:gitcvs-migration[7].  See
>> -the link:user-manual.html[Git User's Manual] for a more in-depth
>> -introduction.
>> +link:everyday.html[Everyday Git] for a useful minimum set of
>> commands.
>> +Use "man git-commandname" for documentation of each command, or "git
>> help".
>> +
>> +CVS users may also want to read linkgit:gitcvs-migration[7].
>> +
>> +See the link:user-manual.html[Git User's Manual] for a more in-depth
>> +introduction, and linkgit:gitcli[7] for details of git's command
>> line interface.
>>
>>  The '<command>' is either a name of a Git command (see below) or an
>> alias
>>  as defined in the configuration file (see linkgit:git-config[1]).
>
> I would prefer to keep the description section of git(1) not overly
> long.
>
> The first paragraph (not much shown above) concisely describes what
> Git is, so that people who were interested in other "git" can
> quickly tell that this is not a page to read about it.  I think it
> is in good shape.
>
> The purpose of the second paragraph is to guide people who are not
> ready to dive into this page and refer them to other pages with the
> introductory material, and also tell them that they can come back to
> this page to learn the set of commands Git offers once they are
> familiar with the concepts.
>
> And then, before going into the list of commands, we should tell
> them what we are listing, and where they can find more information.
>
> So in that sense, we would really want to keep the second paragraph
> short and to the point.  Referring migrating CVS users to another
> page before they get acquainted with Git like the current page does
> is a mistake.  On the other hand, gitcli may deserve to be mentioned
> in the third paragraph that gives the reader the sense of the overall
> structure of the documentation.

Certainly for those learning and in need of help, keeping paragraphs
short, to the point, and easy to read is a definate advantage. Once they
have found the right command then the documentation can become terse man
pages providing precise details. Your arrangement makes sense.

>
> The mention of cvs migration used to be more important in earlier
> days, but I think it was out of place to have it early in the
> document even back then.  It probably can be moved down to the
> FURTHER DOCUMENTATION section.

True.

At some point (in the future) the method of accessing the 
guides/articles (rather than the commands) should be mentioned 
(somewhere). e.g. that gittutorial can be accessed via 'git 
tutorial --help' or 'git help tutorial', along with 'git k' etc.
>
> So how about doing it this way?
>
I'm on msysgit so don't have the ascii docs tool chain, so I'm 
visualising.  Ack.
> -- >8 --
> Subject: [PATCH] Documentation: update the introductory section
>
> The second paragraph in the git(1) description section were meant to
> guide people who are not ready to dive into this page away from here.
> Referring migrating CVS users to another page before they get
> acquainted with Git was somewhat out of place.  Move the reference to
> the "FURTHER DOCUMENTATION" section and push that section down.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> Documentation/git.txt | 60
> +++++++++++++++++++++++++++------------------------
> 1 file changed, 32 insertions(+), 28 deletions(-)
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index eb6b2c0..33028a9 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -22,18 +22,17 @@ unusually rich command set that provides both
> high-level operations
> and full access to internals.
>
> See linkgit:gittutorial[7] to get started, then see
> -link:everyday.html[Everyday Git] for a useful minimum set of
> commands, and
> -"man git-commandname" for documentation of each command.  CVS users
> may
> -also want to read linkgit:gitcvs-migration[7].  See
> -the link:user-manual.html[Git User's Manual] for a more in-depth
> -introduction.
> +link:everyday.html[Everyday Git] for a useful minimum set of
> +commands.  The link:user-manual.html[Git User's Manual] has a more
> +in-depth introduction.
>
> -The '<command>' is either a name of a Git command (see below) or an
> alias
> -as defined in the configuration file (see linkgit:git-config[1]).
> +After you mastered the basic concepts, you can come back to this
> +page to learn what commands git offers.  You can learn more about
> +individual git commands with "git help command".  linkgit:gitcli[7]
> +manual page gives you an overview of the command line command syntax.
>
> -Formatted and hyperlinked version of the latest git
> -documentation can be viewed at
> -`http://git-htmldocs.googlecode.com/git/git.html`.
> +Formatted and hyperlinked version of the latest git documentation
> +can be viewed at `http://git-htmldocs.googlecode.com/git/git.html`.
>
> ifdef::stalenotes[]
> [NOTE]
> @@ -406,24 +405,6 @@ help ...`.
>  linkgit:git-replace[1] for more information.
>
>
> -FURTHER DOCUMENTATION
> ----------------------
> -
> -See the references above to get started using git.  The following is
> -probably more detail than necessary for a first-time user.
> -
> -The link:user-manual.html#git-concepts[git concepts chapter of the
> -user-manual] and linkgit:gitcore-tutorial[7] both provide
> -introductions to the underlying git architecture.
> -
> -See linkgit:gitworkflows[7] for an overview of recommended workflows.
> -
> -See also the link:howto-index.html[howto] documents for some useful
> -examples.
> -
> -The internals are documented in the
> -link:technical/api-index.html[GIT API documentation].
> -
> GIT COMMANDS
> ------------
>
> @@ -843,6 +824,29 @@ The index is also capable of storing multiple
> entries (called "stages")
> for a given pathname.  These stages are used to hold the various
> unmerged version of a file when a merge is in progress.
>
> +FURTHER DOCUMENTATION
> +---------------------
> +
> +See the references in the "description" section to get started
> +using git.  The following is probably more detail than necessary
> +for a first-time user.
> +
> +The link:user-manual.html#git-concepts[git concepts chapter of the
> +user-manual] and linkgit:gitcore-tutorial[7] both provide
> +introductions to the underlying git architecture.
> +
> +See linkgit:gitworkflows[7] for an overview of recommended workflows.
> +
> +See also the link:howto-index.html[howto] documents for some useful
> +examples.
> +
> +The internals are documented in the
> +link:technical/api-index.html[GIT API documentation].
> +
> +Users migrating from CVS may also want to
> +read linkgit:gitcvs-migration[7].
> +
> +
> Authors
> -------
> Git was started by Linus Torvalds, and is currently maintained by
> Junio
> -- 
> 1.7.12.rc3.71.ge297db8
>
Acked-by: Philip Oakley <philipoakley@iee.org>
