From: Johan Herland <johan@herland.net>
Subject: Re: What's cooking in git.git (Aug 2009, #06; Sun, 30)
Date: Mon, 31 Aug 2009 11:32:05 +0200
Message-ID: <200908311132.06031.johan@herland.net>
References: <7viqg48nxi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 31 11:32:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mi3FM-00063P-Kn
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 11:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889AbZHaJcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 05:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753837AbZHaJcJ
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 05:32:09 -0400
Received: from smtp.getmail.no ([84.208.15.66]:52520 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753883AbZHaJcI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Aug 2009 05:32:08 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KP80066LIHJMLA0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 31 Aug 2009 11:32:08 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KP80036HIHIDCA0@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 31 Aug 2009 11:32:07 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.31.91545
User-Agent: KMail/1.12.0 (Linux/2.6.30-ARCH; KDE/4.3.0; x86_64; ; )
In-reply-to: <7viqg48nxi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127474>

On Monday 31 August 2009, Junio C Hamano wrote:
> [Stalled]
>
> * jh/notes (2009-08-27) 12 commits.
>  - Add '%N'-format for pretty-printing commit notes
>  - Add flags to get_commit_notes() to control the format of the note
> string - notes.c: Implement simple memory pooling of leaf nodes
>  - Selftests verifying semantics when loading notes trees with various
> fanouts - Teach the notes lookup code to parse notes trees with various
> fanout schemes - t3302-notes-index-expensive: Speed up create_repo()
>  - fast-import: Add support for importing commit notes
>  - Teach "-m <msg>" and "-F <file>" to "git notes edit"
>  - Add an expensive test for git-notes
>  - Speed up git notes lookup
>  - Add a script to edit/inspect notes
>  - Introduce commit notes
>
> I heard the cvs-helper series depends on this one.  It seems that the
> fan-out strategy is being rethought?

Yes, I'm experimenting with various mixes of date-based and commit_sha1-
based fanouts. Will send a new series when I have some results to show. 
Might not have time to finish before next weekend, though.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
