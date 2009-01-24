From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] mergetool merge/skip/abort
Date: Sun, 25 Jan 2009 06:45:39 +0900
Message-ID: <20090125064539.6117@nanako3.lavabit.com>
References: <81bfc67a0901210637j52fa7a55q51b599e9ff16f6dc@mail.gmail.com>
	 <20090121170434.GA21727@hashpling.org>
	 <81bfc67a0901220617l22b5a8e4ma48bb069d67cae91@mail.gmail.com>
	 <20090122142258.GA2316@hashpling.org>
	 <81bfc67a0901230716i166bfc4chd9a5c0990b0cd3b6@mail.gmail.com>
	 <7vwscmue5z.fsf@gitster.siamese.dyndns.org>
	 <81bfc67a0901241036v6ca30c24q54487e118fd67c1c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Charles Bailey <charles@hashpling.org>, git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 22:47:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQqM3-0008W3-Vt
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 22:47:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755852AbZAXVq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 16:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755766AbZAXVq0
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 16:46:26 -0500
Received: from karen.lavabit.com ([72.249.41.33]:50139 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755087AbZAXVqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 16:46:25 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 81894C7B02;
	Sat, 24 Jan 2009 15:46:24 -0600 (CST)
Received: from 8816.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id 5287DY46POFY; Sat, 24 Jan 2009 15:46:24 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=C5c/4dE67RmXziN0sHbeE2S52N4a6pv0nNOTCe248BBBNFviiMHxnciBcmskhMLFqZuf98QSB/FzW6NpuGtZfFJrrNS0cvvURTJThLfxXl4yheYfnxIJe1yh/TZT2gA17lWmDaJuGWywdfNvN06hizpYs6oWdgruNaLdOj51+9I=;
  h=From:To:Cc:Subject:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107011>

Quoting Caleb Cushing <xenoterracide@gmail.com>:

>>  There are a few mergetool updates in flight from various authors.  How
>>  does your submission compare with others' in both form/presentation and
>>  clarity of logic (remember, I am not keeping track)?
>
> to be honest, a quick search of the past 2 months of patches didn't
> show me any patches that do the same thing as mine, so I'm not sure
> that comparing one feature to a different feature is good.

Junio never asked what your patch does. He didn't ask if it does
something similar to what other patches do, either.

Your 81bfc67a0901220617l22b5a8e4ma48bb069d67cae91@mail.gmail.com with
'Subject: Re: [PATCH] mergetool merge/skip/abort' that is sent to you and
'Cc: git@vger.kernel.org' starts its body with:

	From bf55fdd37f0fa4d0b3a10f43fa3d1815a6dbc6b3 Mon Sep 17 00:00:00 2001
	From: Caleb Cushing <xenoterracide@gmail.com>
	Date: Tue, 20 Jan 2009 11:33:30 -0500
	Subject: [PATCH] mergetool merge/skip/abort
	 add functionality to skip merging a file or abort from mergetool

	---
	 git-mergetool.sh |   20 ++++++++++++++++++--
	 1 files changed, 18 insertions(+), 2 deletions(-)

For comparison, 1232578668-2203-1-git-send-email-charles@hashpling.org from
Charles Bailey with 'Subject: [PATCH] mergetool: respect autocrlf by using
checkout-index', with 'Cc: Hannu Koivisto <azure@iki.fi>, Theodore Tso
<tytso@mit.edu>' starts its message body this way:

	Previously, git mergetool used cat-file which does not perform git to
	worktree conversion. This changes mergetool to use git checkout-index
	instead which means that the temporary files used for mergetool use the
	correct line endings for the platform.

	Signed-off-by: Charles Bailey <charles@hashpling.org>
	---
	 git-mergetool.sh     |   14 +++++++++++---
	 t/t7610-mergetool.sh |   15 +++++++++++++--
	 2 files changed, 24 insertions(+), 5 deletions(-)

Another example is 1232702093-24313-1-git-send-email-heipei@hackvalue.de
from Johannes Gilger with 'Subject: [PATCHv2] git mergetool: Don't repeat
merge tool candidates', sent to Junio, Theodore and the mailing list. Here
is its message body:

	git mergetool listed some candidates for mergetools twice, depending on
	the environment.

	Signed-off-by: Johannes Gilger <heipei@hackvalue.de>
	---
	The first patch had the fatal flaw that it listed nothing when DISPLAY 
	and EDITOR/VISUAL were unset, we fixed that.
	The order in which merge-candidates appear is still exactly the same, 
	only duplicates have been stripped. The check for KDE_FULL_SESSION was 
	removed since kdiff3 was added as long as DISPLAY was set and we weren't 
	running gnome.

	 git-mergetool.sh |   16 ++++++++--------
	 1 files changed, 8 insertions(+), 8 deletions(-)

Let's try to answer the first question Junio asked you together.
Can you spot the differences? How do they compare?

 1. You copy-and-pasted output from format-patch, and have the header
    part in the message body. Charles and Johannes have moved them to the
    Email header.

    Their messages are in the form the tool used for patch acceptance
    expects. Yours isn't, and forces Junio to manually edit your message
    before handling it.

 2. You have a two-line Subject: without any commit message. Both Charles
    and Johannes describe what their patches are about on the Subject
    succinctly in a single line, and they have what old behavior their
    patches change, and how their patches do so in their commit
    messages. They explained why it is good to apply their patches
    well. You didn't.

    Johannes Schindelin even pointed out this and the previous point when
    you sent your first version but you seem to have ignored him.

 3..You quoted other people's comments after the patch and explained that
    you addressed the issues, but didn't include them in your Cc list.
    Charles has Hanuu on his Cc list, and also Theodore (the original
    author) who knows the best about the tool. Johannes also sent his
    patch to people who gave him review comments.

    They made efforts to make sure that their patches are seen by people
    who helped refine thier patches and/or by people who knows the script
    that you are modifying well. You didn't.

 4. You didn't sign your patch.

    Please see Documentation/SubmittingPatches.

About the second question from Junio on the contents of the patch, I can
guess some comments you may receive from him when he reads your patch,
based on review comments I received from him on another shell script
recently.

	diff --git a/git-mergetool.sh b/git-mergetool.sh
	index 00e1337..bd5711e 100755
	--- a/git-mergetool.sh
	+++ b/git-mergetool.sh
	@@ -177,8 +177,24 @@ merge_file () {
	     describe_file "$local_mode" "local" "$LOCAL"
	     describe_file "$remote_mode" "remote" "$REMOTE"
	     if "$prompt" = true; then
	-       printf "Hit return to start merge resolution tool (%s): " "$merge_tool"
	-       read ans
	+        while true; do
	+            printf "Use (m)erge file or (s)kip file, or (a)bort? (%s): " \
	+            "$merge_tool"
	+            read ans
	+            case "$ans" in
	+                [mM]*|"")
	+                    break
	+                ;;
	+                [sS]*)
	+                    cleanup_temp_files
	+                    return 0
	+                ;;
	+                [aA]*)
	+                    cleanup_temp_files
	+                    exit 0
	+                ;;
	+            esac
	+        done
	     fi

	     case "$merge_tool" in

 1. Your printf message is funny. You either

      (1) Use $merge_tool to merge file, or
      (2) Skip file, or
      (3) Abort.

    but your message makes it look like:

      (1) Use $merge_tool to Merge file, or
      (2) Use $merge_tool to Skip file, or
      (3) Use $merge_tool to Abort.

 2. patterns in case command start at the same column as case and esac,
    and ";;" is at the same column as any other commands.

	case "$ans" in
	[mM]*|"")
		break
		;;
	[Ss]*)
		...
	esac

For what it's worth, I like what your patch does. I use mergetool from
time to time and I can imagine that this new feature will be useful.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
