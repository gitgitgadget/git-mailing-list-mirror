From: Johan Herland <johan@herland.net>
Subject: Re: What's cooking in git.git (Nov 2009, #05; Sun, 22)
Date: Mon, 23 Nov 2009 10:59:57 +0100
Message-ID: <200911231059.58233.johan@herland.net>
References: <7vhbsl935q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 11:00:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCViU-0002DB-AP
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 11:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756475AbZKWKAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 05:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756455AbZKWKAE
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 05:00:04 -0500
Received: from smtp.getmail.no ([84.208.15.66]:44506 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756417AbZKWKAD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Nov 2009 05:00:03 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KTK00JI73S53280@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 23 Nov 2009 11:00:05 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KTK00EDY3S2P320@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 23 Nov 2009 11:00:05 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.11.23.94526
User-Agent: KMail/1.12.3 (Linux/2.6.31-ARCH; KDE/4.3.3; x86_64; ; )
In-reply-to: <7vhbsl935q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133494>

On Monday 23 November 2009, Junio C Hamano wrote:
> * jh/notes (2009-11-20) 10 commits
>  - Add more testcases to test fast-import of notes
>  - Rename t9301 to t9350, to make room for more fast-import tests
>  - fast-import: Proper notes tree manipulation using the notes API
>  - Refactor notes concatenation into a flexible interface for combining notes
>  - Notes API: Allow multiple concurrent notes trees with new struct notes_tree
>  - Notes API: for_each_note(): Traverse the entire notes tree with a callback
>  - Notes API: get_note(): Return the note annotating the given object
>  - Notes API: add_note(): Add note objects to the internal notes tree structure
>  - Notes API: init_notes(): Initialize the notes tree from the given notes ref
>  - Notes API: get_commit_notes() -> format_note() + remove the commit restriction
> 
> Early part has been lived in 'next' for a while and has graduated.  This
> is a reroll of the remainder.  Is everybody happy with merging this to
> 'next'?

I really want an Ack from Shawn on the fast-import patch (patch 8/10)
before putting this in 'next'. The rest of the series is good AFAICS,
although there might be some changes needed if I need to rework the
fast-import patch.

> I saw some checkpatch style violations, but didn't find anything
> objectionable in the logic.

Ok. I fixed most of them locally, but there are still some remaining in
fast-import.c, where I'd rather follow fast-import.c's existing style,
which seems to disagree somewhat with checkpatch.

The style fixes will be part of the next iteration (which will also
include the rebase back onto the early part of the jh/notes series).
I'll wait for Shawn's comments before resending, though.

> [...]
>
> * sr/vcs-helper (2009-11-18) 12 commits
>  - Add Python support library for remote helpers
>  - Basic build infrastructure for Python scripts
>  - Allow helpers to report in "list" command that the ref is unchanged
>  - Fix various memory leaks in transport-helper.c
>  - Allow helper to map private ref names into normal names
>  - Add support for "import" helper command
>  - Allow specifying the remote helper in the url
>  - Add a config option for remotes to specify a foreign vcs
>  - Allow fetch to modify refs
>  - Use a function to determine whether a remote is valid
>  - Allow programs to not depend on remotes having urls
>  - Fix memory leak in helper method for disconnect
> 
> Replaced again.  Is everybody happy with merging this to 'next'?

Yep, assuming Daniel is happy with the transport layer parts.

For the record, you can add this to the last patch of the series:

Signed-off-by: Johan Herland <johan@herland.net>


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
