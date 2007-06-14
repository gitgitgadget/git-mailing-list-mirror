From: sf <sf@b-i-t.de>
Subject: Re: git log -p file.c
Date: Thu, 14 Jun 2007 12:15:49 +0200
Message-ID: <46711555.5060106@b-i-t.de>
References: <20070614090217.GA8271@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 14 12:16:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HymNF-000580-GP
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 12:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbXFNKQQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 06:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbXFNKQQ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 06:16:16 -0400
Received: from main.gmane.org ([80.91.229.2]:45074 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806AbXFNKQP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 06:16:15 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HymMx-0001PK-Ma
	for git@vger.kernel.org; Thu, 14 Jun 2007 12:15:59 +0200
Received: from ip-213157015184.dialin.heagmedianet.de ([213.157.15.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Jun 2007 12:15:59 +0200
Received: from sf by ip-213157015184.dialin.heagmedianet.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Jun 2007 12:15:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ip-213157015184.dialin.heagmedianet.de
User-Agent: Thunderbird 2.0.0.0 (X11/20070521)
In-Reply-To: <20070614090217.GA8271@informatik.uni-freiburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50186>

Uwe Kleine-Koenig wrote:
> hello,
> 
> when I run
> 
> 	git log -p file.c
> 
> I don't get the complete change a commit introduces but only how file.c
> changed.  This is kind of surprising for me, I had expected to get the
> whole diff.

git log --full-diff -p file.c

(--full-diff seems to be undocumented)

Regards

Stephan
