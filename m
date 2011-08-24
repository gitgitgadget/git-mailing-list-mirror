From: Drew Northup <drew.northup@maine.edu>
Subject: Re: master-master server setup
Date: Wed, 24 Aug 2011 14:26:45 -0400
Message-ID: <1314210406.14580.6.camel@drew-northup.unet.maine.edu>
References: <loom.20110824T191218-282@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Sitaram Chamarty <sitaramc@gmail.com>
To: Corey Mitchell <cmitchell@cctus.com>
X-From: git-owner@vger.kernel.org Wed Aug 24 20:28:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwIBL-0005vd-3i
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 20:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521Ab1HXS2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 14:28:01 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:41851 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158Ab1HXS2B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 14:28:01 -0400
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p7OIQnUI015511
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 24 Aug 2011 14:26:54 -0400
In-Reply-To: <loom.20110824T191218-282@post.gmane.org>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=3
	Fuz1=3 Fuz2=3
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p7OIQnUI015511
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1314815224.31704@p4WcFx18l1SSTfrCeQE87A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180022>


On Wed, 2011-08-24 at 17:14 +0000, Corey Mitchell wrote:
> Hello Git team,
>  
> We have a distributed team (US and Japan).  We are thinking about migrating from
> subversion to git because it better suits our distributed team.  Due to network
> latency, we want to setup 2 git servers hosting the same repository.  We want
> developers to be able to download and publish branches to their local server and
> then have those changes replicated to the other site.  Is this possible?  Can
> someone please explain how this setup is done?  If not, can someone please
> explain the closest alternative and how it is setup? 

Corey,
If you choose to use gitolite, then you can just use Sitaram's
instructions here:
http://sitaramc.github.com/gitolite/doc/mirroring.html

If nothing else, you might find it inspirational.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
