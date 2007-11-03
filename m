From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git reset -- path weirdness
Date: Sat, 3 Nov 2007 12:03:03 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711031202380.4362@racer.site>
References: <20071103111743.GA29358@atjola.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, jasampler@gmail.com, gitster@pobox.com
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 03 13:04:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoHjS-00034W-29
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 13:04:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266AbXKCMDv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 08:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753254AbXKCMDv
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 08:03:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:37494 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753257AbXKCMDv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 08:03:51 -0400
Received: (qmail invoked by alias); 03 Nov 2007 12:03:49 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp003) with SMTP; 03 Nov 2007 13:03:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ksgUuiMckurtGUyp2arYPlU08eGFSc+jQocvQVJ
	4MK4VGYbmYFQ34
X-X-Sender: gene099@racer.site
In-Reply-To: <20071103111743.GA29358@atjola.homenet>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63243>

Hi,

On Sat, 3 Nov 2007, Bj?rn Steinbrink wrote:

> I noticed some weirdness with git reset when a path is given. Basically 
> it seems to cycle the file through 3 states: unstaged, unmerged, 
> deleted(!) which is IMHO weird at best. A bisection showed that the 
> behaviour was introduced with the shell -> conversion of git-reset.

Indeed.  I'm on it.

Ciao,
Dscho
