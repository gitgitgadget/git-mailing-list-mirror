From: "Michael J. Cohen" <michaeljosephcohen@mac.com>
Subject: Re: [RFC PATCH] Make gitk use --early-output
Date: Sat, 3 Nov 2007 22:07:57 -0400
Message-ID: <00989975-E385-4208-9E7E-1A2A3C737F61@mac.com>
References: <18221.2285.259487.655684@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Nov 04 03:13:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoUzg-0007Mj-1T
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 03:13:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757577AbXKDCN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 22:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757539AbXKDCN2
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 22:13:28 -0400
Received: from smtpoutm.mac.com ([17.148.16.82]:64597 "EHLO smtpoutm.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757361AbXKDCN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 22:13:28 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Nov 2007 22:13:28 EDT
Received: from mac.com (asmtp010-s [10.150.69.73])
	by smtpoutm.mac.com (Xserve/smtpout019/MantshX 4.0) with ESMTP id lA4280HG027359;
	Sat, 3 Nov 2007 19:08:00 -0700 (PDT)
Received: from mac-pro.lan (c-71-196-112-35.hsd1.fl.comcast.net [71.196.112.35])
	(authenticated bits=0)
	by mac.com (Xserve/asmtp010/MantshX 4.0) with ESMTP id lA427v5W012826
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 3 Nov 2007 19:07:58 -0700 (PDT)
In-Reply-To: <18221.2285.259487.655684@cargo.ozlabs.ibm.com>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63335>

On Nov 3, 2007, at 7:49 PM, Paul Mackerras wrote:

> This makes gitk use the --early-output flag on the git log command.


On Nov 3, 2007, at 2:11 PM, Linus Torvalds wrote:

> Try it out, with
>
> 	git log --early-output=2
>
> and look at what happens

This is awesome, guys.

I was initially doing some research to see what makes gitk/qgit slow  
over samba, but this seems to have solved it. :P

-mjc
