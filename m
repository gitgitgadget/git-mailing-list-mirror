From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 00:35:05 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801170034300.17650@racer.site>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
 <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <BA518A23-FBF8-49BB-BEFB-D9A6BA1E302C@simplicidade.org> <alpine.LFD.1.00.0801161615330.2806@woody.linux-foundation.org>
 <E8E76634-FFEC-426B-B04D-3C2CD3790D5E@simplicidade.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Ballard <kevin@sb.org>,
	Jakub Narebski <jnareb@gmail.com>, Mark Junker <mjscod@web.de>,
	git@vger.kernel.org
To: Pedro Melo <melo@simplicidade.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 01:35:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFIjN-0005pl-K1
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 01:35:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668AbYAQAfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 19:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbYAQAfL
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 19:35:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:53156 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752638AbYAQAfK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 19:35:10 -0500
Received: (qmail invoked by alias); 17 Jan 2008 00:35:08 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp047) with SMTP; 17 Jan 2008 01:35:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18r5Ihry0YrdPEQwDV8G0YiKHovZm5ozLzLTPz33C
	0wEMcAMyz+uhvA
X-X-Sender: gene099@racer.site
In-Reply-To: <E8E76634-FFEC-426B-B04D-3C2CD3790D5E@simplicidade.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70788>

Hi,

On Thu, 17 Jan 2008, Pedro Melo wrote:

> The content of the file is sacred, we both agree on that. We disagree on 
> the filename, because for me it's more important that equal strings, 
> even if encoded to different byte sequences, should be treated as the 
> same file.

Why should the filename be _stored_ normalised?  I agree on the lookup, 
yes, but not the storage.

Hth,
Dscho
