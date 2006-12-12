X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Uninstall rule for top level Makefile
Date: Tue, 12 Dec 2006 12:51:31 +0000
Message-ID: <200612121251.33051.andyparkins@gmail.com>
References: <200612112214.09735.andyparkins@gmail.com> <Pine.LNX.4.63.0612121325000.2807@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 12:51:51 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=oWrhFPBLWOEFSpvsg+EvlMf7lVoUM+REYFTeE762NtJC6cpqnt+H714MixNXUe7Wnco+uyiwI7+y7QZ+vXSWbgcvkDGYG6kNCFpcViLHTw7kCgxS8QVKtmfZPqL3eTOmXRwA0rTsZ8tP77cYYQilco4bmc7/aPvH2E3H6FgP1to=
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.63.0612121325000.2807@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34095>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu76k-0003KF-2R for gcvg-git@gmane.org; Tue, 12 Dec
 2006 13:51:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751259AbWLLMvj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 07:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWLLMvj
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 07:51:39 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:29930 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751259AbWLLMvi (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec
 2006 07:51:38 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1653140uga for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 04:51:38 -0800 (PST)
Received: by 10.66.216.1 with SMTP id o1mr1140010ugg.1165927896961; Tue, 12
 Dec 2006 04:51:36 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 30sm8639163ugf.2006.12.12.04.51.36; Tue, 12 Dec 2006 04:51:36 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Tuesday 2006 December 12 12:25, Johannes Schindelin wrote:

> see http://article.gmane.org/gmane.comp.version-control.git/8682 for a
> discussion about an uninstall target.

I read that thread, but don't see its relevance.  Have I missed something?

In summary:

"uninstall" is not useful in lieu of a package manager, but for developer 
types (like those on this mailing list) it is useful when you install in the 
wrong place (as I did just before I felt the need for an uninstall recipe).

The thread you linked to seemed to want the uninstall to not have hard-coded 
filenames.  That's what I did.

I assume I've missed something in the linked thread - what was it you wanted 
me to pick up from it?


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
