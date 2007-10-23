From: Theodore Tso <tytso@mit.edu>
Subject: Re: What's cooking in git/spearce.git (topics)
Date: Mon, 22 Oct 2007 22:00:44 -0400
Message-ID: <20071023020044.GA27132@thunk.org>
References: <20071016060456.GC13801@spearce.org> <Pine.LNX.4.64.0710161209480.25221@racer.site> <20071016195744.GB32132@closure.lan> <7v3aw2aaxu.fsf@gitster.siamese.dyndns.org> <20071023012140.GC22997@thunk.org> <7vtzoi8voo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 23 05:56:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkAsl-000203-9N
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 05:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbXJWD4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 23:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752052AbXJWD4c
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 23:56:32 -0400
Received: from thunk.org ([69.25.196.29]:52532 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751916AbXJWD4c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 23:56:32 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IkB2R-00012B-Vn; Tue, 23 Oct 2007 00:06:44 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@thunk.org>)
	id 1Ik94W-000758-7s; Mon, 22 Oct 2007 22:00:44 -0400
Content-Disposition: inline
In-Reply-To: <7vtzoi8voo.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62076>

On Mon, Oct 22, 2007 at 06:29:59PM -0700, Junio C Hamano wrote:
> Well, the policy is never to commit directly on top of next
> (iow, only merge other topics and nothing else).  Otherwise it
> becomes hard to allow individual topics graduate to 'master'
> independently.

I see.  So if it's non-trivial enough that you want it to "cook" in
next for a cycle, you'll create a topic branch for it (based off of
'master'), and then force a merge into 'next'?

					- Ted
