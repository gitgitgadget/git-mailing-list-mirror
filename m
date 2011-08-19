From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH v3 0/4] git-p4: Improve branch support
Date: Fri, 19 Aug 2011 04:53:10 -0700
Message-ID: <20110819115310.GC15639@padd.com>
References: <1313711046-23489-1-git-send-email-vitor.hda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tor Arvid Lund <torarvid@gmail.com>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 13:53:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuNdT-0007IM-Vy
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 13:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913Ab1HSLxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 07:53:13 -0400
Received: from honk.padd.com ([74.3.171.149]:33819 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751685Ab1HSLxL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 07:53:11 -0400
Received: by honk.padd.com (Postfix, from userid 7770)
	id DB5F95B51; Fri, 19 Aug 2011 04:53:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313711046-23489-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179694>

vitor.hda@gmail.com wrote on Fri, 19 Aug 2011 00:44 +0100:
> Add missing test case from last version of this set of patches.
> 
> Vitor Antunes (4):
>   git-p4: Correct branch base depot path detection
>   git-p4: Allow filtering Perforce branches by user
>   git-p4: Allow branch definition with git config
>   git-p4: Add simple test case for branch import
> 
>  contrib/fast-import/git-p4     |   40 ++++++++++++++++++++++--
>  contrib/fast-import/git-p4.txt |   13 ++++++++
>  t/t9800-git-p4.sh              |   64 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 113 insertions(+), 4 deletions(-)

Patches 1 and 2 are great.  We should have gotten those in way
back when you first submitted them.  I happily ack those.

I'm still a bit hung up on #3, mainly because I don't get branch
support.  Let me play around with your test.  Having this
playbook of how it is supposed to work will help to educate me.

		-- Pete
