X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: [PATCH] "master" should be treated no differently from any other
   branch
Date: Thu, 14 Dec 2006 16:47:39 +0100
Message-ID: <4581721B.4050102@xs4all.nl>
References: <200612141519.44294.andyparkins@gmail.com> <Pine.LNX.4.63.0612141627090.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 15:50:28 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 20
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <Pine.LNX.4.63.0612141627090.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34354>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gusqh-0000Y7-V0 for gcvg-git@gmane.org; Thu, 14 Dec
 2006 16:50:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932821AbWLNPuQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 10:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932824AbWLNPuP
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 10:50:15 -0500
Received: from main.gmane.org ([80.91.229.2]:55409 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932826AbWLNPuN
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 10:50:13 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1GusqQ-0004Ws-09 for git@vger.kernel.org; Thu, 14 Dec 2006 16:50:02 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Thu, 14 Dec 2006 16:50:01 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 14 Dec 2006 16:50:01
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Johannes Schindelin escreveu:
> Hi,
> 
> On Thu, 14 Dec 2006, Andy Parkins wrote:
> 
>> "master" shouldn't get special treatment; making different log messages 
>> based on the name of the branch is bad form.  What if a user likes 
>> "my/master" or "my/head" as their master branch?
> 
> I do not agree. There is usually a principal branch, where you collect the 
> topics, and you do want to treat that special. As for the name: better 
> have a convention here than configurability. You would not want "git" to 
> be called "guitar" for some users, just because they happen to like that 
> name more, either, right?

Disagree: I have two principal branches, master and stable/2.10.  I don't see
why the latter should get different commit messages.

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
