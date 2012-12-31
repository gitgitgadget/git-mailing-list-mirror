From: esr@thyrsus.com (Eric S. Raymond)
Subject: cvsps import failure
Date: Sun, 30 Dec 2012 21:28:41 -0500 (EST)
Message-ID: <20121231022841.CB59744143@snark.thyrsus.com>
Cc: git@vger.kernel.org
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Mon Dec 31 03:29:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpV8P-0004DP-3L
	for gcvg-git-2@plane.gmane.org; Mon, 31 Dec 2012 03:29:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754972Ab2LaC3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2012 21:29:23 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:47311
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753538Ab2LaC3V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2012 21:29:21 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id CB59744143; Sun, 30 Dec 2012 21:28:41 -0500 (EST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212347>

Chris Rorvick <chris@rorvick.com>:
> I tried the new version and found I'm unable to import via pserver:

And now I know why.  One of the cvsps fix patches I merged from Yann
Dirson's collection changed the --root option parsing in an
incompatible way.  As soon as I figure out what it's doing I'll
either revert it or document the new behavior.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

The price of liberty is, always has been, and always will be blood.  The person
who is not willing to die for his liberty has already lost it to the first
scoundrel who is willing to risk dying to violate that person's liberty.  Are
you free? 	-- Andrew Ford
