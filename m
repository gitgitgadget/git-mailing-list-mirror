From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Tue, 22 Jan 2008 16:38:37 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0!801211407130.2957@woody.linux-foundation.org> <0CA4DF3F-1B64-4F62-8794-6F82C21BD068@sb.org> <alpine.LFD.1.00.0801211538590.2957@woody.linux-foundation.org> <F663E088-BCAD-4C5D-89D5-EAF97A29C1DE@sb.org>
 <alpine.LFD.1.00.0801211656130.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801211702050.2957@woody.linux-foundati!on.org> <34103945-2078-4983-B409-2D01EF071A8B@sb.org> <alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org>
 <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org> <20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Kevin Ballard <kevin@sb.org>
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Jan 23 01:39:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHTeV-0005yZ-TV
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 01:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829AbYAWAjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 19:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751698AbYAWAjJ
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 19:39:09 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34348 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751667AbYAWAjI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jan 2008 19:39:08 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0N0cbYO009871
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 22 Jan 2008 16:38:43 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0N0cb3c015807;
	Tue, 22 Jan 2008 16:38:37 -0800
In-Reply-To: <20080123000841.GA22704@mit.edu>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.724 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71482>



On Tue, 22 Jan 2008, Theodore Tso wrote:
> 
> I'd also recommend that the Mac OS X code try to either figure out
> whether it is running on an HFS+ partition, or let the HFS+ workaround
> code be something that can be controlled via .git/config.  It
> shouldn't be on unconditionally even on a Mac OS X system, since if
> the git repository is on a ZFS or NFS filesystem, there's no reason to
> pay the overhead of working around the HFS+ bugs.

One thing I'd like somebody to check: what _does_ happen with OS X and NFS 
(OS X as a client, not server)? In particular:

 - Is it suddenly sane and case-sensitive?

 - Does the NFS client do any unicode conversion?

I tried to google for it, but didn't find the right keywords to get 
anything useful out of that modern-day internet oracle.

		Linus
