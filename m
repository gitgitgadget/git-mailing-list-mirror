From: Allan Wind <allan_wind@lifeintegrity.com>
Subject: Re: [BUG] git archive broken in 1.7.8.1
Date: Tue, 10 Jan 2012 18:01:22 -0500
Message-ID: <20120110230122.GA24020@vent.lifeintegrity.localnet>
References: <5142795.2dTmMhVRTP@xps>
 <20120110213344.GI2714@centaur.lab.cmartin.tk>
 <1431498.0yPWNQLupF@xps>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 11 00:11:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkkqW-0001qw-02
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 00:11:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757000Ab2AJXKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 18:10:49 -0500
Received: from lifeintegrity.com ([173.48.39.13]:53975 "EHLO
	pawan.lifeintegrity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756980Ab2AJXKs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 18:10:48 -0500
X-Greylist: delayed 564 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Jan 2012 18:10:48 EST
Received: from vent.lifeintegrity.com (173-162-190-62-NewEngland.hfc.comcastbusiness.net [173.162.190.62])
	by submission.lifeintegrity.com (Postfix) with ESMTPS id 4EC9A208
	for <git@vger.kernel.org>; Tue, 10 Jan 2012 23:01:22 +0000 (UTC)
Received: by vent.lifeintegrity.com (Postfix, from userid 1000)
	id 0D487182AF7; Tue, 10 Jan 2012 23:01:22 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1431498.0yPWNQLupF@xps>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188302>

On 2012-01-10 23:05:45, Albert Astals Cid wrote:
> Unfortunately this producess a tarball with a different layout, e.g.
> 
> git archive --remote=git://anongit.kde.org/kgraphviewer.git HEAD:doc/en_US
>   gives me a tarball with the doc/en_US files in the root

Meaning the files you have stored in git under doc/en_US are 
dumped in the root directory of the tar?  That does not sound 
like desired behavior for the feature.


/Allan
-- 
Allan Wind
Life Integrity, LLC
<http://lifeintegrity.com>
