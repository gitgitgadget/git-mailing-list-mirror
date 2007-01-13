From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Sat, 13 Jan 2007 16:47:42 -0500
Message-ID: <20070113214742.GA17887@spearce.org>
References: <200701131815.27481.alan@chandlerfamily.org.uk> <200701132141.l0DLfWkG010141@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alan Chandler <alan@chandlerfamily.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 22:47:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5qj9-0001pE-Q2
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 22:47:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbXAMVrt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 16:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbXAMVrt
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 16:47:49 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:35010 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045AbXAMVrs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 16:47:48 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H5qit-0005IZ-9w; Sat, 13 Jan 2007 16:47:35 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B900920FBAE; Sat, 13 Jan 2007 16:47:42 -0500 (EST)
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Content-Disposition: inline
In-Reply-To: <200701132141.l0DLfWkG010141@laptop13.inf.utfsm.cl>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36775>

"Horst H. von Brand" <vonbrand@inf.utfsm.cl> wrote:
> Please don't. It would add e.g. the .class and .o and all ~ files, and all
> other junk you have lying around (test cases, test run output, ...). It
> isn't /that/ much more work after creating a new file to record its
> existence...

  echo \*.class >>.gitignore
  echo \*.o >>.gitignore
  git add .gitignore

doesn't work for some reason?
 
-- 
Shawn.
