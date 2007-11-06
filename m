From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-revert is one of the most misunderstood command in
 git, help users out.
Date: Tue, 6 Nov 2007 03:18:34 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711060317220.4362@racer.site>
References: <1194289301-7800-1-git-send-email-madcoder@debian.org>
 <CD2E6759-9E7E-41E6-8B58-AB6CA9604111@midwinter.com>
 <7vlk9cmiyq.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711052325090.4362@racer.site>
 <7vsl3kjdct.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Grimm <koreth@midwinter.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 04:19:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpEyb-0006HG-Rt
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 04:19:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755093AbXKFDT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 22:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755115AbXKFDT2
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 22:19:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:38508 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753648AbXKFDT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 22:19:27 -0500
Received: (qmail invoked by alias); 06 Nov 2007 03:19:25 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp055) with SMTP; 06 Nov 2007 04:19:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18duXBvAGAdqWgahjTSzAEjudfaMFE6ijYIbDOkpj
	yYEo1mmSuwHUNX
X-X-Sender: gene099@racer.site
In-Reply-To: <7vsl3kjdct.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63617>

Hi,

On Mon, 5 Nov 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > In the same way, I would expect "git revert <commit> -- file" to undo 
> > the changes in that commit to _that_ file (something like "git 
> > merge-file file <commit>:file <commit>^:file"), but this time commit 
> > it, since it was committed at one stage.
> 
> Allowing people to revert or cherry pick partially by using paths 
> limiter is a very good idea; the whole "it comes from a commit so we 
> also commit" feels an utter nonsense, though.

No.

When "git revert <commit>" commits the result, "git revert <commit> -- 
<file>" should, too.

You can always add the "-n" option.

Ciao,
Dscho
