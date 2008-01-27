From: Jeff King <peff@peff.net>
Subject: Re: Contents of file for a commit
Date: Sat, 26 Jan 2008 23:49:44 -0500
Message-ID: <20080127044944.GA25247@coredump.intra.peff.net>
References: <18332.1826.220373.129812@lisa.zopyra.com> <20080127044027.GS24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jan 27 05:50:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIzTG-0001C2-PB
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 05:50:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276AbYA0Ett (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 23:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753217AbYA0Ett
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 23:49:49 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1691 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753172AbYA0Ets (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 23:49:48 -0500
Received: (qmail 15459 invoked by uid 111); 27 Jan 2008 04:49:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 26 Jan 2008 23:49:45 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Jan 2008 23:49:44 -0500
Content-Disposition: inline
In-Reply-To: <20080127044027.GS24004@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71804>

On Sat, Jan 26, 2008 at 11:40:27PM -0500, Shawn O. Pearce wrote:

> You can also just view the file if you don't want those changes
> to be made:
> 
> `git show $commit -- $path`

That doesn't work. It says "show me $commit, but limited by $path". So
if $path was changed, you see the commit log and diff. If it wasn't, you
see nothing.

-Peff
