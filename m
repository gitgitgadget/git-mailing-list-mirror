From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] [RFC] Design for pathname encoding gitattribute
 [RESEND]
Date: Tue, 22 Jan 2008 05:35:40 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801220527550.5731@racer.site>
References: <20080122050215.DE198200A2@wilber.wgtn.cat-it.co.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Tue Jan 22 06:36:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHBnz-0005Jx-A2
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 06:36:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbYAVFfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 00:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbYAVFfp
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 00:35:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:58283 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751002AbYAVFfo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 00:35:44 -0500
Received: (qmail invoked by alias); 22 Jan 2008 05:35:42 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp007) with SMTP; 22 Jan 2008 06:35:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18tywZH5eot46Za/FjrfvXfbfMaWoiSHf4M1di6Fr
	Dd4DpcxtbGxg6N
X-X-Sender: gene099@racer.site
In-Reply-To: <20080122050215.DE198200A2@wilber.wgtn.cat-it.co.nz>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71419>

Hi,

On Tue, 22 Jan 2008, Sam Vilain wrote:

>  Documentation/gitattributes.txt |   19 +++++++++++++++++++

As I said on IRC already, I don't think that this is served well as an 
"attribute"... it is most likely that the issue either affects _all_ 
filenames , or _none_.

In that, it is very similar to the CR/LF issue we encountered.  There 
also, it depends more on the platform than on the filename if you want to 
enable special handling or not.

I maintain that it is even more obviously a platform issue than CR/LF, 
since the UTF-8 normalisation takes place in the filesystem driver -- 
regardless if it is needed, or wished for, or not -- whereas CR/LF might 
be not needed/wished for in one certain project, but might well be wished 
for in another clone _on the same platform_.

So I think that this would be a prime candidate for /etc/gitconfig, even 
more so than core.crlf.

Ciao,
Dscho
