From: Robert Fitzsimons <robfitz@273k.net>
Subject: Re: How git affects kernel.org performance
Date: Sun, 7 Jan 2007 14:57:30 +0000
Message-ID: <20070107145730.GB24706@localhost>
References: <20061214223718.GA3816@elf.ucw.cz> <20061216094421.416a271e.randy.dunlap@oracle.com> <20061216095702.3e6f1d1f.akpm@osdl.org> <458434B0.4090506@oracle.com> <1166297434.26330.34.camel@localhost.localdomain> <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com> <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com> <45A083F2.5000000@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, nigel@nigel.suspend2.net,
	"J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	webmaster@kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 15:58:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3ZTx-0000BP-2N
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 15:58:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbXAGO6h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 09:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932561AbXAGO6h
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 09:58:37 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:43249 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932563AbXAGO6g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 09:58:36 -0500
Received: from a-103-62.cust.iol.ie ([194.125.103.62] helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.60)
	(envelope-from <robfitz@273k.net>)
	id 1H3ZSo-0002iC-FU; Sun, 07 Jan 2007 14:57:34 +0000
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <45A083F2.5000000@zytor.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=-0.012, required 7,
	autolearn=disabled, RCVD_IN_NERDS_IE -2.00, RCVD_IN_SORBS_DUL 1.99)
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36171>

> Some more data on how git affects kernel.org...

I have a quick question about the gitweb configuration, does the
$projects_list config entry point to a directory or a file?

When it is a directory gitweb ends up doing the equivalent of a 'find
$project_list' to find all the available projects, so it really should
be changed to a projects list file.

Robert
