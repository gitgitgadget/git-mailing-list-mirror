X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] "master" should be treated no differently from any other branch
Date: Thu, 14 Dec 2006 16:25:07 +0000
Message-ID: <200612141625.08485.andyparkins@gmail.com>
References: <200612141519.44294.andyparkins@gmail.com> <Pine.LNX.4.63.0612141627090.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 16:25:23 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tJBcAkcP1mRSoUEuGm5o8pwlhwSQ6ggNLIpnAX6Hg9k/8Kz6G8ZlwuBbzXjF7+j/dq8bK0/6LkxLU6lAWM/ciB/vVvbmGK/RtW6ZqZqjANm2myWvgQ5RT1dyJSzMra3pSz2hAE5WZX5VIk1KR49gmUc09wDCpychs7b0QlZXYXk=
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.63.0612141627090.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34363>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GutOZ-0006i1-F9 for gcvg-git@gmane.org; Thu, 14 Dec
 2006 17:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932857AbWLNQZQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 11:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932859AbWLNQZQ
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 11:25:16 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:29411 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932857AbWLNQZN (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 11:25:13 -0500
Received: by ug-out-1314.google.com with SMTP id 44so544853uga for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 08:25:12 -0800 (PST)
Received: by 10.67.100.17 with SMTP id c17mr1659499ugm.1166113511984; Thu, 14
 Dec 2006 08:25:11 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 28sm2217955ugc.2006.12.14.08.25.11; Thu, 14 Dec 2006 08:25:11 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 2006 December 14 15:29, Johannes Schindelin wrote:

> I do not agree. There is usually a principal branch, where you collect the
> topics, and you do want to treat that special. As for the name: better

While there might _usually_ be a principal branch; the special casing is 
_always_ hard coded.

> have a convention here than configurability. You would not want "git" to
> be called "guitar" for some users, just because they happen to like that
> name more, either, right?

You're correct; but we're talking about branch names not program names.  
Making "master" special rather than simply a default means git is dictating 
policy.  It isn't git's place to decide what my branches are called, 
especially as it is git itself that lets me choose freely to begin with.

Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
