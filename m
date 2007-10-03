From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Don't checkout the full tree if avoidable
Date: Wed, 3 Oct 2007 16:26:11 -0700
Message-ID: <20071003232611.GB14972@hand.yhbt.net>
References: <1191000259190-git-send-email-stevenrwalter@gmail.com> <7vejgftgef.fsf@gitster.siamese.dyndns.org> <20071001110855.GB10079@muzzle> <20071001131227.GA24494@dervierte>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 01:26:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdDbh-0005VO-MO
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 01:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbXJCX0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 19:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751968AbXJCX0N
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 19:26:13 -0400
Received: from hand.yhbt.net ([66.150.188.102]:36332 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751922AbXJCX0N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 19:26:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 5F9F37DC093;
	Wed,  3 Oct 2007 16:26:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20071001131227.GA24494@dervierte>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59909>

Steven Walter <stevenrwalter@gmail.com> wrote:
> On Mon, Oct 01, 2007 at 04:08:55AM -0700, Eric Wong wrote:
> > Steven Walter wrote:
> > > One criticism of the patch: the trees_match function probably needs to
> > > be re-written.  My SVN::Perl-foo is weak.
> > 
> > Yep :)
> > 
> > Steven:
> > 
> > How does the following work for you?  Which version of SVN do you have,
> > by the way?  I just found a bug with the way SVN::Client::diff() is
> > exported for SVN 1.1.4, hence the SVN::Pool->new_default_sub usage.
> 
> swalter@sentra:~% svn --version
> svn, version 1.3.2 (r19776)
> 
> This version works great; seems to have exactly the same behavior as my
> patch.  Verified that it still falls back to the do_update code when
> trees_match fails.

Thanks Steven.

Junio: can you please apply my version of Steven's patch?  Thanks.

-- 
Eric Wong
