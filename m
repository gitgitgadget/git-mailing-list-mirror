From: Johan Herland <johan@herland.net>
Subject: Re: What's cooking in git.git (Oct 2009, #03; Mon, 19)
Date: Mon, 19 Oct 2009 11:25:19 +0200
Message-ID: <200910191125.19997.johan@herland.net>
References: <7vhbtv6c76.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 11:25:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzoUb-0003sy-DZ
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 11:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755992AbZJSJZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 05:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755988AbZJSJZS
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 05:25:18 -0400
Received: from smtp.getmail.no ([84.208.15.66]:57380 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755975AbZJSJZR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Oct 2009 05:25:17 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KRR002SF8U97350@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 19 Oct 2009 11:25:21 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KRR00BA48U8J020@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 19 Oct 2009 11:25:21 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.10.19.90926
User-Agent: KMail/1.12.2 (Linux/2.6.30-ARCH; KDE/4.3.2; x86_64; ; )
In-reply-to: <7vhbtv6c76.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130683>

On Monday 19 October 2009, Junio C Hamano wrote:
> * jh/notes (2009-10-09) 22 commits.
>  - fast-import: Proper notes tree manipulation using the notes API
>  - Refactor notes concatenation into a flexible interface for combining notes
>  - Notes API: Allow multiple concurrent notes trees with new struct notes_tree
>  - Notes API: for_each_note(): Traverse the entire notes tree with a callback
>  - Notes API: get_note(): Return the note annotating the given object
>  - Notes API: add_note(): Add note objects to the internal notes tree structure
>  - Notes API: init_notes(): Initialize the notes tree from the given notes ref
>  - Notes API: get_commit_notes() -> format_note() + remove the commit restriction
>  - Add selftests verifying concatenation of multiple notes for the same commit
>  - Refactor notes code to concatenate multiple notes annotating the same object
>  - Add selftests verifying that we can parse notes trees with various fanouts
>  - Teach the notes lookup code to parse notes trees with various fanout schemes
>  - Teach notes code to free its internal data structures on request
>  - Add '%N'-format for pretty-printing commit notes
>  - Add flags to get_commit_notes() to control the format of the note string
>  - t3302-notes-index-expensive: Speed up create_repo()
>  - fast-import: Add support for importing commit notes
>  - Teach "-m <msg>" and "-F <file>" to "git notes edit"
>  - Add an expensive test for git-notes
>  - Speed up git notes lookup
>  - Add a script to edit/inspect notes
>  - Introduce commit notes
>  (this branch uses sr/gfi-options.)

Nope. This branch does not use sr/gfi-options. The jh/cvs-helper branch
does, though.

> Is this good for 'next' now?

Not all of it.

I suspect the first 14 patches are stable and 'next'-worthy, although
it would be nice if Dscho had the time to ACK them.

The last patch (#22) needs some major rework based on Shawn's comments
(I'm working on that, although I currently have less time than I hoped
for), and that rework might ripple into patches #15 through #21.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
