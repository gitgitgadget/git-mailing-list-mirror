X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: git and bzr
Date: Thu, 30 Nov 2006 16:01:27 +0700
Message-ID: <fcaeb9bf0611300101s51a53b75lc7e771b067ba6e33@mail.gmail.com>
References: <45357CC3.4040507@utoronto.ca>
	 <Pine.LNX.4.64.0611281346490.4244@woody.osdl.org>
	 <456CB197.2030201@onlinehome.de>
	 <Pine.LNX.4.64.0611281413310.4244@woody.osdl.org>
	 <Pine.LNX.4.63.0611291149440.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0611290922410.3513@woody.osdl.org>
	 <456DD76C.4010902@gmx.net>
	 <Pine.LNX.4.64.0611291235590.3513@woody.osdl.org>
	 <87bqmpvlxf.wl%cworth@cworth.org> <456E8147.9070304@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 09:01:43 +0000 (UTC)
Cc: "Carl Worth" <cworth@cworth.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IArhHB9fySZngodH2KFz8ljXbtArDUbve8ytaQEQa9OQU5y3/jqrwZc3ArqDPoNaNiVnlhkgEiwf8bffV/Uf1PQAalxNKNXHIWqqGAIzRnIr2Usw39gIFdcILSTR6dGYAlD8CyQD+dlB94xO8rkaSoUU18eUgV3LP454pIexTvE=
In-Reply-To: <456E8147.9070304@gmx.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32710>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GphnT-000053-VP for gcvg-git@gmane.org; Thu, 30 Nov
 2006 10:01:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759185AbWK3JB3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 04:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759186AbWK3JB3
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 04:01:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:21296 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1759185AbWK3JB3
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 04:01:29 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2047822uga for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 01:01:27 -0800 (PST)
Received: by 10.78.171.13 with SMTP id t13mr3300830hue.1164877287549; Thu, 30
 Nov 2006 01:01:27 -0800 (PST)
Received: by 10.78.100.8 with HTTP; Thu, 30 Nov 2006 01:01:27 -0800 (PST)
To: "Raimund Bauer" <ray007@gmx.net>
Sender: git-owner@vger.kernel.org

On 11/30/06, Raimund Bauer <ray007@gmx.net> wrote:
> * Carl Worth wrote, On 30.11.2006 01:05:
> > Let's help people do exactly that by making the behavior of "git
> > commit -a" be the default for "git commit".
> >
> Maybe we could do that _only_ if the index matches HEAD, and otherwise
> keep current behavior?

I hate the if clause. Suppose I prefer update-index way, I would have
to check whether HEAD matches index everytime I do a commit to make
sure it won't do the other way.
Either -a or -i is the default, not if please.

By the way I do use the update-index way, but vote -a by default. I
don't mind adding " -i" after every commit commands.
-- 
