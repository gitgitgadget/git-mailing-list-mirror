From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Move couple of ifdefs after "include config.mk"
Date: Thu, 1 Dec 2005 10:53:09 +0100
Message-ID: <81b0412b0512010153t3f768a82m8f9a12effa4a715e@mail.gmail.com>
References: <20051201012333.44bd81f2.tihirvon@gmail.com>
	 <Pine.LNX.4.63.0512010144050.11941@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20051201033201.02b47071.tihirvon@gmail.com>
	 <7vhd9tmw1g.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0512010906400.22709@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vmzjlkx2f.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0512010140m1b96db84x70c7d92f8f644a2a@mail.gmail.com>
	 <7viru9jgku.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 10:55:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ehl7r-0007xb-H8
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 10:53:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbVLAJxM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 04:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbVLAJxM
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 04:53:12 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:46824 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932126AbVLAJxL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 1 Dec 2005 04:53:11 -0500
Received: by nproxy.gmail.com with SMTP id x4so67101nfb
        for <git@vger.kernel.org>; Thu, 01 Dec 2005 01:53:10 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AljTPjvVpthpBgepqLG0NoX06WO5CI4KvdmuNHAmnjhWoytH86BF0HWCY1yzjqDuMlWAWRfN0yh/ZSzTunvlAGyGsRKM6bJ3HgMriptp5Rp4mcUu7tSTVUHmYKmeJXkDgu+ogiqFi2QjQUxpL8L0ej0e8ENoDWoXJF0RroCNdKA=
Received: by 10.48.223.6 with SMTP id v6mr203992nfg;
        Thu, 01 Dec 2005 01:53:09 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Thu, 1 Dec 2005 01:53:09 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7viru9jgku.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13047>

On 12/1/05, Junio C Hamano <junkio@cox.net> wrote:
> > I have even my specific targets in the config.mak (and would actually
> > like to have the default target put before including config.mak, so
> > default call to make is always the same).
>
> Surely you can do that by having your own "makefile" and include
> "Makefile" I ship, and run "make", which prefers makefile over
> Makefile ;-).

But that is not the same:
 - I can put my targets and variables either before or after Makefile,
not somewhere inbetween
 - I have to work on an especially brain-damaged filesystems, like FAT
