X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 11:33:55 +0100
Message-ID: <200611151033.57415.andyparkins@gmail.com>
References: <87k61yt1x2.wl%cworth@cworth.org> <200611150917.23756.andyparkins@gmail.com> <ejeocl$vrj$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 15 Nov 2006 10:34:16 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QFNkep1xywEdmMnR4ZYzDYkThA5S+6k8+MDLcMVbLREAvhtfcN4MFj/boFMWX0G9BBkFUKRrwL33Kx6GMajctXF/MBLxnAXNqc4vWCZnLfXkG2O0PY3sd8qGZ34V9brPjEEkA7+k3zqI8BVp3MgZBKnWnbJJ0zxKHRiOkilTn5E=
User-Agent: KMail/1.9.5
In-Reply-To: <ejeocl$vrj$1@sea.gmane.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31434>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkI5q-0003Nz-9y for gcvg-git@gmane.org; Wed, 15 Nov
 2006 11:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966754AbWKOKeF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 05:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966755AbWKOKeF
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 05:34:05 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:656 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S966754AbWKOKeC
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 05:34:02 -0500
Received: by ug-out-1314.google.com with SMTP id m3so94188ugc for
 <git@vger.kernel.org>; Wed, 15 Nov 2006 02:34:01 -0800 (PST)
Received: by 10.67.30.6 with SMTP id h6mr2633596ugj.1163586841213; Wed, 15
 Nov 2006 02:34:01 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 53sm566286ugd.2006.11.15.02.34.00; Wed, 15 Nov 2006 02:34:01 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 2006 November 15 09:59, Jakub Narebski wrote:

> >  * Don't use the name "origin" twice.  In fact, don't use it at all.  In
> > a distributed system there is no such thing as a true origin.
>
> The remote 'origin' is true origin of the repository: it is repository
> we cloned this repository from.

But that is not necessarily /the/ original, and "origin" is the absolute 
reference in maths.  It doesn't bother me that much I suppose, it's just that 
as far as unambiguous names go, I'm not wild about it - it's got too 
many "central repository" connotations, which is of course anathema to git.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
