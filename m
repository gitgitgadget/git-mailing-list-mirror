From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/3] Add support for external programs for handling
	native fetches
Date: Sat, 25 Jul 2009 11:45:26 -0700
Message-ID: <20090725184526.GB11191@spearce.org>
References: <alpine.LNX.2.00.0907251330240.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Jul 25 20:45:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUmFS-0007mg-Id
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 20:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbZGYSp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 14:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbZGYSp0
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 14:45:26 -0400
Received: from george.spearce.org ([209.20.77.23]:45880 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbZGYSp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 14:45:26 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A1003381FD; Sat, 25 Jul 2009 18:45:26 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0907251330240.2147@iabervon.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124034>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> +Commands are given by the caller on the helper's standard input, one per line.
> +
> +'list'::
> +	Outputs the names of refs followed by the hex of their values
> +	or "@<name>" for symrefs, one per line. After the complete
> +	list, outputs a blank line.

I hate to be a nit, but why this format and not the one that is
produced by `git ls-remote` and the native protocol?  I know its
pretty arbitrary either way, but since we already have a history
of using "SHA1 ref\n" why not continue that tradition here?

-- 
Shawn.
