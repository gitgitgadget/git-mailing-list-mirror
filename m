From: Sam Vilain <sam@vilain.net>
Subject: Re: [mingw port] git plumbing piping with CR/NL
Date: Sat, 02 Jun 2007 13:31:57 +1200
Message-ID: <4660C88D.2010208@vilain.net>
References: <fcaeb9bf0706011123ue4ceaf2i12569c63d1d92584@mail.gmail.com> <20070601231816.GC6360@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 03:32:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuITY-00069a-N1
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 03:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbXFBBcJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 21:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757747AbXFBBcJ
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 21:32:09 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:33110 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594AbXFBBcI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 21:32:08 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id EFA9C13A401; Sat,  2 Jun 2007 13:32:04 +1200 (NZST)
Received: from [192.168.1.5] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 22A2313A384;
	Sat,  2 Jun 2007 13:32:00 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
In-Reply-To: <20070601231816.GC6360@steel.home>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=SPF_HELO_FAIL autolearn=no 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48904>

Alex Riesen wrote:
> > Apparently git should ignore \r at the end of the path. ...
> Why should it? \r is a valid character in filenames almost everywhere
> (except for the some proprietary OSes, as usual).
>   

So is \n!

Sam.
