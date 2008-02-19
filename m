From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] http-push: push <remote> :<branch> deletes remote
	branch
Date: Tue, 19 Feb 2008 13:58:40 +0100
Message-ID: <20080219125840.GA14049@localhost>
References: <20080218130726.GA26854@localhost> <alpine.LSU.1.00.0802181339470.30505@racer.site> <20080218155546.GA8934@localhost> <alpine.LSU.1.00.0802181733400.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 19 13:59:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRS4H-0003V1-GO
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 13:59:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672AbYBSM6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 07:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752614AbYBSM6k
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 07:58:40 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:57089 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672AbYBSM6j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 07:58:39 -0500
Received: by ug-out-1314.google.com with SMTP id z38so523248ugc.16
        for <git@vger.kernel.org>; Tue, 19 Feb 2008 04:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=HWtPDuKgbpxdagQ0HQHXvqxalqjDf8IpgrwE4PZYJPw=;
        b=Mw3oDTy43ghrEyLcfSwB66QEZqxryhUTVc48w9AMMoP4dC3ikGmAFxswc8c5cGgMdjAU+xk/B8yevq5cBpvWnfu1M4nCJm9QoJkizJpKugiRpaGNeaRt/QNcMwrIlWOh0fY0/pJKuzQvWRKTzpq+4c6JayPMNCEOqDAmlNLaXxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=EYP0yHyK+c9apOWSR5F/myO81BwbYFkwu4eo2oa4Jgml3FRQmeEmSo+NKWw6NT6gCOQvk9W+wa5/dZpHxjqhSJYclKyN2kbjDAo9SrJx3ubopeLZu7Oe6XqLmFC8vVpL+7J3euCyYEOopVnIP4ls1w3JdwXxAIx1FWxBaGr7+K4=
Received: by 10.67.196.2 with SMTP id y2mr4493571ugp.60.1203425917977;
        Tue, 19 Feb 2008 04:58:37 -0800 (PST)
Received: from darc.dyndns.org ( [62.47.37.178])
        by mx.google.com with ESMTPS id l19sm12282269fgb.0.2008.02.19.04.58.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Feb 2008 04:58:36 -0800 (PST)
Received: from drizzd by darc.dyndns.org with local (Exim 4.68)
	(envelope-from <drizzd@aon.at>)
	id 1JRS3U-0003hw-V4; Tue, 19 Feb 2008 13:58:40 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802181733400.30505@racer.site>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74396>

Hi,

On Mon, Feb 18, 2008 at 05:34:45PM +0000, Johannes Schindelin wrote:
> Thanks for the patch, I think it good.  Now, if we only had automated 
> tests... ;-)

Thank you. Implementing a test should be fairly difficult, since we need at
least a WebDAV capable webserver, right? Do you having something in mind?

And yes, 'peer' apparently refers to the local end in this case.

Clemens
