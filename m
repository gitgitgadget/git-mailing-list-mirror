From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v2 4/5] check-ignore: allow incremental streaming of
 queries via --stdin
Date: Thu, 11 Apr 2013 23:55:34 +0100
Message-ID: <20130411225533.GA26949@pacific.linksys.moosehall>
References: <20130411110511.GB24296@pacific.linksys.moosehall>
 <1365681913-7059-1-git-send-email-git@adamspiers.org>
 <1365681913-7059-4-git-send-email-git@adamspiers.org>
 <20130411210430.GA6234@pug.qqx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 12 00:55:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQQP6-0001Im-NV
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 00:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762735Ab3DKWzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 18:55:36 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:60115 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759883Ab3DKWzg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 18:55:36 -0400
Received: from localhost (2.d.c.d.2.5.f.b.c.0.4.8.0.1.4.d.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:d410:840c:bf52:dcd2])
	by coral.adamspiers.org (Postfix) with ESMTPSA id EFC8958EB3
	for <git@vger.kernel.org>; Thu, 11 Apr 2013 23:55:34 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130411210430.GA6234@pug.qqx.org>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220939>

On Thu, Apr 11, 2013 at 05:04:30PM -0400, Aaron Schrab wrote:
> At 13:05 +0100 11 Apr 2013, Adam Spiers <git@adamspiers.org> wrote:
> >The above use case suggests that empty STDIN is actually a reasonable
> >scenario (e.g. when the caller doesn't know in advance whether any
> >queries need to be fed to the background process until after it's
> >already started), so we make the minor behavioural change that "no
> >pathspec given." is no longer emitted in when STDIN is empty.
> 
> The last "in" there looks to be misplaced.  Was that originally
> something like "in the case"?  If so the removed words should be
> restored or the lingering one removed as well.

I'll remove it; thanks.
