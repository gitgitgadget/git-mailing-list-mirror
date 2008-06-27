From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: 'next' will be rewound shortly
Date: Fri, 27 Jun 2008 18:12:20 +0200
Message-ID: <20080627161220.GB6201@leksak.fem-net>
References: <7vmylixr6h.fsf@gitster.siamese.dyndns.org> <7vbq1xx4y8.fsf@gitster.siamese.dyndns.org> <7vzlphvl69.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 18:13:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCGZd-0008TR-Qt
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 18:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755310AbYF0QMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 12:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753121AbYF0QMZ
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 12:12:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:33384 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753092AbYF0QMX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 12:12:23 -0400
Received: (qmail invoked by alias); 27 Jun 2008 16:12:22 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp037) with SMTP; 27 Jun 2008 18:12:22 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18OTpET/VwOjuWTbdUGZHvCUlUqFrUSanC3L51uGc
	lZPBpGUB+6DcPr
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KCGYe-0006oh-8B; Fri, 27 Jun 2008 18:12:20 +0200
Content-Disposition: inline
In-Reply-To: <7vzlphvl69.fsf_-_@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86578>

Hi Junio,

> Following the new tradition we began a few releases ago, I'll rewind the
> tip of 'next' shortly.  Two topics will be kicked back to 'pu' while we
> are at it (jc/send-pack-tell-me-more and js/rebase-i-sequencer).

I wonder why the bugfix commit

	aec7e9cd	Don't append default merge message to -m message

has disappeared or why/if this belongs to js/rebase-i-sequencer.

I noticed this because a test case of sequencer failed during rebasing
to pure "master"/"next" without js/rebase-i-sequencer.


I also have a question:
my development branch for the sequencer prototype is based on next,
then:
	* Merge js/rebase-i-sequencer
	* ... development ...

The only reason that makes js/rebase-i-sequencer important (besides
aec7e9cd which is mentioned above), is for the last patch
("Migrate rebase-i to use sequencer") in the patchset that I want to
send to the list.  (Otherwise a lot of work of Joerg Sommer would be
annotated to me.)
So I wanted to
 1. send a patchset based on "master"/"next" without the rebase-i
    feature extentions of Joerg Sommer, and
 2. resend the last patch (the one about rebase-i) based on "pu",
    where js/rebase-i-sequencer is still merged into.
Is this sane?

(The other variant could be that I send the "Merge js/rebase-i-sequencer"
 commit as a patch to the list, but this sounds insane to me.)

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
