From: Jeff King <peff@peff.net>
Subject: Re: bug in checkout/status ?
Date: Thu, 5 Mar 2009 15:51:26 -0500
Message-ID: <20090305205126.GA19800@coredump.intra.peff.net>
References: <20090305204801.GA16213@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 05 21:53:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfKYv-0000KE-Ka
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 21:53:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754959AbZCEUve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 15:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754220AbZCEUvd
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 15:51:33 -0500
Received: from peff.net ([208.65.91.99]:56487 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754081AbZCEUvc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 15:51:32 -0500
Received: (qmail 3047 invoked by uid 107); 5 Mar 2009 20:51:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 05 Mar 2009 15:51:33 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Mar 2009 15:51:26 -0500
Content-Disposition: inline
In-Reply-To: <20090305204801.GA16213@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112339>

On Thu, Mar 05, 2009 at 12:48:01PM -0800, Shawn O. Pearce wrote:

> WTF.  This shows up in git 1.6.0.2 through current 'next':
> 
> $ git clone git://android.git.kernel.org/platform/external/elfutils std_git
> $ cd std_git/
> $ git status
> # On branch master
> 
> # Changes to be committed:
> #   (use "git reset HEAD <file>..." to unstage)
> #
> #       modified:   libelf-po/ChangeLog
> #       modified:   libelf-po/Makefile
> #       modified:   libelf-po/Makefile.in
> #       modified:   libelf-po/Makefile.in.in
> #       modified:   libelf-po/Makevars
> #       modified:   libelf-po/POTFILES
> #       modified:   libelf-po/POTFILES.in
> #       modified:   libelf-po/Rules-quot
> #       modified:   libelf-po/boldquot.sed
> #       modified:   libelf-po/insert-header.sin
> #       modified:   libelf-po/libelf.pot
> #       modified:   libelf-po/quot.sed
> #

Hmm. I get the same behavior here. I notice there is a "libelf" subtree
before "libelf-po"; maybe it's a sorting bug? I'll try to investigate
more.

-Peff
