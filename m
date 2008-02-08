From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Fri, 8 Feb 2008 23:50:24 +0100
Organization: glandium.org
Message-ID: <20080208225024.GA26975@glandium.org>
References: <200802081828.43849.kendy@suse.cz> <alpine.LSU.1.00.0802081905580.11591@racer.site> <foihu9$110$1@ger.gmane.org> <alpine.LSU.1.00.0802082151570.11591@racer.site> <20080208220356.GA22064@glandium.org> <alpine.LSU.1.00.0802082234170.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 08 23:50:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNc3F-00022U-Iy
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 23:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161AbYBHWt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 17:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754156AbYBHWt4
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 17:49:56 -0500
Received: from vuizook.err.no ([85.19.215.103]:50328 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752353AbYBHWtz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 17:49:55 -0500
Received: from aputeaux-153-1-42-109.w82-124.abo.wanadoo.fr ([82.124.6.109] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JNc3T-00009u-VO; Fri, 08 Feb 2008 23:50:54 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JNc36-00072q-Uy; Fri, 08 Feb 2008 23:50:24 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802082234170.11591@racer.site>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73167>

On Fri, Feb 08, 2008 at 10:34:55PM +0000, Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 8 Feb 2008, Mike Hommey wrote:
> 
> > Also note that the http transport uses info/http-alternates for http:// 
> > urls. By the way, it doesn't make much sense that only http-fetch uses 
> > it.
> 
> I think it does make sense: nobody else needs http-alternates.

If you're setting an http-alternate, it means objects are missing in the
repo. If they are missing in the repo and are not in alternates, how can 
any other command needing objects out there work on the repo ?

Mike
