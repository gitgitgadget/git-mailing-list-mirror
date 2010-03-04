From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: What's cooking in git.git (Mar 2010, #01; Wed, 03)
Date: Thu, 4 Mar 2010 23:21:35 +0100
Message-ID: <201003042321.36240.trast@student.ethz.ch>
References: <7v7hptt0mr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 05 02:16:30 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnJfb-00058d-Fe
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 23:37:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755903Ab0CDWWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 17:22:01 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:4634 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753443Ab0CDWWA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 17:22:00 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Thu, 4 Mar
 2010 23:21:58 +0100
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Thu, 4 Mar
 2010 23:21:37 +0100
User-Agent: KMail/1.13.1 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.1; x86_64; ; )
In-Reply-To: <7v7hptt0mr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141546>

On Thursday 04 March 2010 01:02:20 Junio C Hamano wrote:
> 
> * tr/notes-display (2010-02-23) 11 commits
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
>  (this branch uses early parts of jh/notes; is used by sb/notes-parse-opt.)
> 
> Didn't look too carefully except for the second one.

I hope to find the time to make a reroll this weekend.  Thanks for
your patience...

Meanwhile, I revived the automatic gmane-and-then-some notes
generation bot I wrote a year ago: point your core.notesref (or
notes.displayref with the above series) at

  git://repo.or.cz/git/trast.git notes/full

or for a version that only supplies Message-ID and gmane permalink,

  git://repo.or.cz/git/trast.git notes/terse

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
