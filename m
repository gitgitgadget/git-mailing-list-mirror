From: esr@thyrsus.com (Eric S. Raymond)
Subject: Python version auditing followup
Date: Thu, 20 Dec 2012 09:34:11 -0500 (EST)
Message-ID: <20121220143411.BEA0744105@snark.thyrsus.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 20 15:34:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlhD0-0006eW-02
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 15:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324Ab2LTOed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 09:34:33 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:35515
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116Ab2LTOeb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 09:34:31 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id BEA0744105; Thu, 20 Dec 2012 09:34:11 -0500 (EST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211890>

Most of the Python scripts in the distribution are small and simple to
audit, so I am pretty sure of the results.  The only place where I
have a concern is the git_helpers library; that is somewhat more
complex and I might have missed a dependency somewhere.  Whoever
owns that should check my finding that it should run under 2.4

That was the first of three patches I have promised.  In order to do
the next one, which will be a development guidelines recommend
compatibility back to some specific version X, I need a policy
decision.  How do we set X?

I don't think X can be < 2.4, nor does it need to be - 2.4 came out
in 2004 and eight years is plenty of deployment time.

The later we set it, the more convenient for developers.  But of
course by setting it late we trade away some portability to 
older systems.

In previous discussion of this issue I recommended X = 2.6.
That is still my recommendation. Thoughts, comments, objections?
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

In recent years it has been suggested that the Second Amendment
protects the "collective" right of states to maintain militias, while
it does not protect the right of "the people" to keep and bear arms.
If anyone entertained this notion in the period during which the
Constitution and the Bill of Rights were debated and ratified, it
remains one of the most closely guarded secrets of the eighteenth
century, for no known writing surviving from the period between 1787
and 1791 states such a thesis.
        -- Stephen P. Halbrook, "That Every Man Be Armed", 1984
