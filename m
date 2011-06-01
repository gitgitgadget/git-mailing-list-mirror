From: Drew Northup <drew.northup@maine.edu>
Subject: Re: gitosis asking for password
Date: Wed, 01 Jun 2011 14:24:18 -0400
Message-ID: <1306952658.19722.18.camel@drew-northup.unet.maine.edu>
References: <20110531154218.GA4483@Imperial-SSD-Overlord>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Guirgies <lt.infiltrator@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 20:24:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRq5q-0002PN-2v
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 20:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037Ab1FASY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 14:24:29 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:54699 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab1FASY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 14:24:28 -0400
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p51IOM7G008090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 1 Jun 2011 14:24:22 -0400
In-Reply-To: <20110531154218.GA4483@Imperial-SSD-Overlord>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=2 Fuz1=2
	Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p51IOM7G008090
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1307557463.50492@fnW4JIcKlzYO+JqB+N4CiA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174888>


On Wed, 2011-06-01 at 01:42 +1000, Tim Guirgies wrote:
> Hi List,
> 
> I've been trying to sort this out for a couple of days now, but have
> gotten absolutely nowhere.
> 
> For some reason, a few days ago, gitosis just stopped liking me, and I
> was unable to push or fetch from my gitosis server, getting the error
> message 'fatal: x does not appear to be a git repo'.
> 
> So, I decided to remove gitosis and start again.  Following this [1]
> guide, this is what I did/got:
<snip>

> $ git clone gitosis@overlord.imperial.fleet:gitosis-admin
> Cloning into gitosis-admin...
> gitosis@localhost's password: 
> 
> But of course, it shouldn't be asking me for a password, and nothing I
> type will work anyway, as it's a disabled password.
> 
> I've tried it a few times, completely purging the gitosis user and its
> home directory, but with the same results.  Has anybody had similar
> experiences?  Or does somebody know some magic trick to get gitosis
> working?  Did I miss a step?

> [1] http://scie.nti.st/2007/11/14/hosting-git-repositories-the-easy-and-secure-way

Hi Tim,
You'll notice that the year on that is 2007. I seem to recall the lack
of support factor is [a large part of] why Sitaram Chamarty gave the
world Gitolite (https://github.com/sitaramc/gitolite ). 
You may still be able to find some help with Gitosis, but I'd not risk
blacking out due to holding my breath too long if I were you.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
