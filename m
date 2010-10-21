From: Drew Northup <drew.northup@maine.edu>
Subject: Re: git repository in production release
Date: Thu, 21 Oct 2010 08:39:17 -0400
Message-ID: <1287664757.24161.17.camel@drew-northup.unet.maine.edu>
References: <loom.20101021T140249-924@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonas <jonas@ibiz.se>
X-From: git-owner@vger.kernel.org Thu Oct 21 14:41:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8uSP-0004bB-GP
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 14:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757858Ab0JUMlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 08:41:15 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:46179 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755588Ab0JUMlP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 08:41:15 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id o9LCdN40006582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 21 Oct 2010 08:39:28 -0400
In-Reply-To: <loom.20101021T140249-924@post.gmane.org>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=2
	Fuz1=2 Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: o9LCdN40006582
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1288269599.57487@LCQGSHrjOWqCgUdFiGuoqQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159497>


On Thu, 2010-10-21 at 12:13 +0000, Jonas wrote:
> Hi,
> 
> I am afraid this is a rather stupid question, but I have spent quite some time
> to figure it out without any success.
> 
> I use git in my Ruby on Rails applications. On my deployment server
> there is a git directory that I push to in the admin users directory. 
> When I run cap deploy Capistrano makes a new release and makes a new 
> directory under releases from the repository, I guess this is standard.
> 
> My releases are getting bigger and bigger, it takes longer and 
> longer time for the cap deploy command to 
> finish and the backups contain a huge number of files.
> 
> What puzzels me is that in every release  there is a .git directory.
> As far as I can see it makes no use there, 
> just takes up much space. Is it supposed to be like this or have I made a mess?
> 
> How can I get rid of the .git directory in the deployment releases?

Why is this a git problem and not a Capistrano problem?

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
