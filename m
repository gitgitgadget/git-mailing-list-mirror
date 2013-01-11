From: esr@thyrsus.com (Eric S. Raymond)
Subject: parsecvs has been salvaged
Date: Fri, 11 Jan 2013 06:21:51 -0500 (EST)
Message-ID: <20130111112151.AFF924047B@snark.thyrsus.com>
Cc: Bart Massey <bart@cs.pdx.edu>, Keith Packard <keithp@keithp.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 12:22:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ttcgy-0007Jd-FU
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 12:22:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545Ab3AKLWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 06:22:06 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:39205
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169Ab3AKLWF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 06:22:05 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id AFF924047B; Fri, 11 Jan 2013 06:21:51 -0500 (EST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213204>

Since Heiko Voigt and others were concerned about this, I report that 
I have successfully salvaged the parsecvs code. I now have it emitting
a correct-looking fast-import stream for my main test repository.

I'm not ready to ship it yet because there are several features I
think it ought to have before I do.  An -R option like cvsps's;
correct interpretation of a third timezone field as in cvsps; and,
most significantly, I want to make sure it emits warnings for important
error and problem conditions like unresolvable tags and absence of
commitids.

But these are all relatively minor issues. It is likely I will be able
to ship early next week, at which point I will add support for
parsecvs as a third engine in new cvsimport.  

This next step in the larger program will be factoring out the cvsps
test suite and applying it to all three of cvsps, cvs2git, and
parsecvs so I can compare results.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

Americans have the right and advantage of being armed - unlike the citizens
of other countries whose governments are afraid to trust the people with arms.
	-- James Madison, The Federalist Papers
