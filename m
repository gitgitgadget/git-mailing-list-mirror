From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Git server memory requirements
Date: Fri, 21 Mar 2014 20:10:27 +0000
Message-ID: <20140321201027.GA2858@orbis-terrarum.net>
References: <CAOd_LFwDQZGHo+gUhNKzvT2B8iavN_75KjwwC6P=W3z11d9zAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 21 21:10:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR5m0-0008Rx-2X
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 21:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbaCUUKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 16:10:31 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:36605 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799AbaCUUK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 16:10:29 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 71C8E33FB12
	for <git@vger.kernel.org>; Fri, 21 Mar 2014 20:10:29 +0000 (UTC)
Received: (qmail 21971 invoked by uid 10000); 21 Mar 2014 20:10:27 -0000
Content-Disposition: inline
In-Reply-To: <CAOd_LFwDQZGHo+gUhNKzvT2B8iavN_75KjwwC6P=W3z11d9zAw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244733>

On Fri, Mar 21, 2014 at 01:38:01PM -0400,  Cliff Brake wrote:
> I'm trying to get an idea how much memory is required for a git server
> that is hosting linux kernel repos.
Speaking for Gentoo here, as we're working on our large repo migration,
and this was a concern originally. So far it's best mitigated by the
pack-bitmap patches in the next branch.

The initial clones become significantly faster and much less resource
intensive.

I'm hoping that the packed bitmap series lands soon in the master branch
and a formal release (a big +1 from me for it).

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
