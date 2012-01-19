From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCHv4 0/5] git-p4: small fixes to branches and labels
Date: Thu, 19 Jan 2012 10:19:34 -0500
Message-ID: <20120119151934.GA3698@padd.com>
References: <1326966749-9077-1-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Vitor Antunes <vitor.hda@gmail.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Thu Jan 19 16:19:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RntmB-0001Cn-EK
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 16:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164Ab2ASPTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 10:19:38 -0500
Received: from honk.padd.com ([74.3.171.149]:40236 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753248Ab2ASPTh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 10:19:37 -0500
Received: from arf.padd.com (unknown [50.55.142.76])
	by honk.padd.com (Postfix) with ESMTPSA id C5A552106;
	Thu, 19 Jan 2012 07:19:36 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 303A2313B5; Thu, 19 Jan 2012 10:19:34 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1326966749-9077-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188815>

luke@diamand.org wrote on Thu, 19 Jan 2012 09:52 +0000:
> This is the fourth version of some small fixes to git-p4 branch and
> label handling, incorporating a fix from Pete Wyckoff and an
> additional failing test.
> 
> This change does not fix the other problems with git-p4 labels:
> 
> - two p4 labels on the same changelist will fall over
> - labels must match exactly the list of files imported
> - you can't import a label without a p4 commit

This all looks great to me.  Thanks for adding that failing test,
and fixing the pre-existing bug in invoking p4 labels.

		-- Pete
