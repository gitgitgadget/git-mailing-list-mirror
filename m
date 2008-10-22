From: Jeff King <peff@peff.net>
Subject: Re: [irq/urgent]: created 3786fc7: "irq: make variable static"
Date: Wed, 22 Oct 2008 09:21:48 -0400
Message-ID: <20081022132148.GA17393@coredump.intra.peff.net>
References: <20081022061730.GA5749@elte.hu> <m3ljwgj3xy.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 15:23:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ksdg0-0008Rh-Gc
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 15:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbYJVNVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 09:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbYJVNVv
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 09:21:51 -0400
Received: from peff.net ([208.65.91.99]:4702 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750944AbYJVNVu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 09:21:50 -0400
Received: (qmail 901 invoked by uid 111); 22 Oct 2008 13:21:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 22 Oct 2008 09:21:49 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Oct 2008 09:21:48 -0400
Content-Disposition: inline
In-Reply-To: <m3ljwgj3xy.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98865>

On Wed, Oct 22, 2008 at 03:50:52AM -0700, Jakub Narebski wrote:

> About printing either forward (git-describe, e.g. v1.6.0.2-590-g67f6062)
> or backward (git-name-rev, e.g. tags/v1.6.0-rc2~8): you can use
> git-name-rev in filter mode (git log ... | git name-rev --stdin), or
> "git log --decorate", or '%d' in --pretty format specifier (this is very
> new thing).

The "--decorate" and "%d" code just decorates branch _tips_. My
impression is that he wanted to see the branch mentioned even if the
commit was not at the tip. It would be possible to extend this to print
name-rev output, but it would be computationally and memory-intensive, I
suspect.

-Peff
