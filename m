From: =?iso-8859-1?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: Re: [PATCH] Add an option for using any HTTP authentication scheme,
 not only basic
Date: Wed, 15 Apr 2009 00:15:54 +0300 (EEST)
Message-ID: <Pine.LNX.4.64.0904150007130.7479@localhost.localdomain>
References: <Pine.LNX.4.64.0904142350140.7479@localhost.localdomain>
 <alpine.DEB.1.00.0904142307110.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 14 23:17:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ltq0a-0002Y9-9O
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 23:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755010AbZDNVP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 17:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754435AbZDNVP6
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 17:15:58 -0400
Received: from smtp2.abo.fi ([130.232.213.77]:51401 "EHLO smtp2.abo.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754615AbZDNVP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 17:15:57 -0400
Received: from albin.abo.fi (albin.abo.fi [130.232.81.192])
	by smtp2.abo.fi (8.14.3/8.12.9) with ESMTP id n3ELFs6I016391;
	Wed, 15 Apr 2009 00:15:54 +0300
X-X-Sender: mstorsjo@localhost.localdomain
In-Reply-To: <alpine.DEB.1.00.0904142307110.10279@pacific.mpi-cbg.de>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (smtp2.abo.fi [130.232.213.77]); Wed, 15 Apr 2009 00:15:54 +0300 (EEST)
X-Virus-Scanned: by roxy.abo.fi (roxy.abo.fi: Wed Apr 15 00:15:54 2009)
X-Scanned-By: MIMEDefang 2.67 on 130.232.213.77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116576>

Hi,

On Tue, 14 Apr 2009, Johannes Schindelin wrote:

> In six months from now, it might be easier to read
> 
> #if LIBCURL_VERSION_NUM >= 0x070a06
> #define LIBCURL_CAN_HANDLE_ANY_AUTH
> #endif
> 
> [...]
> 
> #ifdef LIBCURL_CAN_HANDLE_ANY_AUTH
> [...]
> 
> Don't you agree?

Yeah, absolutely.

Any comments on the naming of options and env variables? Otherwise, I'll 
resend an updated version soon.

// Martin
