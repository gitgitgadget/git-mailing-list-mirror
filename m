X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git-fetching from a big repository is slow
Date: Thu, 14 Dec 2006 16:20:16 +0000
Message-ID: <200612141620.17782.andyparkins@gmail.com>
References: <200612141340.43925.andyparkins@gmail.com> <200612141518.05770.andyparkins@gmail.com> <458171B7.1020702@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 16:20:34 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TJ7YBeoTMb8klmjRSulyHODGyPzqxtYuj0/qXhhSFZZyKEO9vXlzYSozajY/0T3YST2CPvwTkRT0wg48X4NBG7FZkZylYl1OOYNjPwmzm3w5bYCsHs+rMsSo8IvvORe89wqx7+PX0n8SswHAOeWwDKwCFXI8gFasOtinsKYRIfw=
User-Agent: KMail/1.9.5
In-Reply-To: <458171B7.1020702@xs4all.nl>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34362>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GutJq-0005py-Rj for gcvg-git@gmane.org; Thu, 14 Dec
 2006 17:20:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932848AbWLNQUY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 11:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932853AbWLNQUY
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 11:20:24 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:21593 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932848AbWLNQUX (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 11:20:23 -0500
Received: by ug-out-1314.google.com with SMTP id 44so543397uga for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 08:20:22 -0800 (PST)
Received: by 10.66.244.10 with SMTP id r10mr1670043ugh.1166113222633; Thu, 14
 Dec 2006 08:20:22 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id o1sm2203475uge.2006.12.14.08.20.21; Thu, 14 Dec 2006 08:20:22 -0800
 (PST)
To: git@vger.kernel.org, hanwen@xs4all.nl
Sender: git-owner@vger.kernel.org

On Thursday 2006 December 14 15:45, Han-Wen Nienhuys wrote:

> I just noticed that git-fetch now runs git-show-ref --verify on every
> tag it encounters. This seems to slow down fetch over here.

There aren't any tags in this repository :-)

Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
