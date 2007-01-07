From: "J.H." <warthog9@kernel.org>
Subject: Re: How git affects kernel.org performance
Date: Sun, 07 Jan 2007 11:12:25 -0800
Message-ID: <1168197145.14963.1.camel@localhost.localdomain>
References: <20061214223718.GA3816@elf.ucw.cz>
	 <20061216094421.416a271e.randy.dunlap@oracle.com>
	 <20061216095702.3e6f1d1f.akpm@osdl.org> <458434B0.4090506@oracle.com>
	 <1166297434.26330.34.camel@localhost.localdomain>
	 <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com>
	 <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com>
	 <45A083F2.5000000@zytor.com>  <20070107145730.GB24706@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	nigel@nigel.suspend2.net, Randy Dunlap <randy.dunlap@oracle.com>,
	Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	webmaster@kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964875AbXAGTO3@vger.kernel.org Sun Jan 07 20:15:25 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964875AbXAGTO3@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3dTs-0004fU-1K
	for glk-linux-kernel-3@gmane.org; Sun, 07 Jan 2007 20:14:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbXAGTO3 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 7 Jan 2007 14:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbXAGTO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 14:14:28 -0500
Received: from shards.monkeyblade.net ([192.83.249.58]:45542 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964875AbXAGTO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 14:14:27 -0500
Received: from [192.168.1.93] (c-67-188-75-114.hsd1.ca.comcast.net [67.188.75.114])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.13.8/8.13.8) with ESMTP id l07JD5fm009799
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Sun, 7 Jan 2007 11:13:05 -0800
To: Robert Fitzsimons <robfitz@273k.net>
In-Reply-To: <20070107145730.GB24706@localhost>
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
X-Virus-Scanned: ClamAV version 0.88.7, clamav-milter version 0.88.7 on shards.monkeyblade.net
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36185>

With my gitweb caching changes this isn't as big of a deal as the front
page is only generated once every 10 minutes or so (and with the changes
I'm working on today that timeout will be variable)

- John

On Sun, 2007-01-07 at 14:57 +0000, Robert Fitzsimons wrote:
> > Some more data on how git affects kernel.org...
> 
> I have a quick question about the gitweb configuration, does the
> $projects_list config entry point to a directory or a file?
> 
> When it is a directory gitweb ends up doing the equivalent of a 'find
> $project_list' to find all the available projects, so it really should
> be changed to a projects list file.
> 
> Robert
