From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: A tour of git: the basics (and notes on some unfriendly messages)
Date: Sat, 29 Sep 2007 09:44:56 +0200
Message-ID: <4D958F04-D531-416A-9FB4-E4119BEC6905@zib.de>
References: <87ir5us82a.wl%cworth@cworth.org> <20070929000056.GZ3099@spearce.org> <Pine.LNX.4.64.0709290144310.28395@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Carl Worth <cworth@cworth.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Sep 29 09:43:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbWz9-0006av-Vu
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 09:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059AbXI2Hn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 03:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752729AbXI2Hn3
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 03:43:29 -0400
Received: from mailer.zib.de ([130.73.108.11]:52122 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751794AbXI2Hn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 03:43:28 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l8T7hLn6000013;
	Sat, 29 Sep 2007 09:43:21 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db1a918.pool.einsundeins.de [77.177.169.24])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l8T7hKGK021602
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 29 Sep 2007 09:43:21 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0709290144310.28395@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59445>


On Sep 29, 2007, at 2:49 AM, Johannes Schindelin wrote:

>
> On Fri, 28 Sep 2007, Shawn O. Pearce wrote:
>
>> On Cygwin we have man, so `git help init` (or `git init --help`) work
>> just fine to display the manual entry.  No idea about the MSYS port.
>
> We open the html pages.  That is, we don't yet, since we do not  
> generate
> the html pages just yet; asciidoc is a Python program, and Python  
> is not
> available as an MSys program as far as I know (and asciidoc insists on
> finding files in a Unix-like file structure, so we _do_ need an MSys
> Python).
>

I propose to clone the html pages from git.git's html branch and
include them in the installer. I continue to believe that this is
the simplest and fastest solution for providing html pages.

I'll provide a patch (hopefully next week).

	Steffen
