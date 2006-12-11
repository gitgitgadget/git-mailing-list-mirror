X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Problems with git-svn authors file
Date: Mon, 11 Dec 2006 09:04:52 +0000
Message-ID: <200612110904.54389.andyparkins@gmail.com>
References: <20061210172604.GA18385@hermes.lan.home.vilz.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 09:05:10 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MD5F2U9Hk6bvYACLFwV3iO26pEa+tguLOB/v9wzP59VsfYUTMSj8cnSTETqTpVldrKXh0qQ6gzfQOF0P45r1g8oFZgCM/pxglrk0/qgrKiVHAy4bRZPnepUhAA4qdZlGrb33AfuYbDGJ+I8lprv79GQf1qUal6kCBi8FWsgGqPc=
User-Agent: KMail/1.9.5
In-Reply-To: <20061210172604.GA18385@hermes.lan.home.vilz.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33980>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gth5t-00049T-8E for gcvg-git@gmane.org; Mon, 11 Dec
 2006 10:05:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762669AbWLKJFA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 04:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762674AbWLKJFA
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 04:05:00 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:32666 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1762671AbWLKJE7 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec
 2006 04:04:59 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1266495uga for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 01:04:58 -0800 (PST)
Received: by 10.67.22.14 with SMTP id z14mr3225741ugi.1165827898119; Mon, 11
 Dec 2006 01:04:58 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id y1sm5336250uge.2006.12.11.01.04.57; Mon, 11 Dec 2006 01:04:57 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Sunday 2006 December 10 17:26, Nicolas Vilz wrote:

> Use of uninitialized value in hash element at /usr/bin/git-svn line
> 2952.
> Use of uninitialized value in concatenation (.) or string at
> /usr/bin/git-svn line 2953.
> Author:  not defined in .git/info/svn-authors file
> 512 at /usr/bin/git-svn line 457
>         main::fetch_lib() called at /usr/bin/git-svn line 328
>         main::fetch() called at /usr/bin/git-svn line 187

I've had errors like this.  For certain repositories (possibly very old ones) 
there is an unusual, empty, revision 0.  I got around the problem by telling 
git-svn to start at revision 1.  Everything seemed fine after that.

$ git-svn fetch -r1

I don't know if that will be your fix, but it's worth a try.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
