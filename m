From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Sat, 13 Jan 2007 15:34:56 -0500
Message-ID: <20070113203456.GA17648@spearce.org>
References: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com> <slrneqha0g.5sa.Peter.B.Baumann@xp.machine.xx> <E5A7E6A8-45FF-4A7A-A31E-DFEBAD48DF1C@silverinsanity.com> <200701131815.27481.alan@chandlerfamily.org.uk> <8E585186-FC3F-473B-BA1F-91CFEF1A63F4@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alan Chandler <alan@chandlerfamily.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 21:35:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5pam-0002wi-Bb
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 21:35:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422790AbXAMUfF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 15:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422791AbXAMUfE
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 15:35:04 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:33000 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422790AbXAMUfB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 15:35:01 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H5paT-0007DA-Sc; Sat, 13 Jan 2007 15:34:49 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5F7F220FBAE; Sat, 13 Jan 2007 15:34:56 -0500 (EST)
To: Brian Gernhardt <benji@silverinsanity.com>
Content-Disposition: inline
In-Reply-To: <8E585186-FC3F-473B-BA1F-91CFEF1A63F4@silverinsanity.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36770>

Brian Gernhardt <benji@silverinsanity.com> wrote:
> Yes.  It sounds very much like you want to simply do "git add . ; git  
> commit -a".  But making that the default for "commit -a" would be  
> obnoxious for many other people.

I find it annoying that "commit -a" isn't implemented in terms of
"git add .".  Mainly because I'll make a number of changes in Eclipse
then go back and do "commit -a" and only days later discover that
I have untracked files in my working directory which should have
been added to the commit several days ago.

Although despite the fact that I always have my .gitignore setup 
properly, every once in a while I'll change something to produce
a new file that Git should really ignore, and I'll forget to put
it into .gitignore.  Having some sort of "commit -a" which adds
that new file would be an issue.
 
> A more through version ("git commit --everything"?) that also adds  
> files would be fine, but don't muck up the existing -a, please.

Yes, breaking -a may be a problem.

-- 
Shawn.
