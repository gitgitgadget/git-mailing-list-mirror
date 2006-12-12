X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Uninstall rule for top level Makefile
Date: Tue, 12 Dec 2006 15:42:08 +0000
Message-ID: <200612121542.09259.andyparkins@gmail.com>
References: <200612112214.09735.andyparkins@gmail.com> <200612121251.33051.andyparkins@gmail.com> <Pine.LNX.4.63.0612121512060.2807@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 15:42:20 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ou+5q4YupJKMBph79dgxE50DZ5rxMsxgYyWfukHeFEe7l4/hjr5MX5CoeXDVyNoN1ykFeKuvw3VPyMPbuQZnpqmaN5KrOymRQ8o5wildwjIBkB58HT4YYmlhRcoWL2Dg8Kbcj8oqIZHFmsRpqjORmEx1/fFmQFsap3Oyg+S1+A0=
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.63.0612121512060.2807@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34104>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu9lp-0004NA-ON for gcvg-git@gmane.org; Tue, 12 Dec
 2006 16:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751433AbWLLPmO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 10:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWLLPmO
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 10:42:14 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:48098 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751436AbWLLPmO (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec
 2006 10:42:14 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1699828uga for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 07:42:13 -0800 (PST)
Received: by 10.67.119.9 with SMTP id w9mr11928533ugm.1165938132809; Tue, 12
 Dec 2006 07:42:12 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id i39sm8945680ugd.2006.12.12.07.42.11; Tue, 12 Dec 2006 07:42:11 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Tuesday 2006 December 12 14:15, Johannes Schindelin wrote:

> The uninstall target _only_ solves the case you mentioned: when you
> installed Git in the wrong place. But then it is fragile: if you put the
> new path into config.mak, or you provided the PREFIX on the command line,
> and possibly do not remember what it was, the uninstall goes wrong.

Absolutely.  I agree entirely.  The only reason I raised it was because I had 
cause to need it.  The quickest way I found was just to write the missing 
recipe.  As I'd written it, I thought I'd share.  As you say, it has no other 
use than unpicking a stupid "install", done by a butterbrain like myself :-)

> But then, I do not care at all about that target being in the Makefile or
> not. I'll just ignore it, just as almost everybody else.

Until I needed it; I didn't care that it wasn't there.  Even then "need" is 
perhaps too strong a word.  It was handy.  That's it.  If there are strong 
moral objections to it; it doesn't bother me.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
