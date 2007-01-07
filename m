From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
Date: Sat, 06 Jan 2007 23:22:31 -0500
Message-ID: <45A07587.3080503@garzik.org>
References: <20061214223718.GA3816@elf.ucw.cz>	 <20061216094421.416a271e.randy.dunlap@oracle.com>	 <20061216095702.3e6f1d1f.akpm@osdl.org>  <458434B0.4090506@oracle.com>	 <1166297434.26330.34.camel@localhost.localdomain>	 <1166304080.13548.8.camel@nigel.suspend2.net>  <459152B1.9040106@zytor.com> <1168140954.2153.1.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	webmaster@kernel.org, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 07 05:23:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3PYm-0002LR-AR
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 05:23:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbXAGEWx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 23:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbXAGEWx
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 23:22:53 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:46905 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932369AbXAGEWw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 23:22:52 -0500
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1H3PYG-00013e-KV; Sun, 07 Jan 2007 04:22:33 +0000
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
To: nigel@nigel.suspend2.net, "H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
	Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1168140954.2153.1.camel@nigel.suspend2.net>
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36124>

> On Tue, 2006-12-26 at 08:49 -0800, H. Peter Anvin wrote:
>> Not really.  In fact, it would hardly help at all.
>>
>> The two things git users can do to help is:
>>
>> 1. Make sure your alternatives file is set up correctly;
>> 2. Keep your trees packed and pruned, to keep the file count down.
>>
>> If you do this, the load imposed by a single git tree is fairly negible.


Would kernel hackers be amenable to having their trees auto-repacked, 
and linked via alternatives to Linus's linux-2.6.git?

Looking through kernel.org, we have a ton of repositories, however 
packed, that carrying their own copies of the linux-2.6.git repo.

Also, I wonder if "git push" will push only the non-linux-2.6.git 
objects, if both local and remote sides have the proper alternatives set up?

	Jeff
