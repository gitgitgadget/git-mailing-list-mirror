From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash: Add long option completion for 'git send-email'
Date: Tue, 15 Jul 2008 04:58:56 +0000
Message-ID: <20080715045856.GH2432@spearce.org>
References: <1216023662-9109-1-git-send-email-tlikonen@iki.fi> <20080715043839.GE2432@spearce.org> <7vmykjda5i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 06:59:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIcdo-0003wF-IX
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 06:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbYGOE65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 00:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752229AbYGOE65
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 00:58:57 -0400
Received: from george.spearce.org ([209.20.77.23]:33826 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbYGOE65 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 00:58:57 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 891413836B; Tue, 15 Jul 2008 04:58:56 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vmykjda5i.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88522>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Hmm.  With dash form commands gone in 1.6 we should remove these.
> >
> > But I suspect this completion patch could be shipped in the next
> > 1.5.6 maint release as its really quite trivial.  Junio, any comment
> > on that?
> 
> Yeah, it is trivial but does it deserve "bugfix -- we need to deliver this
> change to the end users, otherwise they will suffer" label?  Probably not.

Not really, but we have shipped new completion functionality (missing
--graph option to git-log) in maint releases in recent history.

If it was me maintaining git.git, I'd probably toss this into maint.
But I think I have a more aggressive personality than you, and am
more willing to take a risk.  Users frequently don't like such risk.

I defer to your wise judgement.  Given prior statements about what
goes where, you are being consistent to say this should go in 1.6.
In which case I suggest Teemu should drop that last hunk as we
should really drop that entire block of code from the script.

-- 
Shawn.
