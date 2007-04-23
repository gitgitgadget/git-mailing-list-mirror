From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git rev-list --boundary from..to
Date: Mon, 23 Apr 2007 16:25:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704231624400.8822@racer.site>
References: <8aa486160704230634m130d1877k9e965847a2029751@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-487519388-1177338332=:8822"
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 16:26:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfzUW-0001Sf-Sy
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 16:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbXDWO0G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 10:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753153AbXDWO0F
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 10:26:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:34062 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751049AbXDWO0D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 10:26:03 -0400
Received: (qmail invoked by alias); 23 Apr 2007 14:26:01 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp050) with SMTP; 23 Apr 2007 16:26:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+x5ek77CixWXGh5nvxhuQ13fhplCX01Nz1WUs7bY
	PROzKoWgQYTMh1
X-X-Sender: gene099@racer.site
In-Reply-To: <8aa486160704230634m130d1877k9e965847a2029751@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45325>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-487519388-1177338332=:8822
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 23 Apr 2007, Santi Béjar wrote:

>  git rev-list ${order} --boundary ${commitlimit}
> 
>  is what is used in gitk. In v1.5.0.3:
> 
>  $ gitk from..to
> 
> shows the boundary commits next to the child, but it is no longer the
> case since v1.5.0.3-290-g86ab490.
>
>  Now all the boundary commits are at the bottom.
> 
>  While at it, when used with --max-count they are at the bottom too,
> and I understand why, but is there a way to tell "show me the boundary
> commits next to the child even if it means it takes more time"?

I'd say "--parents", and infer the relevant information. While I agree 
that it was nicer to scripts earlier, IMHO it was incorrect, too.

Hth,
Dscho

--8323584-487519388-1177338332=:8822--
