From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: git reset --hard include/linux/config.h
Date: Wed, 5 Jul 2006 19:14:06 +0200
Message-ID: <20060705171406.GA17834@mars.ravnborg.org>
References: <20060705165801.GA11822@mars.ravnborg.org> <81b0412b0607051005s59315296tfb68345959a14c1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 05 19:14:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyAx5-0007QW-Nm
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 19:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbWGERON (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Jul 2006 13:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbWGEROM
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Jul 2006 13:14:12 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:28109 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S964908AbWGEROL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Jul 2006 13:14:11 -0400
Received: from mars.ravnborg.org (0x535d98d8.hrnxx9.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtp.tele.dk (Postfix) with ESMTP id 54FAFE308D2;
	Wed,  5 Jul 2006 19:14:06 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id ACE9B43C01E; Wed,  5 Jul 2006 19:14:06 +0200 (CEST)
To: Alex Riesen <raa.lkml@gmail.com>
Content-Disposition: inline
In-Reply-To: <81b0412b0607051005s59315296tfb68345959a14c1b@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23358>

On Wed, Jul 05, 2006 at 07:05:27PM +0200, Alex Riesen wrote:
> On 7/5/06, Sam Ravnborg <sam@ravnborg.org> wrote:
> >Also what is the right command to bring back a file to the original
> >state after doing some modifications that was not needed anyway?
> 
> git checkout HEAD include/linux/config.h

Thanks!

By the way - the modifications to include/linux/config.h was not lost.
But git apperantly managed to be fooled to think the file was
up-to-date.

	Sam
