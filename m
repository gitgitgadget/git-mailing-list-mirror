From: Johan Herland <johan@herland.net>
Subject: Re: What's cooking in git.git (Jan 2010, #06; Wed, 20)
Date: Thu, 21 Jan 2010 10:18:10 +0100
Message-ID: <201001211018.10085.johan@herland.net>
References: <7vljfsxos5.fsf@alter.siamese.dyndns.org>
 <201001210240.10522.johan@herland.net>
 <7vvdeww187.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 10:18:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXtBF-0004Uo-8D
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 10:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754469Ab0AUJSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 04:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754133Ab0AUJSO
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 04:18:14 -0500
Received: from smtp.getmail.no ([84.208.15.66]:35536 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754122Ab0AUJSN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jan 2010 04:18:13 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWL00FO4B6BA1B0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 21 Jan 2010 10:18:11 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWL0071EB6ADK20@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 21 Jan 2010 10:18:11 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.21.90318
User-Agent: KMail/1.12.4 (Linux/2.6.32-ARCH; KDE/4.3.4; x86_64; ; )
In-reply-to: <7vvdeww187.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137643>

On Thursday 21 January 2010, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > On Thursday 21 January 2010, Sverre Rabbelier wrote:
> >> On Thu, Jan 21, 2010 at 01:52, Junio C Hamano <gitster@pobox.com> 
wrote:
> >> > * jh/notes (2010-01-17) 23 commits
> >> > [...]
> >> > Updated with a re-roll.
> >>
> >> Just checking, you reverted all from next (with exception of the first
> >> three), and now re-queued it to pu, with the first three still in
> >> next? Or did I mis-remember and did only the first three make it to
> >> next in the first place?
> >
> > You misremembered. Only the three first were merged to 'next'. Junio
> > was about to merge the rest, but I asked him to hold until I had
> > produced the current iteration.
> 
> I've been meaning to merge the first three to 'master', as many people
> have been running 'next' and new features tend to be exercised less by
> those on 'master' than on 'next', and it would be beneficial to make
> 'master' at 1.7.0-rc0 as close to what we have had in 'next' for a long
> time.
> 
> Worries?

Maybe. I've got a maybe-todo entry about (yet again) rewriting the fast-
import handling of notes to use the updated notes API (which now can handle 
non-notes, and therefore should be better suited for fast-import's use 
case). However, the result is only worth submitting if it _both_ decreases 
code duplication between fast-import.c and notes.c, _and_ decreases the 
overall impact on fast-import.c. I don't know when I'll get around to doing 
this experiment, so feel free to ignore it for now.

In any case, I totally understand if you'd rather want to hold the entire 
notes series in 'pu', and instead focus on fixing the bugs in what's already 
been released.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
