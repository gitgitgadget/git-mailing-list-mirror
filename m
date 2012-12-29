From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: [PATCH] Remove the suggestion to use parsecvs, which is
 currently broken.
Date: Fri, 28 Dec 2012 23:42:00 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121229044200.GA16086@thyrsus.com>
References: <20121228162025.8565E4413A@snark.thyrsus.com>
 <20121228230149.GA3575@book-mint>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sat Dec 29 05:43:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TooG8-0003Sl-B0
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 05:42:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526Ab2L2Emi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 23:42:38 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:35855
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142Ab2L2Emh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 23:42:37 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 4CF5B4413A; Fri, 28 Dec 2012 23:42:00 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20121228230149.GA3575@book-mint>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212288>

Heiko Voigt <hvoigt@hvoigt.net>:
> Maybe you could add that information to the parsecvs compile
> instructions? I think just because it takes some effort to compile does
> not justify to remove this useful pointer here. When I was converting a
> legacy cvs repository this pointer would have helped me a lot.

I'm parsecvs's maintainer now.  It's not in good shape; there is at
least one other known showstopper besides the build issue.  I would
strongly prefer to direct peoples' attention away from it until I
have time to fix it and cut a release.  This is not a distant 
prospect - two or three weeks out, maybe.

The priority that is between me and fixing parsecvs is getting (a)
cvsps and git-cvsimport to a non-broken state, and (b) having a sound
test suite in place so I *know* it's in a non-broken state. As previously
discussed, I will then apply that test suite to parsecvs.

Heiko, you can speed up the process by (a) adapting your tests for
the new cvsps test code, and (b) merging the fix you wrote so cvsps
would pass the t9603 test.  

The sooner I can get that out of the way, the sooner I will be avble
to pay serious attention to parsecvs.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
