X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: svn versus git
Date: Fri, 15 Dec 2006 12:08:54 +0000
Message-ID: <200612151208.56286.andyparkins@gmail.com>
References: <200612132200.41420.andyparkins@gmail.com> <200612140908.36952.andyparkins@gmail.com> <elu0n5$u0i$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 15 Dec 2006 12:09:15 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=C15g0QTHVqm/AjdKZPhi1tU0ldxk3ejkRSxNiqkFb1SH7hZ86gh3IEfiJiue9P8UQ/BxsAIcNVglPX47hdZVAuxzQcgRaYbHdkikb3fmrIt2WBPEzBGHt/xnbyjhraUP/3VPkQowA8eiFzlo7gslLy73Ahuq09qbS+lUxScw9vs=
User-Agent: KMail/1.9.5
In-Reply-To: <elu0n5$u0i$1@sea.gmane.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34498>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvBsE-0007hd-HH for gcvg-git@gmane.org; Fri, 15 Dec
 2006 13:09:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752032AbWLOMJH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 07:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752034AbWLOMJG
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 07:09:06 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:6145 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1752032AbWLOMJE (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec
 2006 07:09:04 -0500
Received: by ug-out-1314.google.com with SMTP id 44so796630uga for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 04:09:02 -0800 (PST)
Received: by 10.67.92.1 with SMTP id u1mr1054196ugl.1166184542215; Fri, 15
 Dec 2006 04:09:02 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 30sm4142275ugf.2006.12.15.04.09.01; Fri, 15 Dec 2006 04:09:01 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 2006 December 15 11:27, Jakub Narebski wrote:

> > $ git-ls-tree v1.0.0
> > 100644 blob 906e98492080d2fde9467a9970fc92d7a8cfeaf8    Makefile
> >
> > I'm a newbie:  what's that number at the front?  What's a blob?  What's
> > that great big number - I've only seen commit hashes that look like that,
> > and that isn't one.  Definitely not friendly.
>
> The number in front is octal mode of a file or directory. "blob"
> is a file (or symbolic link), "tree" is a directory, all of this
> can be found in git(7).

Sorry, when I said "I'm a newbie", I meant "pretend I'm a newbie" :-)

My point was that this is all too confusing for a newbie; the fact that you 
had to descend to talk about SHA-1 and blob hashes, really serves to 
strengthen my point.  What does a non-developer care about hashes, blobs, 
trees, commits, or objects?

In this case however, I withdrew my complaint because it's argued that 
git-ls-files is not the right tool for this purpose anyway.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
