From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] Implement git-quiltimport (take 2)
Date: Thu, 01 Jun 2006 18:24:04 -0600
Message-ID: <m1y7wg5rrv.fsf@ebiederm.dsl.xmission.com>
References: <7v1wut2p5z.fsf@assigned-by-dhcp.cox.net>
	<m1bqtw4hk7.fsf_-_@ebiederm.dsl.xmission.com>
	<7vsln8cwn6.fsf@assigned-by-dhcp.cox.net>
	<m1zmhg31cm.fsf@ebiederm.dsl.xmission.com>
	<7vy7x09qet.fsf@assigned-by-dhcp.cox.net>
	<m1ejyr38xx.fsf@ebiederm.dsl.xmission.com>
	<20060519235825.GA3289@kroah.com>
	<m1ac9dv2ld.fsf@ebiederm.dsl.xmission.com>
	<20060520213257.GH24672@kroah.com>
	<m1fyj4qkm2.fsf@ebiederm.dsl.xmission.com>
	<20060601192318.GC3329@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 02:25:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlxTa-0001oq-GR
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 02:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWFBAZL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Jun 2006 20:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWFBAZL
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jun 2006 20:25:11 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49816 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750732AbWFBAZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jun 2006 20:25:09 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k520O5MJ001848;
	Thu, 1 Jun 2006 18:24:05 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k520O4e8001847;
	Thu, 1 Jun 2006 18:24:04 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Greg KH <greg@kroah.com>
In-Reply-To: <20060601192318.GC3329@kroah.com> (Greg KH's message of "Thu, 1
 Jun 2006 12:23:18 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21130>

Greg KH <greg@kroah.com> writes:

>> 
>> So I just grabbed the gregkh-2.6 set of patches and with an unmodified
>> git-mailinfo I only have problems with the following patches:
>> 	gregkh/gkh-version.patch
>> 	gregkh/sysfs-test.patch
>> 	gregkh/gregkh-usb-minors.patch
>> 	gregkh/gregkh-debugfs_example.patch
>> 	gregkh/gpl_future-test.patch
>> 	usb/usb-gotemp.patch
>> 
>> None of which actually have from headers.
>
> Oops, sorry for the delay.  I've now fixed up these patches (the ones in
> the gregkh/ directory are not ever going to be sent upstream, that's
> why they were missing headers, same for the gotemp driver.)

No problem. I'm mostly on vacation at the moment.

Things like usb/usb-gotemp.path have been sucked into the -mm
tree.  So sometimes these things after being published do wind up down stream...


Eric
