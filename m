From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Embed an application manifest on MinGW
Date: Thu, 2 Jun 2011 16:26:54 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1106021625100.1594@bonsai2>
References: <1307010937-2894-1-git-send-email-cesarb@cesarb.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Cesar Eduardo Barros <cesarb@cesarb.net>
X-From: git-owner@vger.kernel.org Thu Jun 02 16:27:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QS8rX-00015N-FB
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 16:27:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223Ab1FBO06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 10:26:58 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:39528 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750710Ab1FBO06 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 10:26:58 -0400
Received: (qmail invoked by alias); 02 Jun 2011 14:26:55 -0000
Received: from pD9EB253C.dip0.t-ipconnect.de (EHLO noname) [217.235.37.60]
  by mail.gmx.net (mp007) with SMTP; 02 Jun 2011 16:26:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18G1j0gmigGUmIyzAVDNV32ZuaqmIEUcaQauG74cr
	YxuaTmuIOfZSKx
X-X-Sender: gene099@bonsai2
In-Reply-To: <1307010937-2894-1-git-send-email-cesarb@cesarb.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174951>

Dear Cesar,

On Thu, 2 Jun 2011, Cesar Eduardo Barros wrote:

> v2: Create GITLIBDEPS and use it instead of GITLIBS. RESOURCE_OBJS
>     cannot be added directly to GITLIBS because it would add the
>     manifest twice to executables which use $(filter %.o,$^) in the
>     Makefile rule (since LIBS also includes GITLIBS).

This is still changing too much for my liking (and if I were to accept 
the introduction of GITLIBDEPS as an elegant solution, it would have to be 
a separate patch anyway).

I may get some time in a week to play with the issue myself,
Johannes
