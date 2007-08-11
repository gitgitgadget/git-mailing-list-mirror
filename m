From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG} git-fetch - won't fetch wildcarded tags
Date: Fri, 10 Aug 2007 21:14:15 -0700
Message-ID: <7vd4xur9m0.fsf@assigned-by-dhcp.cox.net>
References: <46BD25FC.1050201@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@verizon.net>
X-From: git-owner@vger.kernel.org Sat Aug 11 06:14:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJiN0-0001i6-2U
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 06:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbXHKEOS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 00:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbXHKEOS
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 00:14:18 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:43166 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbXHKEOR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 00:14:17 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070811041416.BXWR24055.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sat, 11 Aug 2007 00:14:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aUEG1X0011kojtg0000000; Sat, 11 Aug 2007 00:14:16 -0400
In-Reply-To: <46BD25FC.1050201@verizon.net> (Mark Levedahl's message of "Fri,
	10 Aug 2007 22:59:08 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55585>

Mark Levedahl <mlevedahl@verizon.net> writes:

> git>git fetch /tmp/foo 'refs/tags/*:refs/tags/*'
> * refusing to create funny ref 'tags/*' locally

I think fetch's wildcard is effective only in the config file,
and this is not just tags.  It would be nice if you could say

	$ git fetch foo.bndl 'refs/*:refs/*'
