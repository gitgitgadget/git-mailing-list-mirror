X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] cvs-migration document: make the need for "push" more obvious
Date: Wed, 6 Dec 2006 14:27:57 +0100
Message-ID: <200612061427.58065.jnareb@gmail.com>
References: <4574AC9E.3040506@gmail.com> <el6d50$p7e$2@sea.gmane.org> <Pine.LNX.4.63.0612061411380.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 13:26:07 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZzHeQYcfZ/z1vJnhilvjGfhwksJWtrxoCraZn7qLMC3XPWnEd3uyUGzc3DH0nZxu//ltcBn/N/uUOF9qURTH7zMjhFNA18nbqRF57lHKqlmyT9ELEC5rjxYdIM6UsfxBVjJAeJjUProiVeLrbmCaBUdQ8Zveb/7QBanRglplSto=
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0612061411380.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33456>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grwma-0000u9-J9 for gcvg-git@gmane.org; Wed, 06 Dec
 2006 14:25:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760596AbWLFNZy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 08:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760599AbWLFNZy
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 08:25:54 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:40625 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1760596AbWLFNZx (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec
 2006 08:25:53 -0500
Received: by ug-out-1314.google.com with SMTP id 44so138891uga for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 05:25:52 -0800 (PST)
Received: by 10.67.26.7 with SMTP id d7mr779352ugj.1165411551769; Wed, 06 Dec
 2006 05:25:51 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id 20sm10046885uga.2006.12.06.05.25.51; Wed, 06 Dec
 2006 05:25:51 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Hi!

Johannes Schindelin wrote:

> On Wed, 6 Dec 2006, Jakub Narebski wrote:
> 
>> Johannes Schindelin wrote:
>> 
>>> +  * Since every working tree contains a repository, a commit will not
>>> +    publish your changes; it will only create a revision. You have to
>>> +    "push" your changes to a public repository to make them visible
>>> +    to others.
>>> +

I'd perhaps add here that it doesn't "push" your changes to a repository
you cloned from / you fetch from.
 
>> I'm not sure about context of this addition, but it is simply not
>> true if you publish your working repository.
> 
> Remember, you are talking to CVS users. They are not dumb, but sooo used 
> to the CVS ways. So, they do not publish their working directory.

So we are talking in context of having CVS-like one central repository
from which they pull / fetch, and to which they push?
 
> Later, when they became familiar with Git, you can tell them: "BTW you can 
> also publish your working directory, but then you have to be extra careful 
> with git-commit --amend, and if you allow pushing into your repo you have 
> to add hooks to prevent updating your current HEAD, etc."

I'd rather say that "publish your working repository", not "working
directory" here.

> Give them a chance to get used to the concepts of Git.

Well, it would be best to teach them concepts of git along.

-- 
Jakub Narebski
