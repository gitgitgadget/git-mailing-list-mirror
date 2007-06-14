From: Josef Sipek <jsipek@cs.sunysb.edu>
Subject: Re: [PATCH guilt] make guilt use standard POSIX shell
Date: Thu, 14 Jun 2007 11:27:02 -0400
Message-ID: <20070614152702.GC934@filer.fsl.cs.sunysb.edu>
References: <11818254621527-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jun 14 17:27:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyrE9-0000lT-8d
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 17:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbXFNP1I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 11:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752136AbXFNP1H
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 11:27:07 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:37303 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbXFNP1G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 11:27:06 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l5EFR24Y004135;
	Thu, 14 Jun 2007 11:27:02 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l5EFR2jf004133;
	Thu, 14 Jun 2007 11:27:02 -0400
Content-Disposition: inline
In-Reply-To: <11818254621527-git-send-email-madcoder@debian.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50207>

On Thu, Jun 14, 2007 at 02:50:55PM +0200, Pierre Habouzit wrote:
> This patch series makes guilt be able to work with a standard posix shell.
> 
> This has been tested with bash, zsh, dash and posh acting as /bin/sh.
> 
> This uses awk and sed a bit more than before, but POSIX awk and sed should be
> enough. Though GNU find and GNU /bin/echo from the coreutils needs to be
> there.
> 
> Here is the shortlog:
> 
> 	Pierre Habouzit (7):
> 		  Regression test suite needs bash, that's OK.
> 		  guilt(1): Obvious bashisms fixed.
> 		  guilt(1): simplifications...
> 		  guilt(1): reimplement push_patch, using a subshell to avoid locals.
> 		  Easy commands, without bashisms.
> 		  guilt-status(1): Remove bashisms.
> 		  Remove last bashisms from remaining commands.
 
I went though the patches, and it's mostly good (see individual patch
replies for details). I noticed an indentation issue or two, but I can fix
that up easily, I can take care of the quoting of `basename $0`.

The regression suite is little lacking, so I am going to put your updated
patches onto a special branch, and test it for a while - fixing up any
potential bugs. (I don't want to be even remotely responsible for people's
patches turning into empty files :) )

Thanks a lot!

Josef "Jeff" Sipek.

-- 
A CRAY is the only computer that runs an endless loop in just 4 hours...
