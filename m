From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Diff output from a rewrite of a function
Date: Fri, 9 Mar 2007 20:47:54 +0100
Organization: Dewire
Message-ID: <200703092047.54799.robin.rosenberg.lists@dewire.com>
References: <Pine.LNX.4.64.0703082049060.19974@kivilampi-30.cs.helsinki.fi> <200703082301.35774.robin.rosenberg.lists@dewire.com> <7vbqj38gkp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Ilpo =?iso-8859-1?q?J=E4rvinen?= <ilpo.jarvinen@helsinki.fi>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 09 22:11:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPmMM-0006N8-MY
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 22:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965640AbXCIVKf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 16:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965818AbXCIVKf
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 16:10:35 -0500
Received: from [83.140.172.130] ([83.140.172.130]:19350 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S965640AbXCIVKd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 16:10:33 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 2DD4F80284B;
	Fri,  9 Mar 2007 22:05:19 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 04995-08; Fri,  9 Mar 2007 22:05:18 +0100 (CET)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id AAB97802848;
	Fri,  9 Mar 2007 22:05:16 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <7vbqj38gkp.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41809>

fredag 09 mars 2007 00:24 skrev Junio C Hamano:
> Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:
> 
> > Increase the context size from the default three lines.  Something like
> > diff -U 7 old new will require larger chunks of unchanged code for diff
> > break up a hunk. With git you can do 
> >
> > GIT_DIFF_OPTS=-u7 git-diff-....
> 
> I think you can say "git diff -U7" to do what you are
> describing, but I do not think that does what you want.  

True, it's not exactly what I want, but it is easier to read than a diff split 
up in  many small hunks with misleading context. With larger hunks I can 
ignore the misleading matching lines in the middle without thinking too much, 
so it kind-o alleviates my problems a little.

-- robin
