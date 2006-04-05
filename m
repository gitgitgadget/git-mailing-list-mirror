From: Nicolas Pitre <nico@cam.org>
Subject: Re: How should I handle binary file with GIT
Date: Wed, 05 Apr 2006 09:25:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604050906590.2550@localhost.localdomain>
References: <20060405122113.60376.qmail@web25801.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_vMXXSsRgGtrSOYJQ73jz4Q)"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 05 15:25:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FR813-0001rR-UY
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 15:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWDENZn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 09:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWDENZn
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 09:25:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:62077 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751115AbWDENZn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Apr 2006 09:25:43 -0400
Received: from xanadu.home ([74.56.105.38]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IX900LVK3YUT380@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 05 Apr 2006 09:25:42 -0400 (EDT)
In-reply-to: <20060405122113.60376.qmail@web25801.mail.ukl.yahoo.com>
X-X-Sender: nico@localhost.localdomain
To: moreau francis <francis_moreau2000@yahoo.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18431>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_vMXXSsRgGtrSOYJQ73jz4Q)
Content-type: TEXT/PLAIN; charset=iso-8859-1
Content-transfer-encoding: 8BIT

On Wed, 5 Apr 2006, moreau francis wrote:

> 
> --- Junio C Hamano <junkio@cox.net> a écrit :
> 
> > It _might_ make sense to adopt a well-defined binary patch
> > format (or if there is no prior art, introduce our own) and
> > support that format with both git-diff-* brothers and git-apply,
> > but that would be a bit longer term project.
> > 
> 
> well maybe it's just stupid, but why not simply transforming binary files into
> ascii files (maybe by using uuencode) before  using git-diff-* brothers and
> git-apply ?

Imagine if the only difference between two versions of the same file is 
a single byte inserted at the very beginning.  The uuencode would then 
be totally different between the two files.


Nicolas

--Boundary_(ID_vMXXSsRgGtrSOYJQ73jz4Q)--
