X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Restore a single file in the index back to HEAD
Date: Fri, 27 Oct 2006 09:01:22 +0100
Message-ID: <200610270901.25091.andyparkins@gmail.com>
References: <200610261641.11239.andyparkins@gmail.com> <200610270827.17659.andyparkins@gmail.com> <20061027073834.GC29057@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 27 Oct 2006 08:02:45 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=W/RWB8PXWdrNlr9v4CvwGss0imzFIfX7Pyox2//ZUVJzVwJ68VMdEu6Gp4w8591aFxqg+byr9hy5kpmwck6zqBxpuM5Tm8kaZPpVz/D1ukenUROGnCiY7S3QEXEFdlzwiYIhUWkNQB+iQXlICCqzF4EoQ/m810BBdn102g9Ting=
User-Agent: KMail/1.9.5
In-Reply-To: <20061027073834.GC29057@spearce.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30302>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdMfY-0006G3-O3 for gcvg-git@gmane.org; Fri, 27 Oct
 2006 10:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946236AbWJ0IBb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 04:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946235AbWJ0IBb
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 04:01:31 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:35577 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1946236AbWJ0IBa
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 04:01:30 -0400
Received: by ug-out-1314.google.com with SMTP id 32so619391ugm for
 <git@vger.kernel.org>; Fri, 27 Oct 2006 01:01:29 -0700 (PDT)
Received: by 10.66.224.19 with SMTP id w19mr4497775ugg; Fri, 27 Oct 2006
 01:01:29 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id x33sm182359ugc.2006.10.27.01.01.28; Fri, 27 Oct 2006 01:01:29 -0700
 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 2006 October 27 08:38, Shawn Pearce wrote:

>     git ls-tree HEAD oops/file1 | git update-index --index-info
>     git ls-tree -r HEAD | git update-index --index-info

Absolute gold.  Exactly what I wanted.  Thanks so much.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
