From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Moving "git remote add --mirror blah" functionality to
 "git clone --bare --origin=blah"
Date: Wed, 23 Apr 2008 23:42:01 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804232340310.26553@eeepc-johanness>
References: <480EF334.1090907@gnu.org> <7vhcdstv0f.fsf@gitster.siamese.dyndns.org> <480F96A8.6020304@gnu.org> <7vtzhsqlfi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paolo Bonzini <bonzini@gnu.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 00:43:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JongI-0001vS-Sh
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 00:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbYDWWm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 18:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbYDWWm2
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 18:42:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:52001 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751257AbYDWWm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 18:42:27 -0400
Received: (qmail invoked by alias); 23 Apr 2008 22:42:25 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp022) with SMTP; 24 Apr 2008 00:42:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19AArE2JBRAHvSU1yWh5yTaNpKhhDbN9XhssNdzlb
	3liJQV7Zzpp8Gy
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vtzhsqlfi.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80269>

Hi,

On Wed, 23 Apr 2008, Junio C Hamano wrote:

> Paolo Bonzini <bonzini@gnu.org> writes:
> 
> > It seems useless to have an option in "git remote add" just because it 
> > might be necessary in a future refactoring of "git clone", but without 
> > a good use case beside that one.
> 
> Ooo.  But I think that's the other way around.

I think it is very much the other way round.  "git remote add" is meant 
for adding _additional_ remotes.  "git clone" just _happens_ to install an 
"origin" remote.

I even have a case where I used "--mirror" _twice_ in the same, _non_-bare 
repository.  It has merit, you know?

Ciao,
Dscho
