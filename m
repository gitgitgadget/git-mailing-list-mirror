From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH 4/4] upload-pack/fetch-pack: support side-band
	communication
Date: Thu, 22 Jun 2006 11:22:14 -0500
Message-ID: <1150993333.9022.51.camel@cashmere.sps.mot.com>
References: <7vsllyzs9w.fsf@assigned-by-dhcp.cox.net>
	 <7vpsh2xcv1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 22 18:23:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtRxV-0006Ug-Mc
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 18:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbWFVQXH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 12:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751826AbWFVQXG
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 12:23:06 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:22928 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1751834AbWFVQXF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 12:23:05 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id k5MGMnSN000979;
	Thu, 22 Jun 2006 09:22:49 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k5MGMmOo009484;
	Thu, 22 Jun 2006 11:22:48 -0500 (CDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsh2xcv1.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22346>

On Wed, 2006-06-21 at 19:17, Junio C Hamano wrote:
> >    Somehow this does not work when connecting to git daemon that
> >    runs under inetd.  Fixes appreciated.
> 
> This seems to fix it.

> -		fclose(stderr); //FIXME: workaround
> +		freopen("/dev/null", "w", stderr);
>  

Sweet.  Thanks!

jdl
