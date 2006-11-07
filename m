X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: win2k/cygwin cannot handle even moderately sized packs
Date: Tue, 7 Nov 2006 18:28:00 +0100
Message-ID: <81b0412b0611070928l7be83e08kbfc9657937fe7c92@mail.gmail.com>
References: <81b0412b0611070302h50541cd5mf0758afe0d6befda@mail.gmail.com>
	 <45507965.3010806@peralex.com>
	 <81b0412b0611070555u1833cc8ci1d37d45782562df8@mail.gmail.com>
	 <eiq9vm$l7c$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 7 Nov 2006 17:28:21 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LwbvoD3JSBy579ATM+ySD7BDW8G53mdKZI9OLlSZXvieuMPACaflirQx1DZL4FDubcn2nUPJYElCx8lPl9Dk1Ck9SM9MNDOI/YnUONPJ08FRdVrGQBBhz5sgUUml/LSSBB7FX92XhBiWobWt3AEXfAy/xo6/+zU/LgUrWpbZVmE=
In-Reply-To: <eiq9vm$l7c$1@sea.gmane.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31080>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhUk4-0003PE-NA for gcvg-git@gmane.org; Tue, 07 Nov
 2006 18:28:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965592AbWKGR2F (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 12:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965594AbWKGR2F
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 12:28:05 -0500
Received: from wr-out-0506.google.com ([64.233.184.235]:46476 "EHLO
 wr-out-0506.google.com") by vger.kernel.org with ESMTP id S965592AbWKGR2C
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 12:28:02 -0500
Received: by wr-out-0506.google.com with SMTP id i7so320118wra for
 <git@vger.kernel.org>; Tue, 07 Nov 2006 09:28:02 -0800 (PST)
Received: by 10.78.138.6 with SMTP id l6mr5181245hud.1162920480987; Tue, 07
 Nov 2006 09:28:00 -0800 (PST)
Received: by 10.78.128.2 with HTTP; Tue, 7 Nov 2006 09:28:00 -0800 (PST)
To: "Jakub Narebski" <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

> Perhaps planned mmapping only parts of packs would help there.

