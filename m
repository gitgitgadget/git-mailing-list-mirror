From: maximilian attems <max@stro.at>
Subject: Re: commit --amend neglecting return value
Date: Mon, 22 Mar 2010 19:39:56 +0100
Message-ID: <20100322183956.GC21299@stro.at>
References: <20100322043616.GF21406@baikonur.stro.at>
 <196847A3-42CB-4CE8-8FFC-D7C8C8AFCDF7@gernhardtsoftware.com>
 <E139EF92-B047-4928-A390-D47224CAA3DB@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 01:13:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ntrjw-0004Eo-6s
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 01:13:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754710Ab0CWAMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 20:12:55 -0400
Received: from baikonur.stro.at ([213.239.196.228]:39893 "EHLO
	baikonur.stro.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754376Ab0CWAMy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 20:12:54 -0400
Received: from dual (pa-67-234-122-227.dhcp.embarqhsd.net [67.234.122.227])
	by baikonur.stro.at (Postfix) with ESMTP id 325845C010;
	Tue, 23 Mar 2010 01:05:13 +0100 (CET)
Received: by dual (Postfix, from userid 1000)
	id 3870D240E4; Mon, 22 Mar 2010 19:39:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <E139EF92-B047-4928-A390-D47224CAA3DB@gernhardtsoftware.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: by Amavis (ClamAV) at stro.at
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142979>

On Mon, 22 Mar 2010, Brian Gernhardt wrote:

> 
> On Mar 22, 2010, at 1:16 AM, Brian Gernhardt wrote:
> 
> > If you want to abort committing while editing the message, delete the entire message (in Vim: "0dG:wq^M") and git will reply "Aborting commit due to empty commit message."
> 
> Oops.  Obviously I meant "ggdG:wq^M".
> 
> Also, a quick search of :help and testing reveals that ":cq" causes Vim to exit with non-zero status which will cause git to abort the commit.

thanks for the pointer this is indeed very helpful. :)

kept hiting that bug in stressy situations, good to know a way out.
