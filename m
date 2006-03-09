From: smurf@smurf.noris.de
Subject: Re: [PATCH] Don't recurse into parents marked uninteresting.
Date: Thu, 9 Mar 2006 11:20:52 +0100
Message-ID: <20060309102052.GD18478@smurf.noris.de>
References: <pan.2006.03.08.20.04.24.62170@smurf.noris.de> <pan.2006.03.09.04.04.34.617873@smurf.noris.de> <Pine.LNX.4.64.0603082144450.32577@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 09 11:27:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHIMd-0001v7-CI
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 11:27:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWCIK1U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 05:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbWCIK1U
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 05:27:20 -0500
Received: from run.smurf.noris.de ([192.109.102.41]:14210 "EHLO smurf.noris.de")
	by vger.kernel.org with ESMTP id S1750710AbWCIK1T (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Mar 2006 05:27:19 -0500
Received: from smurf by smurf.noris.de with local (Exim 4.60)
	(envelope-from <smurf@smurf.noris.de>)
	id 1FHIGK-0006sT-Gz; Thu, 09 Mar 2006 11:20:52 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603082144450.32577@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17404>

Hi,

Linus Torvalds:
> So what was it that triggered this "parents had already been parsed" 
> situation? Is it because we've generated a huge list of "I have it" 
> objects when pulling? That would explain it..
> 
Something like that. I've converted a large number of older heads
(ranging from a few months to a few years) from $EVIL_SCM to git,
and tried to push them up to our main repository, which contains the
current development.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
:read-only user: n. Describes a {luser} who uses computers almost
   exclusively for reading Usenet, bulletin boards, and/or email, rather
   than writing code or purveying useful information. See {twink},
   {terminal junkie}, {lurker}.
