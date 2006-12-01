X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH/RFC] Make git-commit cleverer - have it figure out whether it needs -a automatically
Date: Fri, 1 Dec 2006 10:52:47 +0000
Message-ID: <200612011052.48784.andyparkins@gmail.com>
References: <200611301259.32387.andyparkins@gmail.com> <81b0412b0611300914u521a5351idde23618c2fbf017@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 10:53:17 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=sKCIY4UEEWzaKkPPe8TYwkzoAlFoVkXQROybqpOi4JBP2qxG5+5sBQa37TAUk6DOUXKGqe4S6qf6l8nBGXirpXI4vlq7VbsDN6yRU1xA4kRcDI7vQ896Sh9sPeo7FUdweAjisspy5asnjMY+auA1g9H6v9DqDbtdDxlWjBpTq5Q=
User-Agent: KMail/1.9.5
In-Reply-To: <81b0412b0611300914u521a5351idde23618c2fbf017@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32888>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq60o-0007u7-5I for gcvg-git@gmane.org; Fri, 01 Dec
 2006 11:52:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030671AbWLAKwy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 05:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936308AbWLAKwy
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 05:52:54 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:36482 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S936309AbWLAKwx
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 05:52:53 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2386013uga for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 02:52:52 -0800 (PST)
Received: by 10.66.219.11 with SMTP id r11mr7004928ugg.1164970372124; Fri, 01
 Dec 2006 02:52:52 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id l33sm23777076ugc.2006.12.01.02.52.51; Fri, 01 Dec 2006 02:52:51
 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 2006 November 30 17:14, Alex Riesen wrote:

> The is dangerous on filesystems which lie to the programs about file
> metadata. The "virtual filesystem" of cygwin is one of this kind: exec-bit
> of the files depend
> on its contents. Just calling git-commit -a will commit executability
> at this particular
> moment. For whatever reason, disabling handling of the exec-mode in gits
> config does not work.

Surely this is a separate fault?

> If you about to change the behaviour, provide at least a config option
> to go back
> to the old git-commit, which didn't do any magic.

Wasn't the whole point of this to avoid needing another config option?


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
