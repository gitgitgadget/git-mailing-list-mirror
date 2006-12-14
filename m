X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: svn versus git
Date: Thu, 14 Dec 2006 23:32:57 +0700
Message-ID: <fcaeb9bf0612140832v1c80bf7dgd61897111292d31@mail.gmail.com>
References: <200612132200.41420.andyparkins@gmail.com>
	 <20061213225627.GC32568@spearce.org>
	 <200612140908.36952.andyparkins@gmail.com>
	 <7vodq695ha.fsf@assigned-by-dhcp.cox.net>
	 <fcaeb9bf0612140708w6bc691f6k2e08fbab2a651421@mail.gmail.com>
	 <Pine.LNX.4.63.0612141630240.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 16:33:05 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J+U/eL9crL7K/zHDEZ6zyma+aQof/Be6UbKpOzeKCTM4LtaMdAhWx3gXado6lDvANWYb8sydZhAsKA/aalhMQrJf0NEMAW1qypA6gWAgigJDSIWbUifveEKpwEc4yJ4FXv5E1K0pSLemCo2Cz3f4G4KKKJRP109MR10DfFvudYU=
In-Reply-To: <Pine.LNX.4.63.0612141630240.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34365>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GutW3-0007zX-Hf for gcvg-git@gmane.org; Thu, 14 Dec
 2006 17:33:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932859AbWLNQdA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 11:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932862AbWLNQdA
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 11:33:00 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:40873 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932859AbWLNQc7 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 11:32:59 -0500
Received: by ug-out-1314.google.com with SMTP id 44so547167uga for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 08:32:58 -0800 (PST)
Received: by 10.78.205.7 with SMTP id c7mr815318hug.1166113977795; Thu, 14
 Dec 2006 08:32:57 -0800 (PST)
Received: by 10.78.100.8 with HTTP; Thu, 14 Dec 2006 08:32:57 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Hi,

On 12/14/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Two questions arise naturally:
>
> - what do you need it for?

for being user-friendly and consistent. Git porcelain commands seem to
be grouped by function. So it would be natural to have git-ls as a
front-end for both ls-files and ls-tree. I don't really care about
ls-tree but I do about ls-files to examine index.

> - have you seen the patch for git-show today, which would include this
> functionality?

I didn't. From the patch, it seems git-show can show the index via
::file syntax. If so, I'd like withdraw my opinion. '::file' syntax is
not intuitive though. Perhaps you should mention that it can show
index (and how) in the git-show document
-- 
