X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Minor documentation problems [RFC PATCH]
Date: Thu, 2 Nov 2006 15:51:06 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611021550060.1670@wbgn013.biozentrum.uni-wuerzburg.de>
References: <vpqmz7a1694.fsf@ecrins.imag.fr> <BAYC1-PASMTP018DA61B5F35F9603DF8A8AEFF0@CEZ.ICE>
 <Pine.LNX.4.63.0611021448100.1670@wbgn013.biozentrum.uni-wuerzburg.de>
 <BAYC1-PASMTP042F05A3C71EDC671552FFAEFF0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 2 Nov 2006 14:53:36 +0000 (UTC)
Cc: git <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <BAYC1-PASMTP042F05A3C71EDC671552FFAEFF0@CEZ.ICE>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30755>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfdv0-0002Co-MN for gcvg-git@gmane.org; Thu, 02 Nov
 2006 15:51:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750877AbWKBOvn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 09:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWKBOvn
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 09:51:43 -0500
Received: from mail.gmx.de ([213.165.64.20]:63619 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1750917AbWKBOvm (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 09:51:42 -0500
Received: (qmail invoked by alias); 02 Nov 2006 14:51:40 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp018) with SMTP; 02 Nov 2006 15:51:40 +0100
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 2 Nov 2006, Sean wrote:

> -		else
> +		else if (!strcmp(argv[1], "--global")) {
> +			char *home = getenv("HOME");
> +			if (home) {
> +				char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
> +				setenv("GIT_CONFIG", user_config, 1);
> +				free(user_config);
> +			} else {
> +				return -1;

Micronit: might be useful to tell the user that she's homeless.

Else: ACK.

Ciao,
Dscho
