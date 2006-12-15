X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git-fetch fails with error code 128
Date: Fri, 15 Dec 2006 09:46:12 +0000
Message-ID: <200612150946.14439.andyparkins@gmail.com>
References: <200612142308.45376.andyparkins@gmail.com> <7vfybiyqk0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 15 Dec 2006 09:46:33 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gLT3Qgmp2HAyLFIQp8pYVfcBXmLZhyfsJnwCaaa0AI7WTC+4Lt9IvSMEEMNiqQXgDC02eUdYvezs2NhgQAaOrkrAfeBtCdXwf1BDvCvpwXQY9Rbjq71f6ENlpmn9uFZNFH8blxFCWpQFmo2EzKWaGjI5xT7onhXr0TQfQtQkIc4=
User-Agent: KMail/1.9.5
In-Reply-To: <7vfybiyqk0.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34484>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv9eA-0007PY-Dq for gcvg-git@gmane.org; Fri, 15 Dec
 2006 10:46:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751355AbWLOJqT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 04:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWLOJqT
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 04:46:19 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:19243 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751355AbWLOJqS (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec
 2006 04:46:18 -0500
Received: by ug-out-1314.google.com with SMTP id 44so768135uga for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 01:46:17 -0800 (PST)
Received: by 10.66.232.11 with SMTP id e11mr651039ugh.1166175976833; Fri, 15
 Dec 2006 01:46:16 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 53sm3935270ugn.2006.12.15.01.46.16; Fri, 15 Dec 2006 01:46:16 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 2006 December 15 00:02, Junio C Hamano wrote:

> Andy, which version of git do you run (I presume they are the
> same version, as you are doing the local fetching), and which
> version of git was the "slightly out of date" repository
> prepared with?

One of them is switched off and in another place at the moment, so this is 
from memory:

The initial repository was made with origin/master from a few days ago, that's 
the one I've been calling "out-of-date".  I cloned that to another computer 
and continued adding patches using "1.4.4.1.g3ece-dirty" (the dirt is just my 
colour branch patch on top of ba988a83).  The fetch is being done back on the 
original system which has the newer git but older repository.

I hadn't realised it was quite a serious as these responses are making it 
sound.  I'll gather more precise data upon my return home.

On the up-to-date computer I've just made a fresh repository, set .git/config 
to point locally at the full repository and ran git-fetch.  Interestingly, 
that has worked perfectly.

Clearly it is version-specific.  I'll do a bit of bisection later and see if I 
can nail the problem down.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
