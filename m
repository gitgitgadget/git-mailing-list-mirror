From: Mike Hommey <mh@glandium.org>
Subject: Re: How to split a patch
Date: Mon, 28 Jan 2008 11:49:33 +0100
Organization: glandium.org
Message-ID: <20080128104932.GA20586@glandium.org>
References: <4d8e3fd30801280105g2876cedfjbe1ba323ede57e0a@mail.gmail.com> <7vhcgyuwsx.fsf@gitster.siamese.dyndns.org> <4d8e3fd30801280132k59676921h272addab6cac6899@mail.gmail.com> <vpqfxwi5ljf.fsf@bauges.imag.fr> <7vy7aatfck.fsf@gitster.siamese.dyndns.org> <7vr6g2teqh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 11:50:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJRZ2-0006Sy-AF
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 11:50:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571AbYA1Kth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 05:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752532AbYA1Ktg
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 05:49:36 -0500
Received: from smtp23.orange.fr ([80.12.242.97]:7646 "EHLO smtp23.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751324AbYA1Ktg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 05:49:36 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2307.orange.fr (SMTP Server) with ESMTP id 0D27D1C0004A
	for <git@vger.kernel.org>; Mon, 28 Jan 2008 11:49:34 +0100 (CET)
Received: from vaio.glandium.org (APuteaux-153-1-85-206.w86-205.abo.wanadoo.fr [86.205.43.206])
	by mwinf2307.orange.fr (SMTP Server) with ESMTP id CB6D91C000A9;
	Mon, 28 Jan 2008 11:49:33 +0100 (CET)
X-ME-UUID: 20080128104933833.CB6D91C000A9@mwinf2307.orange.fr
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1JJRYT-0005QJ-Bk; Mon, 28 Jan 2008 11:49:33 +0100
Content-Disposition: inline
In-Reply-To: <7vr6g2teqh.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71878>

On Mon, Jan 28, 2008 at 02:40:38AM -0800, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Yes, and you can do the same with "git add -i".  These tools are
> > not quite nice, as they encourage a wrong workflow of committing
> > what you haven't had as a whole in the work tree.  By
> > definition, you are making untested commits between your base
> > commit (that presumably was tested well) and your final commit
> > (that would also be tested well).
> > ...
> > There is no such tool yet, though.
> > 
> > The splitting you can do with "rebase -i" instead walks
> > forwards.  That also lets you test before you make commits in
> > each step.
> 
> Having said all that, what I tend to do in practice is something
> like this:
(...)

I just git commit the hunks, then git stash the rest of the changes, and
if I need some more changes to make the hunks only work, I commit --amend.

Once the commit is stable, I stash apply, resolving conflicts if any arose.

Mike
