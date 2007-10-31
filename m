From: Allan Wind <allan_wind@lifeintegrity.com>
Subject: Re: cpio command not found
Date: Wed, 31 Oct 2007 09:58:46 -0400
Message-ID: <20071031135846.GU23408@lifeintegrity.com>
References: <18216.31314.990545.518458@lisa.zopyra.com> <20071031133039.GA29065@diana.vm.bytemark.co.uk> <18216.35066.259686.376571@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 31 15:30:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InEaW-00055m-C3
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 15:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755124AbXJaOaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 10:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755195AbXJaOaO
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 10:30:14 -0400
Received: from vs690.rosehosting.com ([209.135.157.90]:42425 "EHLO
	lifeintegrity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653AbXJaOaN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 10:30:13 -0400
X-Greylist: delayed 1886 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 Oct 2007 10:30:13 EDT
Received: from viento.lifeintegrity.com (pool-72-93-227-71.bstnma.fios.verizon.net [72.93.227.71])
	by submission.lifeintegrity.com (Postfix) with ESMTP id 49017D5C726
	for <git@vger.kernel.org>; Wed, 31 Oct 2007 13:58:47 +0000 (UTC)
Received: by viento.lifeintegrity.com (Postfix, from userid 1000)
	id 14267248090; Wed, 31 Oct 2007 09:58:46 -0400 (EDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <18216.35066.259686.376571@lisa.zopyra.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62837>

On 2007-10-31T07:54:02-0600, Bill Lear wrote:
> If the system does not have cpio, I think the build of git should
> complain and fail, or it should activate code that treats any
> repository accessed over the file system as it would file://.

git may be build and run on two different hosts, so while the build-time 
check is good there should be a run-time check as well.


/Allan
