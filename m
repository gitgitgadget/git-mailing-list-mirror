From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: Getting git to help my memory
Date: Tue, 05 Jul 2011 19:52:53 -0400
Message-ID: <1309909855-sup-3456@pinkfloyd.chass.utoronto.ca>
References: <loom.20110705T232905-603@post.gmane.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Evan Driscoll <driscoll@cs.wisc.edu>
X-From: git-owner@vger.kernel.org Wed Jul 06 01:53:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeFQJ-00087U-Sm
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 01:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036Ab1GEXwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jul 2011 19:52:55 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:34169 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449Ab1GEXwy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2011 19:52:54 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:44695 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1QeFQD-0005VG-8v; Tue, 05 Jul 2011 19:52:53 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1QeFQD-00080X-7p; Tue, 05 Jul 2011 19:52:53 -0400
In-reply-to: <loom.20110705T232905-603@post.gmane.org>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176633>

Excerpts from Evan Driscoll's message of Tue Jul 05 17:34:18 -0400 2011:

Hi Evan,

> The best way I can think of is to put a post-commit hook in there. I
> haven't tried it but I'd assume it would work, but would have to be
> on a per-repository basis instead of global.

I use this script as a post-commit hook in a few places...

--snip--
#!/bin/bash

echo -e "\e[32;01m"
echo "Don't forget to \`git push\` this..."
echo -e "\e[0m"
--snip--

HTH.
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
