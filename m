From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Basename matching during rename/copy detection
Date: Thu, 21 Jun 2007 14:18:37 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706211417090.4059@racer.site>
References: <20070621030622.GD8477@spearce.org> <200706211050.03519.andyparkins@gmail.com>
 <Pine.LNX.4.64.0706211252190.4059@racer.site> <200706211344.47560.andyparkins@gmail.com>
 <vpqodj9zcxf.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 21 15:19:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1MZ4-0002Um-LW
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 15:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755086AbXFUNSn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 09:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754592AbXFUNSm
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 09:18:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:48447 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755086AbXFUNSl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 09:18:41 -0400
Received: (qmail invoked by alias); 21 Jun 2007 13:18:39 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp054) with SMTP; 21 Jun 2007 15:18:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ojRpemmko1X+cQ5SuX38k81MPZI7Jej5w/yIV2o
	F4isxl4RCreXsB
X-X-Sender: gene099@racer.site
In-Reply-To: <vpqodj9zcxf.fsf@bauges.imag.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50622>

Hi,

On Thu, 21 Jun 2007, Matthieu Moy wrote:

> Well, why look so far to find an example of people having identical
> files in their tree?
> 
> $ cd git
> $ git-ls-files -z | xargs -0 md5sum | cut -f 1 -d ' ' | wc -l              
> 973
> $ git-ls-files -z | xargs -0 md5sum | cut -f 1 -d ' ' | sort | uniq | wc -l
> 964
> $ 

Have you checked the files? They are all some blobs in the test scripts. 

Ciao,
Dscho
