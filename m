From: Jeff King <peff@peff.net>
Subject: Re: Contents of file for a commit
Date: Sat, 26 Jan 2008 23:28:54 -0500
Message-ID: <20080127042854.GA25133@coredump.intra.peff.net>
References: <18332.1826.220373.129812@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 05:29:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIz97-0006gE-EA
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 05:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287AbYA0E27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 23:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753338AbYA0E26
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 23:28:58 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1809 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753058AbYA0E26 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 23:28:58 -0500
Received: (qmail 15382 invoked by uid 111); 27 Jan 2008 04:28:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 26 Jan 2008 23:28:55 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Jan 2008 23:28:54 -0500
Content-Disposition: inline
In-Reply-To: <18332.1826.220373.129812@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71802>

On Sat, Jan 26, 2008 at 10:22:58PM -0600, Bill Lear wrote:

> How can I do the equivalent of 'cvs co -r <commit> -p <file>' in git?
> I want to see the entire contents of a file as it existed after a
> particular commit was introduced.

Try 'git show <commit>:<file>'.

-Peff
