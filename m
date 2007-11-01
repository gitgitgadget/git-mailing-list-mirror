From: Mike Hommey <mh@glandium.org>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 1 Nov 2007 21:47:55 +0100
Organization: glandium.org
Message-ID: <20071101204755.GA15842@glandium.org>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org> <7vmytycykt.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.999.0711011129460.3342@woody.linux-foundation.org> <916BE4AD-5BD9-48E6-8026-B1AC7387E28D@adacore.com> <7v4pg5btis.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geert Bosch <bosch@adacore.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 21:50:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ingzj-0006Ej-H9
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 21:50:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753106AbXKAUuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 16:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751674AbXKAUuN
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 16:50:13 -0400
Received: from vawad.err.no ([85.19.200.177]:49036 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752930AbXKAUuL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 16:50:11 -0400
Received: from aputeaux-153-1-66-112.w81-249.abo.wanadoo.fr ([81.249.52.112] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1Ingyg-0008Ue-2G; Thu, 01 Nov 2007 21:49:24 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IngxH-0004Ws-2w; Thu, 01 Nov 2007 21:47:55 +0100
Content-Disposition: inline
In-Reply-To: <7v4pg5btis.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62995>

On Thu, Nov 01, 2007 at 01:27:55PM -0700, Junio C Hamano wrote:
> Geert Bosch <bosch@adacore.com> writes:
> 
> > I often type "make clean" as well many "git xyz" commands
> > during development, and so it happens that at times, I type
> > "git clean" by accident.
> 
> Happened to me once.  I hate that command.

Speaking of hateful commands, git stash clear is one of them.
I tend to type git stash clean, which creates a "clean" stash...
 
> > So, I propose *not* converting git clean to a C builtin,
> > but instead adding --untracked and --ignored options to
> > git-rm.
> 
> I think what you are trying to do is to deprecate or remove "git
> clean".
> 
> I do not know where "git clean" came from.  I am suspecting that
> it was to give counterparts to some other SCMs, but do not know
> which ones.  Some people wanted to have it --- so you need to
> convince them that it is a bad idea first.  Adding an equivalent
> options to "git rm" alone does not solve that issue.

Well, they could add an alias, then ;)

Mike
