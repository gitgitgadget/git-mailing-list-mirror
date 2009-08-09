From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 3/3] tests: allow user to specify trash directory location
Date: Sun, 9 Aug 2009 15:33:40 +0200
Message-ID: <200908091533.40227.j6t@kdbg.org>
References: <20090809083518.GA8147@coredump.intra.peff.net> <20090809083945.GC8250@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 09 15:33:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ma8X2-0004xV-9k
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 15:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473AbZHINdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 09:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752054AbZHINdn
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 09:33:43 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:63337 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751794AbZHINdm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 09:33:42 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id DF5EDCDF8A;
	Sun,  9 Aug 2009 15:33:40 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 569725BAEB;
	Sun,  9 Aug 2009 15:33:40 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20090809083945.GC8250@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125343>

On Sonntag, 9. August 2009, Jeff King wrote:
> There is a test below for absolute versus relative path in the root
> provided.  Do we need some extra magic to make it work on non-Unix
> platforms?

Not for Windows. Those devolpers who want to use an absolute path can use the 
POSIX path notation:

   GIT_TEST_OPTS=--root=/c/temp/gittests

This works in t4014.

-- Hannes
