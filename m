From: Dave Jones <davej@redhat.com>
Subject: Re: Integrity check
Date: Tue, 6 Jun 2006 20:58:03 -0400
Message-ID: <20060607005803.GA10465@redhat.com>
References: <pan.2006.06.06.22.46.26.518589@canit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 07 02:58:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnmNJ-0006as-6K
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 02:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWFGA6P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 20:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWFGA6P
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 20:58:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6842 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750759AbWFGA6O (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jun 2006 20:58:14 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k570w9sO020320;
	Tue, 6 Jun 2006 20:58:09 -0400
Received: from nwo.kernelslacker.org (vpn83-124.boston.redhat.com [172.16.83.124])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k570w8nJ012803;
	Tue, 6 Jun 2006 20:58:08 -0400
Received: from nwo.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by nwo.kernelslacker.org (8.13.6/8.13.5) with ESMTP id k570w8uX015667;
	Tue, 6 Jun 2006 20:58:08 -0400
Received: (from davej@localhost)
	by nwo.kernelslacker.org (8.13.6/8.13.6/Submit) id k570w4Li015657;
	Tue, 6 Jun 2006 20:58:04 -0400
X-Authentication-Warning: nwo.kernelslacker.org: davej set sender to davej@redhat.com using -f
To: Kenneth Johansson <ken@canit.se>
Content-Disposition: inline
In-Reply-To: <pan.2006.06.06.22.46.26.518589@canit.se>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21424>

On Wed, Jun 07, 2006 at 12:46:27AM +0200, Kenneth Johansson wrote:

 > *** glibc detected *** malloc(): memory corruption: 0x0a703e80 ***

The last time I saw one of these in git, it turned out to be
due to a bug in glibc.  If you're using Fedora/RHEL, there are
updates available that fix this problem.

		Dave

-- 
http://www.codemonkey.org.uk
