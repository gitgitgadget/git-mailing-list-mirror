From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
Date: Sun, 07 Jan 2007 13:30:53 -0800
Message-ID: <45A1668D.2010203@zytor.com>
References: <20061214223718.GA3816@elf.ucw.cz> <20061216094421.416a271e.randy.dunlap@oracle.com> <20061216095702.3e6f1d1f.akpm@osdl.org> <458434B0.4090506@oracle.com> <1166297434.26330.34.camel@localhost.localdomain> <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com> <1168140954.2153.1.camel@nigel.suspend2.net> <45A07587.3080503@garzik.org> <20070107201146.GA21956@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff Garzik <jeff@garzik.org>, nigel@nigel.suspend2.net,
	Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	"J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	webmaster@kernel.org, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 07 22:32:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3fcY-00066z-DG
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 22:32:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965196AbXAGVb7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 16:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965203AbXAGVb7
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 16:31:59 -0500
Received: from terminus.zytor.com ([192.83.249.54]:46897 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965196AbXAGVb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 16:31:58 -0500
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l07LUrUX026736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 7 Jan 2007 13:30:53 -0800
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
To: Greg KH <gregkh@suse.de>
In-Reply-To: <20070107201146.GA21956@suse.de>
X-Virus-Scanned: ClamAV 0.88.7/2420/Sun Jan  7 12:15:45 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=1.0 required=5.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_24_48,RCVD_IN_SORBS_DUL autolearn=no version=3.1.7
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36200>

Greg KH wrote:

> 
> Well, I create my repos by doing a:
> 	git clone -l --bare
> which makes a hardlink from Linus's tree.
> 
> But then it gets copied over to the public server, which probably severs
> that hardlink :(
> 
> Any shortcut to clone or set up a repo using "alternatives" so that we
> don't have this issue at all?
> 

Use the -s option to git clone.

	-hpa
