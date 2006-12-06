X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: git UI nit
Date: Wed, 06 Dec 2006 16:09:27 +0100
Message-ID: <4576DD27.6050307@xs4all.nl>
References: <el6jmt$mej$1@sea.gmane.org> <Pine.LNX.4.63.0612061546190.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 15:09:27 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <Pine.LNX.4.63.0612061546190.28348@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by XS4ALL Virus Scanner
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33468>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GryOh-0008D7-Cz for gcvg-git@gmane.org; Wed, 06 Dec
 2006 16:09:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933843AbWLFPJU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 10:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933640AbWLFPJU
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 10:09:20 -0500
Received: from smtp-vbr8.xs4all.nl ([194.109.24.28]:2128 "EHLO
 smtp-vbr8.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S933843AbWLFPJT (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 10:09:19 -0500
Received: from [192.168.123.187] (muurbloem.xs4all.nl [213.84.26.127])
 (authenticated bits=0) by smtp-vbr8.xs4all.nl (8.13.8/8.13.8) with ESMTP id
 kB6F9GIl028955 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO); Wed, 6 Dec 2006 16:09:16 +0100 (CET) (envelope-from
 hanwen@xs4all.nl)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin escreveu:
>  			}
>  			if (quiet)
>  				continue;
> -			printf("%s: needs update\n", ce->name);
> +			printf("%s: dirty; needs commit\n", ce->name);

Yes - I'd just mention revert as an option too. 
 

-- 
