From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH 2/3] add basic lua infrastructure
Date: Tue, 25 Sep 2012 03:21:10 +0000
Message-ID: <robbat2-20120925T032006-952720661Z@orbis-terrarum.net>
References: <20120925002325.GA19560@sigill.intra.peff.net>
 <20120925002511.GB19605@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 25 05:21:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGLiM-00080v-MJ
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 05:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503Ab2IYDV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 23:21:26 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:54112 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752492Ab2IYDVM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 23:21:12 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 8AD6733C9F5
	for <git@vger.kernel.org>; Tue, 25 Sep 2012 03:21:11 +0000 (UTC)
Received: (qmail 6101 invoked by uid 10000); 25 Sep 2012 03:21:10 -0000
Content-Disposition: inline
In-Reply-To: <20120925002511.GB19605@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206343>

On Mon, Sep 24, 2012 at 08:25:12PM -0400,  Jeff King wrote:
> +ifdef USE_LUA
> +	BASIC_CFLAGS += -DUSE_LUA `pkg-config --cflags lua5.2`
> +	EXTLIBS += `pkg-config --libs lua5.2`
> +endif
Can you please hoist the packagename out to a variable? It's just plain
"lua" on Gentoo.

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Trustee & Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
