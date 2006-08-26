From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH 19/19] gitweb: Remove creating directory for temporary files
Date: Sat, 26 Aug 2006 06:44:44 +0200
Message-ID: <e5bfff550608252144p2d234a7cnf2ca2922c98d921b@mail.gmail.com>
References: <200608240015.15071.jnareb@gmail.com>
	 <200608252135.27894.jnareb@gmail.com>
	 <e5bfff550608251433o36713ee1na5544992320b5845@mail.gmail.com>
	 <7vveog45ff.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 26 06:45:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGq2W-0008Cn-Mc
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 06:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWHZEop (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 00:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWHZEop
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 00:44:45 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:38259 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932338AbWHZEoo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Aug 2006 00:44:44 -0400
Received: by py-out-1112.google.com with SMTP id n25so1531253pyg
        for <git@vger.kernel.org>; Fri, 25 Aug 2006 21:44:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aum/1LRB6gkRfJzrsbIxtWAZJ0RmGr1yHF9BnBVH4A1p67MyCn7IR+aHO1+69UCO9/9FUz8B9YaKMg501LF8Tt3qu5G5QYdVIgHnvGfpdHJF/Ow6CJL0nb9LgjX+EVwTegjpTE39HEdpTVAqzON3KUVNeM59RbDtRbLUKbl+XBs=
Received: by 10.35.94.2 with SMTP id w2mr6666039pyl;
        Fri, 25 Aug 2006 21:44:44 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Fri, 25 Aug 2006 21:44:44 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vveog45ff.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26028>

> > - Original code lines, ie. imported at the beginning and never
> > modified, perhaps it is better to view without commit number, this
> > could obfuscate the view and in any case is not an accurate info
> > because the line was not modified during initial patch.
>
> That holds only true for very young projects, or ones that were
> perfect from the beginning and did not see much action ;-).
>

Or also for projects like Linux ;-)

See blame output of something like kernel/dma.c or also kernel/exit.c,
not exactly the most unknown files around.
