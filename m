From: Dave Jones <davej@redhat.com>
Subject: Re: git-applymbox fails to extract patch.
Date: Fri, 10 Mar 2006 00:47:01 -0500
Message-ID: <20060310054701.GA27114@redhat.com>
References: <20060310050446.GA20764@redhat.com> <Pine.LNX.4.64.0603092130030.18022@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 10 06:47:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHaTS-00041B-TV
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 06:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbWCJFr0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 00:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751740AbWCJFr0
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 00:47:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35796 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751645AbWCJFrZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Mar 2006 00:47:25 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id k2A5lGPi017685;
	Fri, 10 Mar 2006 00:47:16 -0500
Received: from nwo.kernelslacker.org (vpn83-124.boston.redhat.com [172.16.83.124])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id k2A5l5120935;
	Fri, 10 Mar 2006 00:47:05 -0500
Received: from nwo.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by nwo.kernelslacker.org (8.13.5/8.13.5) with ESMTP id k2A5l4aD012639;
	Fri, 10 Mar 2006 00:47:05 -0500
Received: (from davej@localhost)
	by nwo.kernelslacker.org (8.13.5/8.13.5/Submit) id k2A5l2qs012029;
	Fri, 10 Mar 2006 00:47:02 -0500
X-Authentication-Warning: nwo.kernelslacker.org: davej set sender to davej@redhat.com using -f
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603092130030.18022@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17457>

On Thu, Mar 09, 2006 at 09:35:11PM -0800, Linus Torvalds wrote:
 > 
 > 
 > On Fri, 10 Mar 2006, Dave Jones wrote:
 > > 
 > > What am I missing ?
 > 
 > Do you have "Content-Type:" headers with a multi-part boundary? That can 
 > cause it.

ahhh.
I was sent a MIME mail, and saved the attachment, then deleted
the junk from the body, and inlined it.
Never crossed my mind to check the headers.  That'll be it.

Now I remember why I hate hand-munging mails.


*snip snip*


$ git-applymbox -k ~/Mail/mbox
1 patch(es) to process.

Applying '[CPUFREQ] Fix the p4-clockmod N60 errata workaround.'

Wrote tree 6d7d2dfd2309675446f727a6b4b2a6ff475835fb
Committed: 6d373ea012b2974e627b9ee830e75cf3bf3c4c24

Sweet. I'm happy again.

Thanks,

		Dave
-- 
http://www.codemonkey.org.uk
