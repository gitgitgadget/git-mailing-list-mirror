From: Jeremy Maitin-Shepard <jbms@cmu.edu>
Subject: Re: Yet another "emacs-git" mode on emacs
Date: Mon, 24 Mar 2008 13:05:52 -0400
Message-ID: <87myoot5lb.fsf@jeremyms.com>
References: <1206363318.8927.28.camel@prosummer>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: tsgatesv <tsgatesv@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 18:07:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdq8W-0003sW-01
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 18:07:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759342AbYCXRF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 13:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760165AbYCXRF4
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 13:05:56 -0400
Received: from deleuze.hcoop.net ([69.90.123.67]:45318 "EHLO deleuze.hcoop.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754748AbYCXRFz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 13:05:55 -0400
Received: from c-67-165-107-197.hsd1.pa.comcast.net ([67.165.107.197] helo=localhost)
	by deleuze.hcoop.net with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <jbms@cmu.edu>)
	id 1Jdq7N-0005gh-4R; Mon, 24 Mar 2008 13:05:53 -0400
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-1: winter into spring
In-Reply-To: <1206363318.8927.28.camel@prosummer> (tsgatesv@gmail.com's
	message of "Mon, 24 Mar 2008 21:55:18 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78063>

One thing that stood out in your guided tour is the "Commit with an
automatically generated log message" if there are files not "up to date"
(which I guess means index does not match HEAD, OR working dir does not
match index).  It seems that this is almost certainly a bad feature to
have.

More generally, it seems that your package does not have the right
conceptual organization with respect to the index.  (The lack of the
word index in the guided tour document provides strong evidence of
this.)

Git is in many ways much more powerful than other version control
systems, but much of this power comes from having a more complicated
conceptual framework (in particular, it has the concept of the index,
which seems to be fairly unique to git).  In designing an Emacs UI for
git that can support all of its functionality, the same conceptual
organization must be used as git itself has.

-- 
Jeremy Maitin-Shepard
