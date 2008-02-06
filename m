From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH (repost)] Improve bash prompt to detect merge / rebase
	in progress
Date: Thu, 7 Feb 2008 00:44:48 +0100
Organization: glandium.org
Message-ID: <20080206234448.GA18269@glandium.org>
References: <9b3e2dc20802061152q63bc61acuaecf3f33d4df8b19@mail.gmail.com> <7vodatvmtl.fsf@gitster.siamese.dyndns.org> <200802062314.39440.robin.rosenberg.lists@dewire.com> <m3myqd4qo2.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stephen Sinclair <radarsat1@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 00:45:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMtxP-00009G-0p
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 00:45:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759236AbYBFXpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 18:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759018AbYBFXpB
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 18:45:01 -0500
Received: from vuizook.err.no ([85.19.215.103]:58728 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757383AbYBFXpA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 18:45:00 -0500
Received: from aputeaux-153-1-42-109.w82-124.abo.wanadoo.fr ([82.124.6.109] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JMtxY-0005XX-Ca; Thu, 07 Feb 2008 00:45:50 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JMtwe-0004ob-Qs; Thu, 07 Feb 2008 00:44:48 +0100
Content-Disposition: inline
In-Reply-To: <m3myqd4qo2.fsf@localhost.localdomain>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72875>

On Wed, Feb 06, 2008 at 03:21:40PM -0800, Jakub Narebski wrote:
> Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:
> 
> > This patch makes the git prompt (when enabled) show if a merge or a
> > rebase is unfinished. It also detects if a bisect is being done as
> > well as detached checkouts.
> [...]
> > +		if [ -d "$g/../.dotest" ]
> [...]
> > +		elif [ -f "$g/.dotest-merge/interactive" ]
> [...]
> > +		elif [ -d "$g/.dotest-merge" ]
> 
> Hmmm... is it time to ressurect "git explain" / "git info" / "git state"
> command idea, as to not need to harcode info about state in scripts,
> putting it in only one place?

Maybe git status could deal with that job.

Mike
