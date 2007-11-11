From: Mike Hommey <mh@glandium.org>
Subject: Re: Deprecate git-fetch-pack?
Date: Sun, 11 Nov 2007 09:32:57 +0100
Organization: glandium.org
Message-ID: <20071111083257.GB14474@glandium.org>
References: <Pine.LNX.4.64.0711101752490.29952@iabervon.org> <7v4pftip42.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 09:34:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir8H9-0004lN-5F
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 09:34:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471AbXKKIeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 03:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752754AbXKKIeW
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 03:34:22 -0500
Received: from vawad.err.no ([85.19.200.177]:36655 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751527AbXKKIeV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 03:34:21 -0500
Received: from aputeaux-153-1-97-92.w86-217.abo.wanadoo.fr ([86.217.119.92] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1Ir8GZ-0002gQ-Rw; Sun, 11 Nov 2007 09:34:06 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1Ir8FV-0004R3-4b; Sun, 11 Nov 2007 09:32:57 +0100
Content-Disposition: inline
In-Reply-To: <7v4pftip42.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64427>

On Sat, Nov 10, 2007 at 04:48:29PM -0800, Junio C Hamano wrote:
> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > Now that git-fetch is in C, built in, and doing the fetch-pack in the same 
> > process, the normal usage patterns don't involve actually executing 
> > git-fetch-pack. Can we deprecate it at this point, or it is plausibly 
> > being used by scripts? As it is now, I'm not entirely confidant that the 
> > tests in t5500 won't be fooled by git-fetch working even with 
> > git-fetch-pack being broken in various ways, which should be fixed if we 
> > want to keep it.
> >
> > We also might as well deprecate peek-remote now that it's a synonym for 
> > ls-remote.
> 
> Especially because git-fetch is no longer as hackable as it used
> to be, and because people may still find special needs that can
> be hacked up with direct access to low level transports from the
> script more easily than going down to the C level, I'd rather
> wait and see for a cycle or two to decide.  There is no strong
> reason to drop it, is there?

Still, if the functionality is needed, i think it would be better if it
were provided by git-fetch --pack. The list of programs is already long
enough, it should be time to shrink it.

Mike
