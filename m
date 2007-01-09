From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Bug in git-status with non-ascii characters:
Date: Tue, 9 Jan 2007 00:35:55 -0500
Message-ID: <0F18E523-350A-48F5-AD7C-A1B3C21A3B56@silverinsanity.com>
References: <7BACA5DE-9DBA-4299-A965-E248263E27E2@silverinsanity.com> <20070109052832.GA2371@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 09 06:36:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H49eT-0001HA-Nk
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 06:36:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbXAIFf6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 00:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbXAIFf6
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 00:35:58 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:59762 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbXAIFf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 00:35:58 -0500
Received: from [192.168.1.5] (cpe-66-67-221-135.rochester.res.rr.com [66.67.221.135])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 1FC451FFD296;
	Tue,  9 Jan 2007 05:35:58 +0000 (UTC)
In-Reply-To: <20070109052832.GA2371@spearce.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36313>


On Jan 9, 2007, at 12:28 AM, Shawn O. Pearce wrote:

> There's a bug in the Mac OS X filesystem apparently.
>
> Git created the file with one encoding.  Later when Git does a
> readdir() to find out what files are in the directory Mac OS X is
> returning it with a different encoding.  There's more details in
> the list archives; all I know is Mac OS X is broken here.  And we
> Mac users get to suffer...

D'oh.  RTFL?  I should have known better minds than I had looked at  
this already.

> P.S. I'm also a Mac OS X user.  I've gotten used to that file
> showing up and just visually ignore it now.  *sigh*

I'm pretty used to it showing up, I was just poking around git (see  
recent patches) and thought about tracking it down.

~~ Brian
