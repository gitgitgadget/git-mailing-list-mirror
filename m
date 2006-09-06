From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] git-svnimport: Parse log message for Signed-off-by: lines
Date: Wed, 6 Sep 2006 17:33:14 +0200
Message-ID: <20060906153314.GE6999@kiste.smurf.noris.de>
References: <20060905184611.GB14732@sashak.voltaire.com> <7v1wqqc8dh.fsf@assigned-by-dhcp.cox.net> <20060905221754.GI14732@sashak.voltaire.com> <7v8xkxc2tr.fsf@assigned-by-dhcp.cox.net> <20060906125317.GA21645@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 17:34:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKzPw-0007h0-EH
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 17:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWIFPeR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 11:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWIFPeR
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 11:34:17 -0400
Received: from smurf.noris.de ([192.109.102.42]:62138 "EHLO smurf.noris.de")
	by vger.kernel.org with ESMTP id S1750717AbWIFPeP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 11:34:15 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by smurf.noris.de with smtp (Exim 4.60)
	(envelope-from <smurf@smurf.noris.de>)
	id 1GKzOu-0001pB-1t; Wed, 06 Sep 2006 17:33:17 +0200
Received: (nullmailer pid 9072 invoked by uid 501);
	Wed, 06 Sep 2006 15:33:14 -0000
To: Sasha Khapyorsky <sashak@voltaire.com>
Content-Disposition: inline
In-Reply-To: <20060906125317.GA21645@sashak.voltaire.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-Smurf-Spam-Score: -2.6 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26534>

Hi,

Sasha Khapyorsky:
> At least I didn't succeed with reversed layout. With option
> -T <trunk>/$project import works but only for trunk branch, attempts
> to specify branch as -b <branches> or -b <branches>/$project don't help,
> the same is with tags.
> 
That's true. The problem is that it wants the tag or branch name as the
last component of the path.

A more generic solution would be to use wildcards in the branch/tag
specification, to allow more than one wildcard, and to be able to
specify the exact form of the branch or tag name on the git side.

All of this should be specified in the repository's git config file,
not on the command line.


Somebody who wants to implement that is certainly invited to do so.
(I don't have time for that at the moment, unfortunately.)

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
