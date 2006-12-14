X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git-fetching from a big repository is slow
Date: Thu, 14 Dec 2006 15:18:04 +0000
Message-ID: <200612141518.05770.andyparkins@gmail.com>
References: <200612141340.43925.andyparkins@gmail.com> <4581573E.40803@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 15:18:29 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=lPlMNrsZBDpSz/o+3uKmSpbkDUtClkzaDTMfZCA09G5rGj6MCpaOi53ksUjBCBaupFdVyyvFx6L+bwlbjPEgyTRv9sQdXa38Y3vi4sfos8svoI9Aw4TwKGZ8+6eutwnrZe4cPlM9GAUjxnNh+njgceY9Vcj4j/N9Im+Qw4sPV5s=
User-Agent: KMail/1.9.5
In-Reply-To: <4581573E.40803@op5.se>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34346>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GusLp-0003pU-Ce for gcvg-git@gmane.org; Thu, 14 Dec
 2006 16:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932802AbWLNPSP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 10:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932804AbWLNPSP
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 10:18:15 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:50308 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932802AbWLNPSN (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 10:18:13 -0500
Received: by ug-out-1314.google.com with SMTP id 44so526711uga for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 07:18:12 -0800 (PST)
Received: by 10.66.255.7 with SMTP id c7mr1600466ugi.1166109490003; Thu, 14
 Dec 2006 07:18:10 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 34sm2170428uga.2006.12.14.07.18.09; Thu, 14 Dec 2006 07:18:09 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 2006 December 14 13:53, Andreas Ericsson wrote:

> This seems to happen if your repository consists of many large binary
> files, especially many large binary files of several versions that do
> not deltify well against each other. Perhaps it's worth adding gzip

It's actually just every released patch to the linux kernel ever issued.  
Almost entirely ASCII and every revision (save the first) created by patching 
the previous.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
