X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git-show --stat on first commit
Date: Thu, 23 Nov 2006 09:25:06 +0000
Message-ID: <200611230925.07821.andyparkins@gmail.com>
References: <200611211341.48862.andyparkins@gmail.com> <7v64d8y4tu.fsf@assigned-by-dhcp.cox.net> <ejvlv9$781$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 23 Nov 2006 09:25:54 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Qhqk5ivpM0J04pl3mShmHTDjpLiJyOwMvDJuqagqaAGRBVoK4p2xeVvFfbbYfYnYoPhOS90BtenWIpoM66qgck5DdL75m4LI/tOR5GeMvEXtXtz0O6BgV98Rxgk3HLuVAjnRRWGwtQqE9NadM2HM3pI8nEaQZ/D/FcQyLWIX7tA=
User-Agent: KMail/1.9.5
In-Reply-To: <ejvlv9$781$1@sea.gmane.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32126>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnApx-0003WF-V1 for gcvg-git@gmane.org; Thu, 23 Nov
 2006 10:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933415AbWKWJZP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 04:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933424AbWKWJZO
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 04:25:14 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:4188 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S933415AbWKWJZM
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 04:25:12 -0500
Received: by ug-out-1314.google.com with SMTP id 44so387744uga for
 <git@vger.kernel.org>; Thu, 23 Nov 2006 01:25:11 -0800 (PST)
Received: by 10.67.89.5 with SMTP id r5mr4643916ugl.1164273911676; Thu, 23
 Nov 2006 01:25:11 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 59sm12863167ugf.2006.11.23.01.25.10; Thu, 23 Nov 2006 01:25:11 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Tuesday 2006 November 21 20:03, Jakub Narebski wrote:

> We don't show patch for merges by default in git-show, so I don't
> see why we would want to show root commit diff in git-show by default:
> those two are very similar.

$ git init-db
$ date > file1
$ git add file1; git commit -a -m "file1 added"
$ date > file2
$ git add file2; git commit -a -m "file2 added"
$ git show --stat HEAD
$ git show --stat HEAD^

I can understand while people get confused.  Two patches, both add a file.  
git-show on one of them shows a stat; on the other it doesn't.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
