From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 1/6] diff.c: Remove code redundancy in
 diff_words_show
Date: Sun, 4 May 2008 10:46:51 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805041046040.30431@racer>
References: <1209815828-6548-1-git-send-email-pkufranky@gmail.com> <1209874815-14411-1-git-send-email-pkufranky@gmail.com> <1209874815-14411-2-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 04 11:48:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsaop-0001ce-HN
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 11:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093AbYEDJqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 05:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754092AbYEDJqz
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 05:46:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:56070 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754078AbYEDJqz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 05:46:55 -0400
Received: (qmail invoked by alias); 04 May 2008 09:46:53 -0000
Received: from dslb-088-067-220-031.pools.arcor-ip.net (EHLO dslb-088-067-220-031.pools.arcor-ip.net) [88.67.220.31]
  by mail.gmx.net (mp011) with SMTP; 04 May 2008 11:46:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+uVoNnEHuuRn1xvHaSdgoMqUeDzvrEhlQQ4+4pVw
	PHAEb+i/nMYDyK
X-X-Sender: gene099@racer
In-Reply-To: <1209874815-14411-2-git-send-email-pkufranky@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81158>

Hi,

On Sun, 4 May 2008, Ping Yin wrote:

> Introduce mmfile_copy_set_boundary to do the repeated work.

It the name supposed to be descriptive?  Because it sure is not for me.  
Reading the patch, I know what it should do, but the commit message could 
be a big blank space then, to save me time.

Ciao,
Dscho
