From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Add optional parameters to the diff option
 "--ignore-submodules"
Date: Wed, 9 Jun 2010 01:36:44 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1006090135170.1732@bonsai2>
References: <4C0E7037.8080403@web.de> <7vhbldtow3.fsf@alter.siamese.dyndns.org> <4C0EAAE8.3060300@web.de> <alpine.DEB.1.00.1006082247390.1732@bonsai2> <7vy6epqf5y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Andy Parkins <andyparkins@gmail.com>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 01:36:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM8Lk-00037p-FF
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 01:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755844Ab0FHXgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 19:36:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:44109 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754767Ab0FHXgr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 19:36:47 -0400
Received: (qmail invoked by alias); 08 Jun 2010 23:36:45 -0000
Received: from pD9EB2098.dip0.t-ipconnect.de (EHLO noname) [217.235.32.152]
  by mail.gmx.net (mp023) with SMTP; 09 Jun 2010 01:36:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+S665fEKGSW9SQ5n6Ya9ue7bxbbTeYOjOeUjnwDb
	dsKskAfIuJLQg3
X-X-Sender: gene099@bonsai2
In-Reply-To: <7vy6epqf5y.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148734>

Hi,

On Tue, 8 Jun 2010, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I agree that the basic reason for the default to check for dirty and 
> > untracked files is sound.
> >
> > It is not your (Jens') fault that this does not integrate well into the 
> > Git context, and that users of the submodule feature were punished that 
> > heavily (just to reiterate, if anybody missed that number, the time on 
> > "git status" -- or for that matter, "git diff" -- went up by >4500%. In 
> > English words, that is four-thousand five hundred percent, and that is 
> > just a lower bound).
> >
> > So I would actually argue (being a real submodule user, not just an 
> > imaginary one) that the default for dirty checking in the submodules 
> > should stay.
> 
> Let me make sure I understand.  You repeated three times that you suffered
> big time spending too many cycles due to extra checks (compared with older
> behaviour of not checking submodule working tree at all), but you would
> recommend the default to be the expensive one?

I also pointed out that the suffering came from power usage of submodules.

If you only have a handful of submodules, and if they are relatively 
small, the current default makes much more sense than 
--ignore-submodules=dirty

Hth,
Johannes
