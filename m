From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH v3 0/3] git-p4: Search for parent commit on branch
 creation
Date: Wed, 25 Jan 2012 23:21:49 -0500
Message-ID: <20120126042149.GA24269@padd.com>
References: <1327535304-11332-1-git-send-email-vitor.hda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 26 05:21:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqGqU-0006I3-0S
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 05:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829Ab2AZEVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jan 2012 23:21:53 -0500
Received: from honk.padd.com ([74.3.171.149]:45644 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751682Ab2AZEVw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2012 23:21:52 -0500
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id 137B7E8B;
	Wed, 25 Jan 2012 20:21:52 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id DCC1931453; Wed, 25 Jan 2012 23:21:49 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1327535304-11332-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189139>

vitor.hda@gmail.com wrote on Wed, 25 Jan 2012 23:48 +0000:
> I think this will, hopefully, be the final version of this series of
> patches. This version includes the following changes since v2:
> 
>  - Move search algorithm into its own function.
>  - Use lists instead of strings on shell commands.
>  - Some small (almost cosmetic) updates to test cases.

Whole series

Acked-by: Pete Wyckoff <pw@padd.com>

Thanks for making all the changes.

> Pete Wyckoff (1):
>   git-p4: Change p4 command invocation
> 
> Vitor Antunes (2):
>   git-p4: Search for parent commit on branch creation
>   git-p4: Add test case for complex branch import
> 
>  contrib/fast-import/git-p4 |   48 +++++++++++++++++++++-
>  t/t9801-git-p4-branch.sh   |   94 ++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 133 insertions(+), 9 deletions(-)
> 
> -- 
> 1.7.8.3
> 
