From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Fix git-svn for SVN 1.7
Date: Thu, 2 Aug 2012 15:10:35 -0700
Message-ID: <20120802221035.GA9651@dcvr.yhbt.net>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
 <20120802103122.GA24385@dcvr.yhbt.net>
 <20120802160753.GA17158@copier>
 <7vy5lxce9r.fsf@alter.siamese.dyndns.org>
 <robbat2-20120802T194817-892501136Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	bwalton@artsci.utoronto.ca,
	" Michael G. Schwern" <schwern@pobox.com>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Fri Aug 03 00:10:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sx3bM-0006cP-EA
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 00:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589Ab2HBWKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 18:10:38 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33623 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751895Ab2HBWKg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 18:10:36 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 392711F42D;
	Thu,  2 Aug 2012 22:10:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <robbat2-20120802T194817-892501136Z@orbis-terrarum.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202803>

"Robin H. Johnson" <robbat2@gentoo.org> wrote:
> On Thu, Aug 02, 2012 at 11:58:08AM -0700,  Junio C Hamano wrote:
> > > Thanks from me as well.  I'm still worried about whether the increased
> > > use of canonicalize_url will introduce regressions for the existing
> > > SVN 1.6 support, and I should have time to look it over this weekend.
> > 
> > Likewise.  I'd prefer to see it cook during the feature freeze and
> > not merge to 'master' until post 1.7.12 cycle opens.
> 
> I'm going to spin it and include in Gentoo's 1.7.12 packages, as we're
> in need of this explicitly, and this is why we funded Michael to do the
> work.

Thanks.  Btw, have you gotten the chance to report the new SVN 1.7 test
failures Michael mentioned to the SVN folks?
