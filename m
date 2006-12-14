X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 11:36:57 +0000
Message-ID: <200612141136.59041.andyparkins@gmail.com>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <200612140959.19209.andyparkins@gmail.com> <7v7iwu93rv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 11:37:18 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=AjXdqRJZBHcwoNFVJrhjOPRWuPmjeSttPbRWX4GqUKhivEfrqdiH2nfwub2QPQFSNN97MHo3Z3tkZ0Zcf5Uht4R6gGbjyOvf6BW61lkZ2tikZPY6VP1P1bc5vS991Y/ZDpHPdCPcNRwYDfAjxVskPkook80zV//MJux2d777i54=
User-Agent: KMail/1.9.5
In-Reply-To: <7v7iwu93rv.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34320>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guoth-0006fT-17 for gcvg-git@gmane.org; Thu, 14 Dec
 2006 12:37:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932640AbWLNLhF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 06:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932638AbWLNLhF
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 06:37:05 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:34339 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932640AbWLNLhE (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 06:37:04 -0500
Received: by ug-out-1314.google.com with SMTP id 44so468588uga for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 03:37:03 -0800 (PST)
Received: by 10.66.221.6 with SMTP id t6mr1243200ugg.1166096222790; Thu, 14
 Dec 2006 03:37:02 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id k2sm1918713ugf.2006.12.14.03.37.02; Thu, 14 Dec 2006 03:37:02 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 2006 December 14 10:21, Junio C Hamano wrote:

> You keep repeating that you want to know the object name of the

Oh dear, you're right; I am terribly repetative.  Sorry.
Oh dear, you're right; I am terribly repetative.  Sorry.

;-)

> But you never communicate with your own git repository using the
> SHA-1 object names when talking about commits you made recently

How's this then:

$ git commit
$ git commit
$ git commit
$ git reset HEAD^^^

"AGGGHHHHHH!  I meant HEAD^^"

At this point I start running "git-prune -n | grep commit" and some liberal 
use of git-show to try and find the hash of the object so I can do

$ git reset --hard HASH_OF_OBJECT_I_STUPIDLY_ORPHANED

> So I do not think "git commit" is a valid example.  I also agree
> with Shawn that "git add" that says 6781 files were added is
> pointless.

Okay.

> > I've always thought that programs that needed an expert/beginner split
> > were badly designed.
>
> There probably is a truth in that.  Let's not add verbosity
> unnecessarily.

My habit is always to be overly verbose in program output; however, I realise 
that not everybody likes that.  None of these things cause me any difficulty 
in my use of git.  However, my Dad also is an engineer, but he's not so 
comfortable with VCS; for him almost every part of git is a mystery.  
Commands that run and don't say anything are confusing because he didn't 
really know what they were /meant/ to do; he's just got a set of recipes that 
he knows to type.  He's probably an extreme case, and not a good model for 
typical user - on the other hand, I would say that if he can use it, then it 
is officially newbie-friendly. :-)

> I agree with you that making some commands with progress
> indication less chatty would be a good clean-up.

These are actually the ones I feel more strongly about.  Too much output just 
drowns out the information that people really need.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
