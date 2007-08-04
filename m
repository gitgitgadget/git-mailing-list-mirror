From: Jeff King <peff@peff.net>
Subject: Re: git-gui console app ?
Date: Sat, 4 Aug 2007 08:03:42 -0400
Message-ID: <20070804120342.GC9716@coredump.intra.peff.net>
References: <20070804101058.GA520@Mac2.local> <Pine.LNX.4.64.0708041225520.14781@racer.site> <20070804115331.GA2962@Mac2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 04 14:03:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHIMF-0000Fo-4R
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 14:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755876AbXHDMDo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 08:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755940AbXHDMDo
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 08:03:44 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2066 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755757AbXHDMDo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 08:03:44 -0400
Received: (qmail 29480 invoked from network); 4 Aug 2007 12:03:47 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 4 Aug 2007 12:03:47 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Aug 2007 08:03:42 -0400
Content-Disposition: inline
In-Reply-To: <20070804115331.GA2962@Mac2.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54832>

On Sat, Aug 04, 2007 at 01:53:31PM +0200, Erik Colson wrote:

> Thanks for the very fast answer. I'm currently trying it out. However
> I can't figure out how to view the 'changed but not updated' in diff
> format...

git-diff ?

By default, it will show the changes between your working tree and the
index (i.e., changed but not updated). You can show the diff of "updated
but not commited" with "git-diff --cached".

-Peff
