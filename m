From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] submodule documentation: Reorder introductory paragraphs
Date: Fri, 22 May 2015 22:18:27 +0100
Organization: OPDS
Message-ID: <FB89514A616F4190A54B09E0520A7ADD@PhilipOakley>
References: <1432323527-26868-1-git-send-email-sbeller@google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <jrnieder@gmail.com>, <git@vger.kernel.org>, <hvoigt@hvoigt.net>,
	"Stefan Beller" <sbeller@google.com>
To: "Stefan Beller" <sbeller@google.com>, <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 22 23:17:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvuKM-0001dS-U5
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 23:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946226AbbEVVRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 17:17:50 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:38870 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1946007AbbEVVRs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 May 2015 17:17:48 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2AlEgDJm19VPJBLFlxcgxCBMoZNbcM3BAQCgTpNAQEBAQEBBwEBAQFAASQbQQODWQUBAQEBAgEIAQEuHgEBIQUGAgMFAgEDDgcMJRQBBBoGBwMUBgESCAIBAgMBiBMMtwSdXos6hQWDHoEWBYZphGg1hnx5izyOIIQEg1mBBIEpHIFTPTGCRwEBAQ
X-IPAS-Result: A2AlEgDJm19VPJBLFlxcgxCBMoZNbcM3BAQCgTpNAQEBAQEBBwEBAQFAASQbQQODWQUBAQEBAgEIAQEuHgEBIQUGAgMFAgEDDgcMJRQBBBoGBwMUBgESCAIBAgMBiBMMtwSdXos6hQWDHoEWBYZphGg1hnx5izyOIIQEg1mBBIEpHIFTPTGCRwEBAQ
X-IronPort-AV: E=Sophos;i="5.13,478,1427756400"; 
   d="scan'208";a="552051169"
Received: from host-92-22-75-144.as13285.net (HELO PhilipOakley) ([92.22.75.144])
  by out1.ip03ir2.opaltelecom.net with ESMTP; 22 May 2015 22:17:45 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269762>

From: "Stefan Beller" <sbeller@google.com>
> It's better to start the man page with a description of what 
> submodules
> actually are instead of saying what they are not.
>
> Reorder the paragraphs such that
> the first short paragraph introduces the submodule concept,
> the second paragraph highlights the usage of the submodule command,
> the third paragraph giving background information,
> and finally the fourth paragraph discusing alternatives such
> as subtrees and remotes, which we don't want to be confused with.
>
> This ordering deepens the knowledge on submodules with each paragraph.
> First the basic questions like "How/what" will be answered, while the
> underlying concepts will be taught at a later time.
>
> Making sure it is not confused with subtrees and remotes is not really
> enhancing knowledge of submodules itself, but rather painting the big
> picture of git concepts, so you could also argue to have it as the 
> second
> paragraph. Personally I think this may confuse readers, specially
> newcomers though.
>
> Additionally to reordering the paragraphs, they have been slightly
> reworded.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> For now I used a part of Junios suggestion
>    Submodules are not to be confused with remotes, which are other
>    repositories of the same project;
>
> I like the "are not to be confused" part, as they warn the reader
> that there will be a paragraph not as concise but touching other
> commands and topics.
>
> Documentation/git-submodule.txt | 50 
> ++++++++++++++++++-----------------------
> 1 file changed, 22 insertions(+), 28 deletions(-)
>
> diff --git a/Documentation/git-submodule.txt 
> b/Documentation/git-submodule.txt
> index 2c25916..d126c86 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -25,22 +25,17 @@ SYNOPSIS
>
> DESCRIPTION
> -----------
> -Submodules allow foreign repositories to be embedded within
> -a dedicated subdirectory of the source tree, always pointed
> -at a particular commit.
> +This command will inspect, update and manage submodules.
>
> -They are not to be confused with remotes, which are meant mainly
> -for branches of the same project; submodules are meant for
> -different projects you would like to make part of your source tree,
> -while the history of the two projects still stays completely
> -independent and you cannot modify the contents of the submodule
> -from within the main project.
> -If you want to merge the project histories and want to treat the
> -aggregated whole as a single project from then on, you may want to
> -add a remote for the other project and use the 'subtree' merge 
> strategy,
> -instead of treating the other project as a submodule. Directories
> -that come from both projects can be cloned and checked out as a whole
> -if you choose to go that route.
> +Submodules allow you to keep another Git repository in a subdirectory
> +of your repository. The other repository has its own history, which 
> does not
> +interfere with the history of the current repository. This can be 
> used to
> +have external dependencies such as libraries for example.
> +
> +When cloning or pulling a repository containing submodules however,
> +these will not be checked out by default; the 'init' and 'update'
> +subcommands will maintain submodules checked out and at
> +appropriate revision in your working tree.
>
> Submodules are composed from a so-called `gitlink` tree entry
> in the main repository that refers to a particular commit object
> @@ -51,19 +46,18 @@ describes the default URL the submodule shall be 
> cloned from.
> The logical name can be used for overriding this URL within your
> local repository configuration (see 'submodule init').
>
> -This command will manage the tree entries and contents of the
> -gitmodules file for you, as well as inspect the status of your
> -submodules and update them.
> -When adding a new submodule to the tree, the 'add' subcommand
> -is to be used.  However, when pulling a tree containing submodules,
> -these will not be checked out by default;
> -the 'init' and 'update' subcommands will maintain submodules
> -checked out and at appropriate revision in your working tree.
> -You can briefly inspect the up-to-date status of your submodules
> -using the 'status' subcommand and get a detailed overview of the
> -difference between the index and checkouts using the 'summary'
> -subcommand.
> -
> +Submodules are not to be confused with remotes, which are other
> +repositories of the same project;

I said (22 May 2015 20:47):
"if a nice well understood explanatory phrase can be found " - I'm happy 
with yours. Many thanks

>                                        submodules are meant for
> +different projects you would like to make part of your source tree,
> +while the history of the two projects still stays completely
> +independent and you cannot modify the contents of the submodule
> +from within the main project.
> +If you want to merge the project histories and want to treat the
> +aggregated whole as a single project from then on, you may want to
> +add a remote for the other project and use the 'subtree' merge 
> strategy,
> +instead of treating the other project as a submodule. Directories
> +that come from both projects can be cloned and checked out as a whole
> +if you choose to go that route.
>
> COMMANDS
> --------
> -- 
> 2.4.1.233.g3f9b614.dirty
>
> --
Philip 
