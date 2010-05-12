From: Jeff King <peff@peff.net>
Subject: Re: fatal: Unable to find remote helper for 'http'
Date: Wed, 12 May 2010 12:47:55 -0400
Message-ID: <20100512164755.GB14710@coredump.intra.peff.net>
References: <811C439C44639E429301EB1083399FA302F1853F@CINMLVEM12.e2k.ad.ge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Laflen, Brandon (GE, Research)" <laflenb@ge.com>
X-From: git-owner@vger.kernel.org Wed May 12 18:48:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCF6H-00005K-TT
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 18:48:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756630Ab0ELQr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 12:47:56 -0400
Received: from peff.net ([208.65.91.99]:44149 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756497Ab0ELQr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 12:47:56 -0400
Received: (qmail 6945 invoked by uid 107); 12 May 2010 16:47:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 12 May 2010 12:47:55 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 May 2010 12:47:55 -0400
Content-Disposition: inline
In-Reply-To: <811C439C44639E429301EB1083399FA302F1853F@CINMLVEM12.e2k.ad.ge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146956>

On Wed, May 12, 2010 at 11:08:27AM -0400, Laflen, Brandon (GE, Research) wrote:

> I recently compiled git on a red-hat linux system.  There were not compile
> errors.  But, when I try to use git to clone a repository, I receive the
> following error:
> 
> 	fatal: Unable to find remote helper for 'http'

Did you build git with http support? You need to have curl installed for
it. If you built with the straight Makefile, you would have had to
specify NO_CURL manually. If you used the "configure" script, though, it
probably would have noticed that you didn't have curl installed and
switched it off.

-Peff
