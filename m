From: Johan Herland <johan@herland.net>
Subject: Re: What's cooking in git.git (Mar 2010, #03; Wed, 10)
Date: Thu, 11 Mar 2010 12:09:10 +0100
Message-ID: <201003111209.10445.johan@herland.net>
References: <7v7hpj4k7w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 11 12:13:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpgKK-0000Rd-OE
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 12:13:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757505Ab0CKLNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 06:13:11 -0500
Received: from smtp.getmail.no ([84.208.15.66]:48310 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757084Ab0CKLNL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 06:13:11 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KZ400GH56ZBRU40@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 11 Mar 2010 12:09:11 +0100 (MET)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KZ400HQY6ZA1100@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 11 Mar 2010 12:09:11 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.3.11.110043
User-Agent: KMail/1.13.1 (Linux/2.6.32-ARCH; KDE/4.4.1; x86_64; ; )
In-reply-to: <7v7hpj4k7w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141954>

On Thursday 11 March 2010, Junio C Hamano wrote:
> [Cooking]
> 
> * sb/notes-parse-opt (2010-02-27) 1 commit
>  - notes: rework subcommands and parse options
>  (this branch uses early parts of jh/notes and tr/notes-display.)

The latest iteration of this looked good to me, but it might need a re-roll 
once tr/notes-display is set in stone/'next'.

> * tr/notes-display (2010-03-10) 13 commits
>  - git-notes(1): add a section about the meaning of history
>  - notes: track whether notes_trees were changed at all
>  - notes: add shorthand --ref to override GIT_NOTES_REF
>  - commit --amend: copy notes to the new commit
>  - rebase: support automatic notes copying
>  - notes: implement helpers needed for note copying during rewrite
>  - notes: implement 'git notes copy --stdin'
>  - rebase -i: invoke post-rewrite hook
>  - rebase: invoke post-rewrite hook
>  - commit --amend: invoke post-rewrite hook
>  - Documentation: document post-rewrite hook
>  - Support showing notes from more than one notes tree
>  - test-lib: unset GIT_NOTES_REF to stop it from influencing tests
>  (this branch uses early parts of jh/notes; is used by
> sb/notes-parse-opt.)
> 
> Re-rolled.  I think this is ready for 'next'.  Comments?

I just reviewed it, and it looks good to me.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
