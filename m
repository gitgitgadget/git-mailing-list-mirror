From: Martin Nordholts <enselic@gmail.com>
Subject: Re: [PATCH] Clarify the git-branch documentation of default
 start-point
Date: Thu, 18 Jun 2009 08:04:21 +0200
Message-ID: <1245305061.24201.12.camel@localhost.localdomain>
References: <1245303673.24201.3.camel@localhost.localdomain>
	 <7vprd2148u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 08:02:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHAhi-0003eq-4H
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 08:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757764AbZFRGCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 02:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756160AbZFRGCQ
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 02:02:16 -0400
Received: from iph2.telenor.se ([195.54.127.133]:21287 "EHLO iph2.telenor.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756061AbZFRGCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 02:02:16 -0400
X-SMTPAUTH: 
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArMCAPt0OUrDNmV4mWdsb2JhbACYYAEBAQEBCAsKBxOmPJImhAgF
X-IronPort-AV: E=Sophos;i="4.42,242,1243807200"; 
   d="scan'208";a="21749022"
Received: from ironport.bredband.com ([195.54.101.120])
  by iph2.telenor.se with ESMTP; 18 Jun 2009 08:02:16 +0200
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AlleAHx1OUrVcX8QPGdsb2JhbAAIiVSOegEBAQE3pkmSJYQIBQ
X-IronPort-AV: E=Sophos;i="4.42,242,1243807200"; 
   d="scan'208";a="538403509"
Received: from c-107f71d5.017-113-6c756e10.cust.bredbandsbolaget.se (HELO [192.168.1.2]) ([213.113.127.16])
  by ironport1.bredband.com with ESMTP; 18 Jun 2009 08:02:16 +0200
In-Reply-To: <7vprd2148u.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.24.5 (2.24.5-1.fc10) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121796>

On Wed, 2009-06-17 at 22:48 -0700, Junio C Hamano wrote:
> Martin Nordholts <enselic@gmail.com> writes:
> 
> > -	is omitted, the current branch is assumed.
> > +	is omitted, the current branch is assumed.  Note that checking
> > +	out a remote branch does not make it the current branch.  If a
> > +	remote branch is desired as start-point it must be an explicity
> > +	specified.
> 
> [...] "it" in the second new sentence is unclear.
> 
> You probably wanted to answer "If I wanted to have _my own 'next' branch_
> that tracks 'next' from the remote, what should I do?"

What I am trying to clarify is that a remote branch will never be the
default for the start-point argument to git-branch, so if someone wants
a remote branch as start-point, then the branch must be explicitly
specified.

For this, the first sentence might actually be enough. If a remote
branch never is the current branch, and if start-point defaults to the
current branch, then the start-point can never default to a remote
branch.

Should we just stick to the first sentence then perhaps?

 / Martin
