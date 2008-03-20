From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: strange git delays
Date: Thu, 20 Mar 2008 15:19:29 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803201518520.4124@racer.site>
References: <1206019968.27619.26.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: James Utter <james.utter@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 15:20:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcLct-0007aA-QC
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 15:20:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755859AbYCTOTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 10:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755751AbYCTOTa
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 10:19:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:53914 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755316AbYCTOTa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 10:19:30 -0400
Received: (qmail invoked by alias); 20 Mar 2008 14:19:27 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp006) with SMTP; 20 Mar 2008 15:19:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Z0p1OD1HZpmFzFoczuASzxkaDrsPjQcxK+0gnyO
	uvX7Z95wlnpRUT
X-X-Sender: gene099@racer.site
In-Reply-To: <1206019968.27619.26.camel@localhost>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77660>

Hi,

On Fri, 21 Mar 2008, James Utter wrote:

> james@timesink:~/testgit$ time git commit --message "initial commit"
> Created initial commit 4f4b3a3: initial commit
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 hello
> 
> real	0m10.008s
> user	0m0.000s
> sys	0m0.008s

I'd try to oprofile it to know what is taking so long.

Hth,
Dscho
