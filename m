From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] git-p4: Strip branch name prefixes if --use-client-spec
 enabled
Date: Wed, 22 Aug 2012 17:22:41 -0400
Message-ID: <20120822212241.GA29233@padd.com>
References: <1345506210-17382-1-git-send-email-casey.mcginty@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Patrick C. McGinty" <casey.mcginty@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 23:22:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4IO4-00006q-Iy
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 23:22:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545Ab2HVVWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 17:22:46 -0400
Received: from honk.padd.com ([74.3.171.149]:48107 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751475Ab2HVVWp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 17:22:45 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id B2E6A2C1B;
	Wed, 22 Aug 2012 14:22:44 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id C201831444; Wed, 22 Aug 2012 17:22:41 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1345506210-17382-1-git-send-email-casey.mcginty@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204099>

casey.mcginty@gmail.com wrote on Mon, 20 Aug 2012 13:43 -1000:
> This removes the branch names from being included in the file system
> path when using the both --use-client-spec and --detect-branches
> options.
> 
> Used alone, the --detect-branches option did the right thing, removing
> the branch names from the relative git path. By adding the
> --use-client-spec option, the old logic would incorrectly bypass this
> step.

Thanks for reporting this bug, and supplying a fix.  I think,
though that this is the same issue we were looking at in this
thread:

    http://article.gmane.org/gmane.comp.version-control.git/203294

It is queued up and the fix likely will appear in 1.7.13 (or
whatever the next release after 1.7.12 is called).

(Gmane has been down all day from here; there's information from
another reporter in http://stackoverflow.com/questions/11893688/ .)

		-- Pete
