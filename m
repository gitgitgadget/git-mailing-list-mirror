From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] Build in shortlog
Date: Sun, 22 Oct 2006 10:22:49 -0700
Message-ID: <453BA8E9.8010703@gmail.com>
References: <Pine.LNX.4.63.0610221322370.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Oct 22 19:23:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbh2J-00008v-1C
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 19:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWJVRW4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 13:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWJVRW4
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 13:22:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:57565 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751128AbWJVRWz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 13:22:55 -0400
Received: by ug-out-1314.google.com with SMTP id o38so1077348ugd
        for <git@vger.kernel.org>; Sun, 22 Oct 2006 10:22:54 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=XT5H669k3FjwESHXstGRvVBvuq07BSRlJZz+dYTsHqmlyW9AHPgxpMsfyxqRMeN9di79ke/IMlMFEJXVvVaAu6GBjyLgVvb2lPTNxjcKrXFslgMN3tQT3nHxvKLbi4i0I94Uz1afUr7yZVhSxRhIQGBvOP5sUDt//hKTWicZ/ec=
Received: by 10.78.204.20 with SMTP id b20mr5908935hug;
        Sun, 22 Oct 2006 10:22:53 -0700 (PDT)
Received: from ?10.0.0.6? ( [67.20.71.142])
        by mx.google.com with ESMTP id 35sm798155huc.2006.10.22.10.22.52;
        Sun, 22 Oct 2006 10:22:53 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0610221322370.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29766>

Johannes Schindelin wrote:
[...]
> diff --git a/Makefile b/Makefile
> index 018dad2..0beda57 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -106,7 +106,7 @@ uname_P := $(shell sh -c 'uname -p 2>/de
>  
>  # CFLAGS and LDFLAGS are for the users to override from the command line.
>  
> -CFLAGS = -g -O2 -Wall
> +CFLAGS = -g -O0 -Wall
>  LDFLAGS =
>  ALL_CFLAGS = $(CFLAGS)
>  ALL_LDFLAGS = $(LDFLAGS)
> @@ -178,7 +178,7 @@ SCRIPT_SH = \
[...]

This part of your patch needs some explanation.
