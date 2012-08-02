From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Fix git-svn for SVN 1.7
Date: Thu, 2 Aug 2012 19:50:18 +0000
Message-ID: <robbat2-20120802T194817-892501136Z@orbis-terrarum.net>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
 <20120802103122.GA24385@dcvr.yhbt.net>
 <20120802160753.GA17158@copier>
 <7vy5lxce9r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Eric Wong <normalperson@yhbt.net>, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca,
	" Michael G. Schwern" <schwern@pobox.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 02 21:50:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sx1Pe-0007Bw-W8
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 21:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302Ab2HBTuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 15:50:20 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:44810 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753173Ab2HBTuT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 15:50:19 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 17FFA1B402A
	for <git@vger.kernel.org>; Thu,  2 Aug 2012 19:50:19 +0000 (UTC)
Received: (qmail 31262 invoked by uid 10000); 2 Aug 2012 19:50:18 -0000
Content-Disposition: inline
In-Reply-To: <7vy5lxce9r.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202787>

On Thu, Aug 02, 2012 at 11:58:08AM -0700,  Junio C Hamano wrote:
> > Thanks from me as well.  I'm still worried about whether the increased
> > use of canonicalize_url will introduce regressions for the existing
> > SVN 1.6 support, and I should have time to look it over this weekend.
> 
> Likewise.  I'd prefer to see it cook during the feature freeze and
> not merge to 'master' until post 1.7.12 cycle opens.
I'm going to spin it and include in Gentoo's 1.7.12 packages, as we're
in need of this explicitly, and this is why we funded Michael to do the
work.

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Trustee & Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
