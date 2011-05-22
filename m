From: Pete Wyckoff <pw@padd.com>
Subject: Re: [git-p4] Trouble importing all perforce branches into git
 repository
Date: Sun, 22 May 2011 07:49:17 -0400
Message-ID: <20110522114917.GA19927@arf.padd.com>
References: <5A927B4F-7242-48AD-BC1C-BCA490A251C4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vitor Antunes <vitor.hda@gmail.com>, git@vger.kernel.org
To: Grant Limberg <glimberg@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 22 13:49:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QO79z-0004Qg-Ss
	for gcvg-git-2@lo.gmane.org; Sun, 22 May 2011 13:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754429Ab1EVLtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2011 07:49:23 -0400
Received: from honk.padd.com ([74.3.171.149]:53963 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754032Ab1EVLtV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2011 07:49:21 -0400
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id D5E591EF;
	Sun, 22 May 2011 04:49:20 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 8316931576; Sun, 22 May 2011 07:49:17 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <5A927B4F-7242-48AD-BC1C-BCA490A251C4@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174190>

glimberg@gmail.com wrote on Thu, 19 May 2011 19:32 +0000:
> [git-p4 automatic branch detection]
> > git p4 clone --verbose --detect-branches --max-changes=100 //project/...@all

I worry that --max-changes prevents it from pulling in the
ref for Branch-foo, and this confuses the automatic branch
detection that assumes it has all its parents.

It would certainly be more reliable if you did "git-p4 sync
--branch foo //project/foo@all" for each branch you care about.

Vitor has some modifications to auto-branch detection that might
be useful, or maybe some thoughts as to what's going on.

		-- Pete

(Vitor: full mail is here:
http://article.gmane.org/gmane.comp.version-control.git/173996/ )
