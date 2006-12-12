X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Tracking a repository for content instead of history
Date: Tue, 12 Dec 2006 13:26:22 +0000
Message-ID: <200612121326.24508.andyparkins@gmail.com>
References: <200612121235.09984.andyparkins@gmail.com> <elm993$rf1$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 13:27:00 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=NeNm/iWWIOYx+WpaAqdbUgR77qYvyum3vUayZaZQE8WMo7Zm+WYb/OGUeZjbIjJlrFgS15ZRLGrs6L1wnq1q4eZt76uiZaMYW8+89DzP9IH/i+YrHZhTmDnTiQOZWqacjm8auJoqJQkGVoVFst6Mwrt3Jft/Zi9VfLj4wQvWcv8=
User-Agent: KMail/1.9.5
In-Reply-To: <elm993$rf1$1@sea.gmane.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34098>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu7em-0008Gx-00 for gcvg-git@gmane.org; Tue, 12 Dec
 2006 14:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751333AbWLLN0b (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 08:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWLLN0b
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 08:26:31 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:18902 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751333AbWLLN0a (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec
 2006 08:26:30 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1662069uga for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 05:26:29 -0800 (PST)
Received: by 10.67.21.11 with SMTP id y11mr11696298ugi.1165929989013; Tue, 12
 Dec 2006 05:26:29 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id k1sm8733561ugf.2006.12.12.05.26.28; Tue, 12 Dec 2006 05:26:28 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Tuesday 2006 December 12 13:04, Jakub Narebski wrote:

> > Is it even sensible to want that?  It strikes me that it's possible that
> > there isn't that much space/bandwidth saving to be made.  Should I just
> > clone the repository and shut up?  :-)
>
> I've had similar idea: search for "sparse clone" keyword. But no code.

While the functionality might not be built into git in terms of clone, would 
there be a way to pull a particular commit from another repository? 

The way I would do it given nothing else is to simply extract snapshots into a 
working directory; and create a repository from scratch.  I was just 
wondering if a method existed that could reduce the size of the download.

I think the best way is going to be to use the patches published at kernel.org 
and apply them one at a time with git-apply.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
