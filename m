From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git Survey 2011; now let's not forget the index/cache/stage
Date: Mon, 20 Sep 2010 15:38:39 +0200
Message-ID: <201009201538.41287.jnareb@gmail.com>
References: <AANLkTi=Fp89-MuYVCNFtSA25hVufbQD5TCJL-ATUDCDH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 15:39:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxgaB-00082k-SL
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 15:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756475Ab0ITNix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 09:38:53 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43151 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755965Ab0ITNiw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 09:38:52 -0400
Received: by fxm3 with SMTP id 3so603142fxm.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 06:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:mime-version:content-disposition
         :cc:content-type:content-transfer-encoding:message-id;
        bh=GNxGXSHwyYvhLIMcANKo4p0Azx1pP0IqzAHcYMSKEOU=;
        b=tJrAJBMKS+Gp8HMvblQuR0+E+hNxVF2Y7vfMkIoY0ZVWQcpZ/WoUwpN/ACMfCr8FKZ
         8WpQL/edytyaTsXgVnHBK8DiMHWu8gnKxI2tsZtB+0CAdxK93yfXZE8CRYpQpKwZAiqm
         8HL+wWKvgu3zuu3CR2cRIMUtHFoI+lBNyk5/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version
         :content-disposition:cc:content-type:content-transfer-encoding
         :message-id;
        b=rQtAoumCXFYCXGCq/zqQyoB9/UGvfkRwIvewUUTkyFuJUUhh+x0A8v6QiDF0WAWzCT
         JMtJ7nyRyrsvElf4z69UA8llHCFm4atGV93max0xTFIdznOWTgf6AqJEGT3a430tQPZn
         5gbXp/cwNJZCtAH8aYuJqeeCAgG0gZgZtq0Ww=
Received: by 10.223.124.197 with SMTP id v5mr4624786far.68.1284989930368;
        Mon, 20 Sep 2010 06:38:50 -0700 (PDT)
Received: from [192.168.1.13] (abwt29.neoplus.adsl.tpnet.pl [83.8.243.29])
        by mx.google.com with ESMTPS id r4sm2916746faa.43.2010.09.20.06.38.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 06:38:49 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTi=Fp89-MuYVCNFtSA25hVufbQD5TCJL-ATUDCDH@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156621>

On Mon, 20 Sep 2010, Felipe Contreras wrote:

> I am *extremely* disappointed with the fact the git survey doesn't
> have a way to determine how many people really use the
> index/cache/stage; I think it's one of the most important features of
> git, and I'm fairly certain most users don't know about it.

Doesn't "interactive commit / per-hunk comitting / partial commit" cover
"git index / cache / stage" response by being what git index is used for 
in explicit way?
 
> IMO the main purpose of the survey is to find out areas of improvement
> in git, and I was hoping this year it would be obvious the stage
> needed some help to make it more visible and accessible.

I don't think that having "git index / cache / stage" as a choice of
answer in multiple-choice '16) Which of the following features do you 
use?' question would tell us that.

If there were "better support for staging / interacting with index"
(perhaps with footnote describing it in more detail below) in the
'17) Which of the following features would you like to see implemented 
in git?' question, but IIRC it wasn't present in your proposal.

> 
> You agreed it would be there, and it's not, so I wonder what's the
> point of asking for feedback if it's going to be forgotten. Next time
> I think you should send the final version for review before
> publishing.

There were two issues conflated that contributed to this error
of mine.

First, I have re-checked *direct email* responses to request for 
feedback on Git User's Survey 2010 questions proposal, but I have 
forgot to re-check responses which were send only to git mailing list 
without Cc (i.e. in my case *newsgroup* responses).  I am very sorry 
for that.

Second, I has a bit unplanned time away from Internet access at the end 
of August, so I had only about a day to do re-check, edit and open the 
survey on 1 September.  I should have edited survey as soon as i got 
improvement suggestion, but the fact that one has to close all channels 
before adding new answer to a multiple-choice question (I think 
Survs.com did it for a good reason) made me postpone it.

> 
> I don't think I would care about the results this year, so can we have
> a wiki with next years's survey? I *really* want to make sure it gets
> there.

Well, nobody prevents you from starting GitSurvey2011 page on git wiki.
You can use older version of GitSurvey2010 as a template:
  https://git.wiki.kernel.org/index.php?title=GitSurvey2010&oldid=8988
(click edit and copy the contents).  Having a year for discussion about 
what questions should there be in user's survey would only improve it.

I can even post on git wiki (probably in sub-pages) the emails I have 
send to git hosting sites to announce the survey.


P.S. I can even add you as a member to 'git' account on Survs.com, so
you would be able to view and even edit survey there, but the Premium 
plan, which we have thanks to generosity of Survs.com administration 
(received after Survs.com got out of beta - first survey on Survs.com 
was run on beta), will downgrade to the Free plan on Sep 22, 2011.

Currenly the survey has more than 5000 responses (in a not whole month),
so any plan outside of Premium is out of question.  We can run 2011 
survey earlier so it wouldn't hit downgrade time, try to move to other 
survey site (http://survey.net.nz got closed, unfortunately), create 
our own survey app e.g. on Google App, ask Survs.com admins for further 
generosity, or pay for Premium account ($119/month) at least for the 
time the survey runs.

-- 
Jakub Narebski
Poland
