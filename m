X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 13:20:24 +0000
Message-ID: <200612141320.26729.andyparkins@gmail.com>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <200612141200.42875.andyparkins@gmail.com> <20061214121048.GM1747@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 13:20:39 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=W6GEVIhFyhFIknpwnJXT86lOanQ6Asg0p55oOAVkIZjm+WinYLnvpf0/lXh8ANulslQXpWwhsNu/i2D1FvltncMrCtvExd0+8dXlRQB7od8nvlk3w82NxgPN6UN4EKN4FYdImY2dgRTA4qUtaQz5hYASbRhNGK0H5v5LjyWhtQ8=
User-Agent: KMail/1.9.5
In-Reply-To: <20061214121048.GM1747@spearce.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34332>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuqVo-0002uU-K7 for gcvg-git@gmane.org; Thu, 14 Dec
 2006 14:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932704AbWLNNUd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 08:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932706AbWLNNUd
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 08:20:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:62693 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932704AbWLNNUc (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 08:20:32 -0500
Received: by ug-out-1314.google.com with SMTP id 44so495936uga for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 05:20:31 -0800 (PST)
Received: by 10.67.103.7 with SMTP id f7mr1423876ugm.1166102431306; Thu, 14
 Dec 2006 05:20:31 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 53sm2487460ugn.2006.12.14.05.20.30; Thu, 14 Dec 2006 05:20:30 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 2006 December 14 12:10, Shawn Pearce wrote:

> not predict future results"...  The size of objects in the pack
> tends to be small up front (commits/trees) and larger in the back
> (blobs).  The size distribution probably also gets more erratic
> near the back as the blob sizes may not follow a nice distribution.

Oh well; that pretty much settles it then.

> But as you state, its easy to refine it over time, and the closer we
> get to the end the more likely it is to be correct.  Unless its that
> 23 MiB blob.  As it takes up about 85% of that repository's pack.

I had imagined (foolishly), that most objects would be diffs, and would be 
similarly sized.

Scratch that.

Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
