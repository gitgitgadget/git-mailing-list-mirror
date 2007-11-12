From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH,RFC 1/2] Make the list of common commands more exclusive
Date: Mon, 12 Nov 2007 11:24:12 +0100
Organization: glandium.org
Message-ID: <20071112102412.GA24803@glandium.org>
References: <20071111235819.GB7392@thunk.org> <1194829077-14320-1-git-send-email-tytso@mit.edu> <7vzlxk8apz.fsf@gitster.siamese.dyndns.org> <20071112062222.GA17462@thunk.org> <7vhcjr53hp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 11:26:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrWUQ-000300-OW
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 11:25:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756903AbXKLKZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 05:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756777AbXKLKZn
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 05:25:43 -0500
Received: from vawad.err.no ([85.19.200.177]:52705 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756377AbXKLKZn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 05:25:43 -0500
Received: from aputeaux-153-1-92-161.w86-217.abo.wanadoo.fr ([86.217.54.161] helo=vaio.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IrWTm-0000oW-MH; Mon, 12 Nov 2007 11:25:21 +0100
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1IrWSi-0006W2-5Q; Mon, 12 Nov 2007 11:24:12 +0100
Content-Disposition: inline
In-Reply-To: <7vhcjr53hp.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64594>

On Sun, Nov 11, 2007 at 11:26:10PM -0800, Junio C Hamano <gitster@pobox.com> wrote:
> > My mental model for git newbies is that they would probably be pulling
> > from upstream repositories (so I was tempted to remove git-init from
> > the common commands list), but they would rarely be cherry-picking or
> > reverting other people's changes.
> 
> I'd agree with that, but reverting and cherry-picking would also
> be done on the commits the user builds on top of other people's
> changes.

On the other hand, cherry-picking and reverting are just the same thing,
except one applies a reversed patch. Wouldn't it make sense to merge these
two in one command ?

Mike
