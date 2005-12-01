From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Move couple of ifdefs after "include config.mk"
Date: Thu, 1 Dec 2005 13:51:33 +0100
Message-ID: <81b0412b0512010451q14e2e833o86f59399ba83188b@mail.gmail.com>
References: <20051201012333.44bd81f2.tihirvon@gmail.com>
	 <Pine.LNX.4.63.0512010144050.11941@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20051201033201.02b47071.tihirvon@gmail.com>
	 <7vhd9tmw1g.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0512010906400.22709@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vmzjlkx2f.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0512010140m1b96db84x70c7d92f8f644a2a@mail.gmail.com>
	 <7viru9jgku.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0512010153t3f768a82m8f9a12effa4a715e@mail.gmail.com>
	 <7v7japjf53.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 13:52:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ehnuq-0006yX-Ta
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 13:52:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbVLAMvf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 07:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbVLAMvf
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 07:51:35 -0500
Received: from nproxy.gmail.com ([64.233.182.195]:56199 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932201AbVLAMve convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 1 Dec 2005 07:51:34 -0500
Received: by nproxy.gmail.com with SMTP id x4so82510nfb
        for <git@vger.kernel.org>; Thu, 01 Dec 2005 04:51:33 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RIJ6WmWP7zPej/EDrolSrvTAAPdPri2j5wiy+JB0HYJ+Fzl9Mj7982dCRr22rEQY//nuzqZUGTgNkaqMcq2xH0979a5V7GOcBLSXazGhKHn+akYkRbaiLtY7fd+HWHmFzoXJc/R/C3vxVDYJcAhp7llAhxidffAP8R2XXqcHXss=
Received: by 10.48.230.17 with SMTP id c17mr258107nfh;
        Thu, 01 Dec 2005 04:51:33 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Thu, 1 Dec 2005 04:51:33 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7japjf53.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13053>

On 12/1/05, Junio C Hamano <junkio@cox.net> wrote:
> Alex Riesen <raa.lkml@gmail.com> writes:
>
> > On 12/1/05, Junio C Hamano <junkio@cox.net> wrote:
> >> > I have even my specific targets in the config.mak (and would actually
> >> > like to have the default target put before including config.mak, so
> >> > default call to make is always the same).
>
> Hmph.  Do you mean something like this?
>
> -- >8 --
> diff --git a/Makefile b/Makefile
> index 00521fe..45db357 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,3 +1,6 @@
> +# The default target of this Makefile is...
> +all:
> +

Yes. In fact, that is what I have in my tree :)
