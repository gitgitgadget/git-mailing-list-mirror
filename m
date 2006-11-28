X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Trim hint printed when gecos is empty.
Date: Tue, 28 Nov 2006 14:03:35 +0000
Message-ID: <200611281403.36370.andyparkins@gmail.com>
References: <ekh2uh$nk2$1@sea.gmane.org> <200611281146.56201.andyparkins@gmail.com> <Pine.LNX.4.63.0611281426311.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 14:04:05 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=A3bydXiy8t8ShiWQL2eiITS4GcK+kZs9IokQT63Ljs/TtEbCI8yBKL256AwI6NTWJzBaKj1SRZ7z1AJAageRlOQiSqAJguYN7W2QBxgbLSfx2Xsh0XEdHFjb7ZdWa/oe6q7nXOBoB3Pvf9yb7/9x08ecUN4o6KfNHo56+J8I1oI=
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.63.0611281426311.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32527>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp3Yq-0002Ua-8t for gcvg-git@gmane.org; Tue, 28 Nov
 2006 15:03:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934637AbWK1ODp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 09:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934963AbWK1ODp
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 09:03:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:62665 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S934637AbWK1ODp
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 09:03:45 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1483048uga for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 06:03:43 -0800 (PST)
Received: by 10.66.248.5 with SMTP id v5mr1614496ugh.1164722623540; Tue, 28
 Nov 2006 06:03:43 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id e33sm19612161ugd.2006.11.28.06.03.39; Tue, 28 Nov 2006 06:03:39
 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Tuesday 2006 November 28 13:28, Johannes Schindelin wrote:

> No. As has been often said, a signoff _has_ to be a conscious act, or else
> it will lose its meaning.

I'm not suggesting that a project integrator would have that switch on, but 
for me, in my own repository, where I am the only person writing patches, 
what possible case is there that I won't sign off?

> Once you are reasonably convinced you want to sign off on that commit,

I am always convinced.  Perhaps I am doing wrong - please explain to me under 
what circumstance I would /not/ want to sign off on a commit.  (assuming I am 
acting merely as a developer on a project, I am not accepting patches from 
anyone but me).

> just add "-s" to git-commit. And if you forgot, fix it by "git commit -s
> --amend". (Note that this is another nice example why "-a" by default
> would be wrong, wrong, wrong.)

I don't see what one has to do with the other.  There are good arguments for 
not having "-a" default, but signing off isn't one of them.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
