From: Jeff King <peff@peff.net>
Subject: Re: RFH: spawning pager takes long time when when unconnected from
	network
Date: Tue, 10 Feb 2009 06:07:29 -0500
Message-ID: <20090210110729.GC12089@coredump.intra.peff.net>
References: <loom.20090210T015515-886@post.gmane.org> <4991337B.2010102@viscovery.net> <loom.20090210T085859-630@post.gmane.org> <alpine.DEB.1.00.0902101124160.10279@pacific.mpi-cbg.de> <279b37b20902100253v3cfd8e45kefa6da7de2ea4a4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Raible <raible+git@gmail.com>, git@vger.kernel.org
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 12:09:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWqU7-0001DG-5m
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 12:08:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750AbZBJLHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 06:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752625AbZBJLHc
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 06:07:32 -0500
Received: from peff.net ([208.65.91.99]:58574 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750904AbZBJLHc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 06:07:32 -0500
Received: (qmail 12266 invoked by uid 107); 10 Feb 2009 11:07:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 10 Feb 2009 06:07:48 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Feb 2009 06:07:29 -0500
Content-Disposition: inline
In-Reply-To: <279b37b20902100253v3cfd8e45kefa6da7de2ea4a4b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109205>

On Tue, Feb 10, 2009 at 02:53:31AM -0800, Eric Raible wrote:

> The first thing I tried was to set GIT_TRACE=1, and it doesn't give much:
> trace: built-in: git 'diff' 'ss' '--name-only'
> trace: run_command: 'sh' '-c' 'less'
> 
> The long pause in question begins after the above output is produced
> but before the list of files is shown.  The output is identical when setting
> GIT_TRACE to a file.

Does your shell run a .profile or similar, and if so, is there anything
in it that might touch the network?

-Peff
