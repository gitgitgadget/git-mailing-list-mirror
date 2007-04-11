From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] Add sendmail -f support to git-send-email.
Date: Wed, 11 Apr 2007 02:38:18 +0200
Message-ID: <20070411003818.GI2813@planck.djpig.de>
References: <11762425341841-git-send-email-robbat2@gentoo.org> <20070410223826.GH2813@planck.djpig.de> <7v6483u95i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 11 09:47:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbQqv-00080Y-K2
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 02:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbXDKAiW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 20:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbXDKAiW
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 20:38:22 -0400
Received: from planck.djpig.de ([85.10.192.180]:2559 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932359AbXDKAiV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 20:38:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 9118F88003;
	Wed, 11 Apr 2007 02:38:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CZ5nEI75T96m; Wed, 11 Apr 2007 02:38:18 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 694B38801B; Wed, 11 Apr 2007 02:38:18 +0200 (CEST)
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v6483u95i.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44202>

On Tue, Apr 10, 2007 at 04:00:57PM -0700, Junio C Hamano wrote:
> Frank Lichtenheld <frank@lichtenheld.de> writes:
> 
> > On Tue, Apr 10, 2007 at 03:02:13PM -0700, Robin H. Johnson wrote:
> >> Some mailing lists use the envelope sender instead of the actual from address,
> >> and this can be broken in git-send-email. This patch sets the -f argument to
> >> the sendmail binary, using the address of the patch author.
> >
> > At least some MTAs (exim is the one I know for sure) can restrict -f
> > usage to some users and deny it for others. Don't know how much this
> > would really be a problem, but using -f unconditionally might be a bad
> > idea none-the-less.
> 
> I thought I saw the '-f' patch somewhere on the list in the last
> several weeks and there was a discussion on this topic that
> followed the patch.  Am I hallucinating, or was it not applied
> because there were some issues?

Can't find anything in the archives. So either I completly suck
at searching, or it is at least several months old, or you
are hallucinating :)

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
