From: Stephen Bash <bash@genarts.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Wed, 20 Oct 2010 10:21:47 -0400 (EDT)
Message-ID: <30010681.536316.1287584507672.JavaMail.root@mail.hq.genarts.com>
References: <1287563970.2673.12.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 16:22:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8ZYJ-00044C-Ne
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 16:22:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011Ab0JTOVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 10:21:55 -0400
Received: from hq.genarts.com ([173.9.65.1]:54069 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752109Ab0JTOVy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 10:21:54 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id C6E411E26376;
	Wed, 20 Oct 2010 10:21:53 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sC7hsWpxsSR0; Wed, 20 Oct 2010 10:21:47 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id C5E401E26374;
	Wed, 20 Oct 2010 10:21:47 -0400 (EDT)
In-Reply-To: <1287563970.2673.12.camel@wpalmer.simply-domain>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159412>

----- Original Message -----
> From: "Will Palmer" <wmpalmer@gmail.com>
> To: "Ramkumar Ramachandra" <artagnon@gmail.com>
> Sent: Wednesday, October 20, 2010 4:39:30 AM
> Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial git-svn fetch)
> 
> I was under the impression that there
> would be one "one-to-one" mapping branch (which would never be checked
> out), containing the history of /, and that the "real" git branches,
> tags, etc, would be based on the trees originally referenced by the root
> checkout, with git-notes (or similar) being used to track the weirdness
> in mappings.

Admittedly I'm not in the inner circle, but this is the first time I've heard the idea.  It's certainly intriguing.  In this case would the one-to-one branch include the full SVN repository history (all projects), or would svn-fe/git-fast-import filter down to subdirectories of interest?

Along those lines I can contribute the following data point: my initial fast-import repository weighs in at 1.3G, while after my scripts run the final product is 659M (and no, they are not hard linking to each other).  Unfortunately I don't have a good accounting of the size difference (obviously some is filtering down to a single SVN project).

Thanks,
Stephen
