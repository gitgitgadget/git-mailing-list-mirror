From: Adam Spiers <git@adamspiers.org>
Subject: Re: questions / suggestions about history simplification
Date: Thu, 19 Dec 2013 20:36:35 +0000
Message-ID: <20131219203635.GG23496@pacific.linksys.moosehall>
References: <20131219183645.GD23496@pacific.linksys.moosehall>
 <20131219190333.GE23496@pacific.linksys.moosehall>
 <xmqq38lofv8b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 19 21:36:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtkKw-0000Cw-IN
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 21:36:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756441Ab3LSUgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 15:36:39 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:45951 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756433Ab3LSUgh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 15:36:37 -0500
Received: from localhost (243.103.2.81.in-addr.arpa [81.2.103.243])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 08BC52E30D
	for <git@vger.kernel.org>; Thu, 19 Dec 2013 20:36:36 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <xmqq38lofv8b.fsf@gitster.dls.corp.google.com>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239540>

On Thu, Dec 19, 2013 at 12:20:52PM -0800, Junio C Hamano wrote:
> Adam Spiers <git@adamspiers.org> writes:
> 
> > 2. What difference does --dense ever make?
> 
> It is set by default, and --sparse is its opposite option, i.e. it
> turns revs->dense off.

Ah.  It appears to be missing from the man page that it's the default.

> When revs->dense is turned off, the usual treesame logic does not
> kick in to rewrite parents in a single strand of pearls (i.e. a
> stretch of history that solely consists of non-merge commits).

I see.

> > 3. Why is --sparse so called, given that it increases rather than
> >    decreases the number of commits shown?
> 
> The number of commits in the output will increase by including
> commits that are irrelevant to explain the history of paths
> specified by pathspec in revs->prune.  The information density
> decreases as the result, and that is what "sparse" signifies.

Ah OK, that makes sense now, but not the most intuitive choice of name
IMHO.  I would have gone for something like --all-commits, but I guess
it's way too late to change now.
