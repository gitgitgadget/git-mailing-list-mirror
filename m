From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH/RFC] remove #!interpreter line from shell libraries
Date: Tue, 13 Mar 2012 20:09:49 +0100
Message-ID: <20120313190949.GB8074@ecki>
References: <20120308121403.GA16493@burratino>
 <20120309075820.GA15985@ecki>
 <4F5E4618.10102@xiplink.com>
 <20120312191703.GB21817@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, David Aguilar <davvid@gmail.com>,
	Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 20:18:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7XEn-00053K-Gm
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 20:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759243Ab2CMTSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 15:18:20 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:41083 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759152Ab2CMTST (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 15:18:19 -0400
X-Greylist: delayed 77463 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Mar 2012 15:18:19 EDT
Received: from localhost (p5B22F210.dip.t-dialin.net [91.34.242.16])
	by bsmtp.bon.at (Postfix) with ESMTP id 5CA1F13004F;
	Tue, 13 Mar 2012 20:15:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120312191703.GB21817@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193059>

On Mon, Mar 12, 2012 at 02:17:03PM -0500, Jonathan Nieder wrote:
> 
> By the way, my mild dislike for the #! line in shell libraries is
> actually rooted in functionality, in a way.  Though it would never
> happen in git, I have had too many unhappy experiences of shell
> libraries with #!/bin/bash at the top that were used in #!/bin/sh
> scripts and broke completely.  So that is where the bad association
> comes from.

Maybe I am missing something here, but as far as I can see this is an
argument for _keeping_ the #! line, because at least it will give a hint
that a /bin/bash library will not work for a /bin/sh script, whereas
"this is a shell library" can mean almost anything.

Anyways, I can certainly survive without the #! line. So please feel
free to ignore my comments if you feel strongly about this.

Clemens
