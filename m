From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 04/11] Add _MSC_VER predefine macro to make same behaviors
 with __MINGW32__ Enable MSVC build. MSVC have the save behaviors with
 msysgit.
Date: Mon, 17 Aug 2009 18:38:49 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908171835590.4991@intel-tinevez-2-302>
References: <1250524872-5148-1-git-send-email-lznuaa@gmail.com> <1250524872-5148-2-git-send-email-lznuaa@gmail.com> <1250524872-5148-3-git-send-email-lznuaa@gmail.com> <1250524872-5148-4-git-send-email-lznuaa@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 18:39:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md5Ej-0007El-8P
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 18:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757220AbZHQQiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 12:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757196AbZHQQiu
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 12:38:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:34840 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753692AbZHQQiu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 12:38:50 -0400
Received: (qmail invoked by alias); 17 Aug 2009 16:38:50 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp053) with SMTP; 17 Aug 2009 18:38:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ILLVvwR8IkLV2u7avuzeL+0+zSokfs2lrJqoHve
	rKg+eIeQLvlWMm
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1250524872-5148-4-git-send-email-lznuaa@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126224>

Hi,

On Tue, 18 Aug 2009, Frank Li wrote:

> Signed-off-by: Frank Li <lznuaa@gmail.com>

How about

	Test whether WIN32 is defined rather than __MINGW32__

	The code which is conditional on MinGW32 is actually conditional 
	on Windows.  So test WIN32 rather than __MINGW32__.

	This does not break Cygwin builds, as WIN32 is undefined there.

	Suggested by Dmitry Potapov

?

Of course, you have to edit your patch accordingly, then.

And yes, I just tested, WIN32 is indeed defined on MinGw32.

Ciao,
Dscho
