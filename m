From: Stefan Sperling <stsp@stsp.name>
Subject: Re: [PATCH] remove noise and inaccuracies from git-svn docs
Date: Tue, 19 Apr 2011 11:31:08 +0200
Message-ID: <20110419093108.GA7440@ted.stsp.name>
References: <1303138000-27807-1-git-send-email-stsp@stsp.name>
 <vpqhb9vplu4.fsf@bauges.imag.fr>
 <7v39lfa1h5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 11:31:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QC7HI-0002Yx-3m
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 11:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172Ab1DSJbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 05:31:19 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:46609 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296Ab1DSJbR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 05:31:17 -0400
X-Envelope-From: stsp@stsp.name
Received: from ted.stsp.name (ted.stsp.name [217.197.84.34])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p3J9V9kK030404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 19 Apr 2011 11:31:09 +0200
Received: from ted.stsp.name (stsp@localhost [127.0.0.1])
	by ted.stsp.name (8.14.3/8.14.3) with ESMTP id p3J9V9Bv009326;
	Tue, 19 Apr 2011 11:31:09 +0200 (CEST)
Received: (from stsp@localhost)
	by ted.stsp.name (8.14.3/8.14.3/Submit) id p3J9V8rs006943;
	Tue, 19 Apr 2011 11:31:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v39lfa1h5.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171787>

On Mon, Apr 18, 2011 at 10:55:18AM -0700, Junio C Hamano wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
> > Stefan Sperling <stsp@stsp.name> writes:
> >
> >> -DESIGN PHILOSOPHY
> >> ------------------
> >> -Merge tracking in Subversion is lacking and doing branched development
> >> -with Subversion can be cumbersome as a result.  While 'git svn' can
> >> track
> >
> > Agreed (this and the rest of the patch). Users reading git-svn's doc
> > don't want a dissertation about how bad SVN is, and if they do, they can
> > read whygitisbetterthanx ;-)

Exactly :)

And they might rather want to learn more about how Subversion has improved
since version 1.4. It seems that these parts of the text were written
before Subversion's 1.5 release. SVN is a lot more capable now than the
git-svn docs suggest and I'm surprised that git-svn's development seems
to have gotten stuck at the 1.4 level of functionality. Not even CentOS
ships with 1.4 anymore these days.

E.g. git-svn could be taught to generate svn mergeinfo compatible with other
Subversion clients. It's not easy to come up with a generic mapping between
the two systems but for some use cases it should be reasonably straightforward.
This would be a nice improvement towards making git-svn a proper drop-in
replacement for the standard svn client. Currently, git-svn cannot be
used without disturbing other users doing merges with Subversion itself
which is a pity.

I don't have time to work on this myself but I would be more than happy
to assist with design and review.

> I agree the change in the patch is good.  It needs to be signed-off,
> though.

I've sent a signed-off version with git send-email. Thanks!
