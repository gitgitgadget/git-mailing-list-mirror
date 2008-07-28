From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Remove references to git-fetch-pack from "git clone"  
  documentation.
Date: Mon, 28 Jul 2008 14:41:16 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807281440510.2725@eeepc-johanness>
References: <1217011068-1675-1-git-send-email-shaslam@lastminute.com> <alpine.DEB.1.00.0807260523520.26810@eeepc-johanness> <488DBC72.8040204@lastminute.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Steve Haslam <shaslam@lastminute.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 14:41:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNS2I-00024j-NT
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 14:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbYG1MkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 08:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbYG1MkK
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 08:40:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:33529 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752071AbYG1MkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 08:40:09 -0400
Received: (qmail invoked by alias); 28 Jul 2008 12:40:07 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp011) with SMTP; 28 Jul 2008 14:40:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/rQ0RXcj3rY1qaJ8vmQAQKKxfYszk2FVWRJBoW0r
	Nn4silAOmSpXcU
X-X-Sender: user@eeepc-johanness
In-Reply-To: <488DBC72.8040204@lastminute.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90453>

Hi,

On Mon, 28 Jul 2008, Steve Haslam wrote:

> I think that the documentation was perhaps too explicit and as a result 
> stale: git-clone certainly does not work any more by creating a 
> "--exec=..." argument to pass to the git-fetch-pack command even 
> internally, it calls code in transport.c.

Ah, that is a valid concern which I missed.

Thanks,
Dscho
