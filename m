From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [RFC] Replace rebase with filtering
Date: Tue, 16 Jan 2007 12:40:30 -0800
Message-ID: <45AD383E.50105@midwinter.com>
References: <45AC3B5D.6080700@midwinter.com> <Pine.LNX.4.63.0701161216440.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45AD2568.4040408@midwinter.com> <45AD2AE7.2010908@midwinter.com> <Pine.LNX.4.63.0701162131130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 21:40:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6v6g-0003j7-CL
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 21:40:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbXAPUkc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 15:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbXAPUkc
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 15:40:32 -0500
Received: from tater.midwinter.com ([216.32.86.90]:44110 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751482AbXAPUkb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 15:40:31 -0500
Received: (qmail 31680 invoked from network); 16 Jan 2007 20:40:30 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.131?) (koreth@76.21.17.123)
  by tater.midwinter.com with SMTP; 16 Jan 2007 20:40:30 -0000
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701162131130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36963>

Johannes Schindelin wrote:
> That is correct, but --ignore-if-in-upstream actually tests the hash of 
> the _diff_, not of the commit. So, if c really introduces the same change 
> as f (i.e. the diffs are identical), git-rebase will ignore f:
>
> a---b---c---d
>              \
>               e'---g'
>
> Totally untested, of course. But this is what --ignore-if-in-upstream was 
> written for.
>   

Okay, great, that is certainly an improvement over what I thought was 
happening. But it won't work if you had to manually resolve a conflict 
during the rebase, yes? In that case the diffs would presumably not match.

-Steve
