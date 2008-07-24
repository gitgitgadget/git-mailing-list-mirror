From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2008
Date: Thu, 24 Jul 2008 23:06:26 +0200
Message-ID: <200807242306.26742.jnareb@gmail.com>
References: <200807230325.04184.jnareb@gmail.com> <200807232349.42244.jnareb@gmail.com> <20080724180849.GA2925@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 23:07:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM82A-0006Y6-FW
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 23:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbYGXVGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 17:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbYGXVGe
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 17:06:34 -0400
Received: from ik-out-1112.google.com ([66.249.90.178]:52706 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301AbYGXVGd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 17:06:33 -0400
Received: by ik-out-1112.google.com with SMTP id c28so2317224ika.5
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 14:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=+9IV230nogD9TNYLewNgIsyVHnd1/l+WdJ+uel/dsWM=;
        b=UoKe0BZj3JUvSuSjlOqGOz/RT58j/ZgD54aBGpkXTuP6IuMwuovhQlbGjhu7EKJh1b
         KGQyejB1LywvFrAh79/j5oT7+k3OGzgnW0tLvgqnh72qyFkHi3UJYZbYTWPmTCSC/1xJ
         e9wAx3s+SDYvD7tC4yELSslDGFr6jp8eW320c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=hkuc4my2u/TpTJHnYpCNoasfZ3DVqsVv6ABDwuJ3kja9Gn/iki5OE5kGHhVZdk/icl
         wlWbhOJpXhE3RcYZMAUZO08bdwG1CyBjRQ+73Nepqs+Ej7EHnSiCuB6GBhOxA941SZ1Q
         Mf2yOjdrk+26lmM8fprkP8cc8Is6MLOFTbBCE=
Received: by 10.210.109.10 with SMTP id h10mr881029ebc.194.1216933588944;
        Thu, 24 Jul 2008 14:06:28 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.208.47])
        by mx.google.com with ESMTPS id y37sm14186780iky.8.2008.07.24.14.06.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 24 Jul 2008 14:06:27 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080724180849.GA2925@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89962>

On Thu, 24 July 2008, Dmitry Potapov wrote:
> On Wed, Jul 23, 2008 at 11:49:41PM +0200, Jakub Narebski wrote:
>> On Wed, 23 Jul 2008, Dmitry Potapov wrote:
>>> On Wed, Jul 23, 2008 at 03:25:03AM +0200, Jakub Narebski wrote:
>>>>
>>>>    02. What is your preferred non-programming language?
>>>>   (or) What is the language you want computer communicate with you?
>>> 
>>> IMHO, the later wording of the question is much better.
>> 
>> First just satisfies demographic curiosity.  Second is more question
>> about internationalization (i18n).
> 
> I think demographic is largely covered by the first question about
> country. As to i18n, I don't think it is fully covered just by the
> question about one's language preference to communicate with computer
> (which is probably is more correctly to call localization). Possible
> questions related to i18n are:
> - Do you use file names with non-ASCII characters?
> - Do you use text files with non-ASCII characters?
> - Do you (or members of your team) use computers with different
>   character sets and have to deal with non-ASCII characters?
> 
> But I guess we do not want to have so many questions. So, maybe
> something simple instead:
> - Are you satisfied with support for non-ASCII characters in Git?

But only if it is free-form question:

   xx. Are you satisfied with support for non-ASCII characters in Git?
       Yes or No?  If no, please explain what you had problems with.
       (free form, or rather Yes/No + explanation for No)

If we decide to add more questions about translating Git, I think
we should also add the following:

   xx. Which parts of Git would you like/do you need translated?
       (zero or more: multiple choice)
    -  git-gui, gitk, manpages, user's manual, commands messages

>> Should "What version do you use now?" be multiple choice (using git
>> on more than one machine / operating system)?
> 
> I think we already have another question about what OS one uses.
> So I believe it should be only version number here.

One can use Git on many different machines (for example at work, and
at home), or on multi-boot machine (with more than one operating
system).  Each of those machines, and/or each of those operating
systems can use different version of Git.  So that is why I think
this should be multiple choice, even if I guess that most people
would select only one answer.

>> What should be possible
>> choices for "How long do you use git?"?  Perhaps.
>> 
>>       10. How long do you use git?
>>           (single choice)
>>        -  never/few days/few weeks/month/few months/year/few years/
>>           from beginning/I wrote it(*)
>>        +  (*) just kidding ;-)
> 
> I would rather use numbers like that:
> 
> never
> less than month
> 1-3 months
> 3-6 months
> 6-12 months
> 1-2 year
> more than 2 years
> from the beginning

I think it is even better; I'm not sure if we shouldn't split sub-month
region, for example to provide for people who has heard of git for
first time, but played with it a little bit.

-- 
Jakub Narebski
Poland
