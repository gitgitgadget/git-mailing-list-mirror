From: "Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>
Subject: Re: GIT vs Other: Need argument
Date: Wed, 18 Apr 2007 14:40:18 +0200
Message-ID: <8b65902a0704180540l721b9b1dj6f6e068f0d7e5119@mail.gmail.com>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
	 <20070417104520.GB4946@moonlight.home>
	 <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
	 <200704171818.28256.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Tomash Brechko" <tomash.brechko@gmail.com>,
	"Pietro Mascagni" <pietromas@gmail.com>
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 14:40:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He9ST-00034D-BH
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 14:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422967AbXDRMkV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 08:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422969AbXDRMkU
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 08:40:20 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:11568 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422967AbXDRMkS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 08:40:18 -0400
Received: by an-out-0708.google.com with SMTP id b33so164782ana
        for <git@vger.kernel.org>; Wed, 18 Apr 2007 05:40:18 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q1E03j9DVRGcjVgQDJL5iQ+iU27W80DR4qbCMiWHs0hgaNRl2UT6Ch6HCGFlnnPKGPGkbhW2Lae40yW1AkBR8GVYr5jTdrQSQyJNvGaMA+2FKwzgmtFaWmGb3nR4Ez5yiu6mk1YiD7BBvAWWAqSMTt9xD2fm34l+qKcKyEPhKb8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NOqYOT+eKQuhXFuJuldm/AqB1PHPKFa8pA1qDdXqAKXIp03JOdRQhmn0JS2LNitSQXDA2xHX5ewwuB9096kPNyHrpR80kYn9FwjhMEGsTWTC+tJPry7w0Aa9pHox1I9StRW5+Wwp/6vKL8Hj//4gqWBOYQAJD34wZpnPe2OmYqY=
Received: by 10.100.33.14 with SMTP id g14mr308327ang.1176900018193;
        Wed, 18 Apr 2007 05:40:18 -0700 (PDT)
Received: by 10.100.44.7 with HTTP; Wed, 18 Apr 2007 05:40:18 -0700 (PDT)
In-Reply-To: <200704171818.28256.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44893>

On 4/17/07, Andy Parkins <andyparkins@gmail.com> wrote:
> On Tuesday 2007, April 17, Guilhem Bonnefille wrote:
> > I'm new to Git, but completly crazy of it.
> >
> > In my point of view, in corporate team, lot of people does not
> > want/need the power offered by Git.
> > So, my conclusion is the better model in a corporate is a centralyzed
> > repo with some users using Git as "frontend". Other people will
> > simply use the native tools for accessing the repo.
>
> Git has you covered there - it works better than other version control
> systems for that model too.  I do it all the time; the only difference
> is that with git it's not the tool doesn't force the choice on you.
>
> If you want a central repo, just make one - designate one repository as
> central, put it in the .git/config file for each of the others and away
> you go.  Pretend it's centralised if you want; you and your colleagues
> need never know otherwise.

In fact, the most important problem (in my case) is that there are
people that really don't want/need Git features. These people consider
that CVS/SVN are constraints and not usefull tools. They are not
interested in what a VCS can offer. I have success with CVS/SVN
because we now use Eclipse which offers an easy to use GUI for CVS/SVN
actions.
An other point is that CVS/SVN actions for our developers are
"trivial": update or commit, nothing more (even tags are made by
"power" users, so working with branches...). With Git, you have to
ALWAYS remember that you have a repo locally which is different than
the central repo. I think this point is quite confusing for people not
interested in the features offered by having a "private" repo.

This is why I think my corporate friends will brake if I try to
propose Git for everybody.

In my mind, git-svn or even git-svnserve, are THE tools to introduce
Git in teams not convinced by the power of DVCS. Or perhaps someone
will create a porcelain that offers the same simple interface of
CVS/SVN and will integrate it in all the fantastic IDE ;-)
-- 
Guilhem BONNEFILLE
-=- #UIN: 15146515 JID: guyou@im.apinc.org MSN: guilhem_bonnefille@hotmail.com
-=- mailto:guilhem.bonnefille@gmail.com
-=- http://nathguil.free.fr/
