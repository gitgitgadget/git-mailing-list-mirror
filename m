From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make 'make' quieter while building git
Date: Wed, 7 Mar 2007 00:11:30 +0100
Message-ID: <81b0412b0703061511j30683d14h584275b993d40e1c@mail.gmail.com>
References: <20070306063501.GA24355@spearce.org>
	 <81b0412b0703060116m166e2da7saeab82c67536558e@mail.gmail.com>
	 <Pine.LNX.4.63.0703061422580.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0703060537u5140a034s91b35f0d842843a3@mail.gmail.com>
	 <Pine.LNX.4.63.0703061518250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vejo2nffj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 00:11:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOioh-0007Ee-Ql
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 00:11:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030636AbXCFXLd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 18:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030656AbXCFXLd
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 18:11:33 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:47209 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030636AbXCFXLc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 18:11:32 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2659191nfa
        for <git@vger.kernel.org>; Tue, 06 Mar 2007 15:11:30 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b3tPhpsSuLtRHD+2tDh8iqG7kgMjZpioeT4YNuGq2rv5lt/HmgiR2P9ak60rC6+ag+5FKob0YfOKxEgvzQ3CwpQmBHXEvS2XhVklAdVfJokOeqKCtyoRymlNNw0BTl8v1aal+vMN1HIIXjMogY9g6Demtexg9BP/G5J2EPTMl+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GANPQ+dFDRYlrhYl9jfhoRU650iLXpt0T/h+n+NjBa7u+VeB0x7bWmwuKSIvL2lb1vCJGnvK2K+GGt2tIVIZiSBHykssoIzknnelUHDfrGlefT8o7xB8d08uUhwXW8Vn0kFR76Fo9BPNYJZ7VPEzS6UGqqyksOFLE7MAOp8GMqU=
Received: by 10.78.204.20 with SMTP id b20mr875045hug.1173222690145;
        Tue, 06 Mar 2007 15:11:30 -0800 (PST)
Received: by 10.78.138.5 with HTTP; Tue, 6 Mar 2007 15:11:30 -0800 (PST)
In-Reply-To: <7vejo2nffj.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41612>

On 3/7/07, Junio C Hamano <junkio@cox.net> wrote:
> But doesn't "CC foo.o" look just simply WRONG?  We compile foo.c
> to produce foo.o.  An alternative that I could slightly more
> sympathize with would be something like this:

not if you compiled kernels. Doesn't it look wrong to
output information you already have, if you need to?
