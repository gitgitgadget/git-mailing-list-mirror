X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: svn versus git
Date: Thu, 14 Dec 2006 09:19:29 +0000
Message-ID: <200612140919.30495.andyparkins@gmail.com>
References: <200612132200.41420.andyparkins@gmail.com> <7vfybjbbsx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 09:19:43 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Xc4ZdBtH/imTxuPLDFc26cYmic/lvmWkBdIVl5EVpmdnm1QptPnqX0bJwPGsXqHocgrAVd73I5IxoKgU/WGxmzRSa34LGp9tyuS5vQwMzNUNqBDDtng+w/RHgzCVE1gOALIinS3Q/G/SxTG2VSO9h3Hywlic65aEy7XCDVcvL2U=
User-Agent: KMail/1.9.5
In-Reply-To: <7vfybjbbsx.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34290>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gumke-0005ej-Ie for gcvg-git@gmane.org; Thu, 14 Dec
 2006 10:19:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932119AbWLNJTh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 04:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWLNJTh
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 04:19:37 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:33245 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932119AbWLNJTg (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 04:19:36 -0500
Received: by ug-out-1314.google.com with SMTP id 44so435874uga for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 01:19:34 -0800 (PST)
Received: by 10.66.244.10 with SMTP id r10mr1077908ugh.1166087974714; Thu, 14
 Dec 2006 01:19:34 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id j34sm1780749ugc.2006.12.14.01.19.34; Thu, 14 Dec 2006 01:19:34 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 2006 December 13 23:45, Junio C Hamano wrote:

> ls-tree is not Porcelain and has right to expose the internals

Of course; but there is no porcelain to do that operation.

> by default.  "git ls-tree --name-only" could be aliased to give
> "git ls" if you wanted to, but I wonder how often you would want
> to run:
>
> 	svn list -r538
>
> and for what purpose?

I've never done it.  However, the command is there in subversion, so I was 
comparing git's implementation of that command.  I wouldn't completely write 
it off though.  It doesn't seem unreasonable to want to see what files were 
in an old revision.

> I often find myself doing
> 	git diff -r --name-status v1.3.0 HEAD

I can live with that as an acceptable alternative to "svn list"; however, as 
usual, how does my imaginary ex-svn user find out about that?  man git-diff 
isn't the first place /I'd/ go; and even if you do, you won't find the "-r" 
or "--name-status" options; you have to go to git-diff-files, git-diff-index 
or git-diff-tree - and you're meant to guess which is the right one.

Bear in mind that my current theme isn't "can git do...?" it's "how does a 
user know that git can do...?"

> What do people use "svn list -r538" for and how often?  In other
> words, when does it become necessary to get the full list of
> paths in an arbitrary revision?

Me: I don't do it often.  It's not something I'd lose sleep over if git 
doesn't have an easy way of doing it.  However, it was in the output 
of "svn --help"; so I included it.

Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
