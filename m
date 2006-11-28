X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Trim hint printed when gecos is empty.
Date: Tue, 28 Nov 2006 15:06:50 +0000
Message-ID: <200611281506.53518.andyparkins@gmail.com>
References: <ekh2uh$nk2$1@sea.gmane.org> <200611281403.36370.andyparkins@gmail.com> <Pine.LNX.4.63.0611281536230.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 15:07:17 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WukvMHd1WfUdVkw87f6SkOxhv3Lxg+LNS4hRS9KnY637WUviE8eFVTvqHjJXLbLl94NcWTqLbaWDHF1D6gLNXBAGYW6mWF7pbUvEJ9VuwwzyOneroHUTBJIjlVeZV+dZyEFF8Doci70Ohm4vY2kGMdP3ojhnoPvNPGcHJkj9jHA=
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.63.0611281536230.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32531>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp4Y4-0001CJ-Np for gcvg-git@gmane.org; Tue, 28 Nov
 2006 16:07:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758682AbWK1PHB (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 10:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758683AbWK1PHB
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 10:07:01 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:25414 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1758682AbWK1PHA
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 10:07:00 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1499819uga for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 07:06:59 -0800 (PST)
Received: by 10.66.242.20 with SMTP id p20mr1721684ugh.1164726418790; Tue, 28
 Nov 2006 07:06:58 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 20sm19661799uga.2006.11.28.07.06.58; Tue, 28 Nov 2006 07:06:58 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Tuesday 2006 November 28 14:40, Johannes Schindelin wrote:

> You are probably different than me. What with my track record, I _trust_
> my patches to be not perfect at all. Nevertheless, I commit here and now,
> and usually I regroup the commits into a nice patch (series) (AKA poor
> man's StGit).

I'm certainly not perfect, nor would I ever claim to be.  Perhaps I have 
misunderstood the purpose of the Signed-Off line.  I had understood it was a 
legal tool to trace the provenance of a patch - not to sign off on it being 
bug free (which surely is impossible).

Since I know that I, and I alone wrote that patch, I can sign off on it 
regardless of it being any good technically.

This is in agreement with my understanding of the 
Documentation/SubmittingPatches file included with git.

"The sign-off is a simple line at the end of the explanation for
the patch, which certifies that you wrote it or otherwise have
the right to pass it on as a open-source patch."

> So I will never need something like you suggest. Having said that, if you
> think it is best for you to mark every commit as signed-off-by you, just
> add an alias:
>
> 	git repo-config --global alias.c "commit -s"

That requires that I introduce a new command; I want the existing command to 
do The Right Thing.  Also; I certainly wouldn't want it global, as I said in 
my original message - this is a per-project choice.  Some projects don't have 
Signed-Off lines, so there is no point there.

Ideally, I'd be able to do
        git repo-config alias.commit "commit -s"
Just as I can with shell commands.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
