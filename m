From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash completion: Fix the . -> .. revision range
	completion
Date: Mon, 14 Jul 2008 00:00:21 +0000
Message-ID: <20080714000021.GB13066@spearce.org>
References: <20080713111847.29801.8969.stgit@localhost> <7vskudpiqq.fsf@gitster.siamese.dyndns.org> <20080713230724.GJ10151@machine.or.cz> <7vhcatnz80.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0807131649380.3305@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 14 02:01:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIBVL-0003Dc-5z
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 02:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843AbYGNAAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 20:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754730AbYGNAAW
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 20:00:22 -0400
Received: from george.spearce.org ([209.20.77.23]:36926 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754778AbYGNAAV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 20:00:21 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1421E3836B; Mon, 14 Jul 2008 00:00:21 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0807131649380.3305@woody.linux-foundation.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88361>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Sun, 13 Jul 2008, Junio C Hamano wrote:
> > 
> > I think that is what Shawn sent a few minutes ago, so you two are in
> > agreement, and I will be happy with it, too.
> 
> Does it fix this one too:
> 
> 	git show origin/pu:Makef<tab>
> 
> which totally screws up and becomes
> 
> 	git show Makefile
> 
> dropping the version specifier?

Its unrelated to the issue you described above.  But I just tested
your Makefile completion case and it worked as expected, though
I just found out it doesn't add a trailing space once there is a
unique completion made.  I'll look at another patch to fix that.
 
-- 
Shawn.
