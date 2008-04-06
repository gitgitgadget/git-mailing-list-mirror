From: Gerrit Pape <pape@smarden.org>
Subject: Re: [PATCH (BUGFIX)] gitweb: Fix "Use of uninitialized value"
	error in 'history' view
Date: Sun, 6 Apr 2008 10:22:59 +0000
Message-ID: <20080406102300.1915.qmail@0406979e53f500.315fe32.mid.smarden.org>
References: <200804041623.44595.jnareb@gmail.com> <20080405164303.30566.qmail@47fa24fd520dbf.315fe32.mid.smarden.org> <200804051916.14568.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 06 12:23:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiS21-0002h7-Cv
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 12:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515AbYDFKWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 06:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752330AbYDFKWk
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 06:22:40 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:54384 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751775AbYDFKWj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 06:22:39 -0400
Received: (qmail 1923 invoked by uid 1000); 6 Apr 2008 10:23:00 -0000
Content-Disposition: inline
In-Reply-To: <200804051916.14568.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78888>

On Sat, Apr 05, 2008 at 06:16:11PM +0100, Jakub Narebski wrote:
> This code does not, and cannot, fill 'status_str' ('status' is faked).
> I'd send in a bit patch fixing this bug (making is_deleted() more
> robust).
> 
> Footnotes:
> ==========
> [1] Note that example URL in http://bugs.debian.org/469083 does not
>     have 'hpb' ($hash_parent_base) parameter set... and that is what
>     causes this bug.

Thanks a lot.

> P.S. Gerrit, are you maintainer of git-core debian package?

Yes, I take responsibility for the git Debian packages.

Regards, Gerrit.
