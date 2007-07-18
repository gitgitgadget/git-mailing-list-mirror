From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Implement git commit as a builtin.
Date: Wed, 18 Jul 2007 15:43:38 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0707181540370.22541@xanadu.home>
References: <11847863792344-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_8LE3BdUeBUH+LnyP/7mpaw)"
Cc: git@vger.kernel.org
To: =?iso-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 21:43:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBFR2-00022P-12
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 21:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbXGRTnk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 15:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbXGRTnk
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 15:43:40 -0400
Received: from relais.videotron.ca ([24.201.245.36]:44597 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825AbXGRTnj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 15:43:39 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JLE00L4O44QB260@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 18 Jul 2007 15:43:38 -0400 (EDT)
In-reply-to: <11847863792344-git-send-email-krh@redhat.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52894>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_8LE3BdUeBUH+LnyP/7mpaw)
Content-type: TEXT/PLAIN; charset=iso-8859-15
Content-transfer-encoding: 8BIT

On Wed, 18 Jul 2007, Kristian Høgsberg wrote:

> ---
> Here's another update on the work in progress.  At this point, the C
> version is almost complete, there's only a few issues left (look for
> FIXME in builtin-commit.c).  I've added a commit test case which should
> be split out in a patch on its own, but the good news is that it
> successfully exercises most of the command line options and the C version
> passes.
> 
> My plan for the remainder of the work is still to wrap up the last few
> pieces of functionality and then start taking this big patch apart in a
> number of more manageable pieces.  However, the bulk of this work will
> still be a big patch that removes git-commit.sh and adds builtin-commit
> in one swoop.

Please move git-commit.sh to contrib/examples instead of deleting it.


Nicolas

--Boundary_(ID_8LE3BdUeBUH+LnyP/7mpaw)--
