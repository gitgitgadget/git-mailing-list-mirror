From: Steven Line <sline00@gmail.com>
Subject: Re: git svn clone terminating prematurely (I think)
Date: Thu, 12 Jan 2012 11:25:18 -0700
Message-ID: <CAJ1a7SpRP5GymPrpEchuNk3xwkJLHBKjsXY_85Xs_LAzXtWYuw@mail.gmail.com>
References: <CAJ1a7SrkDOyNRv8Spo4xvoKjP4zaXteim4h3JGcWU-nYDugx9Q@mail.gmail.com>
	<CALkWK0nyc6NVE7Qpvbc0dXb1UHGM_=uYbCS+a53HZxiBRG9HvQ@mail.gmail.com>
	<20120111224833.GA29654@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 19:25:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlPL4-0001kd-1X
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 19:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754765Ab2ALSZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 13:25:21 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:36543 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754417Ab2ALSZU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2012 13:25:20 -0500
Received: by lago2 with SMTP id o2so1055990lag.19
        for <git@vger.kernel.org>; Thu, 12 Jan 2012 10:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=d5u3OmLxmiV6gCrDTFZCZv+DmNrtMOGNxAqbX3bKHdE=;
        b=oCLDKuTLLC+u+F9NCzQJ9+je7NmhpG0kuYNlhRsuda7Wlozul4ILO1SFlrjeYEgdvP
         V6gdHlV8Q+Zir6J8l+kzU6GCX18lfJ8u5qvsOP4b1aHGQDQu4NODSaqsGO8vw6H2D5jh
         sN674BI+/5y3mYCdD/z8jCI1tq0uhAarsB8dE=
Received: by 10.152.112.42 with SMTP id in10mr2483032lab.21.1326392718710;
 Thu, 12 Jan 2012 10:25:18 -0800 (PST)
Received: by 10.112.13.53 with HTTP; Thu, 12 Jan 2012 10:25:18 -0800 (PST)
In-Reply-To: <20120111224833.GA29654@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188464>

Thank you Jonathan.

I had a breakthrough yesterday on this problem.  To make a long story
short my ssh connection to the server where I was running 'nohup git
svn clone' was timing out.  Additionally the nohup I was using wasn't
really protecting the git svn clone process so an hour or two after
the ssh disconnected, the git would terminate leaving me with an
imcomplete repository.  I don't understand why the nohup wasn't
working yet.  So my problem wasn't due to git itself.

I started my most recent git svn clone and it's now been running for
18 hours.  I'm optimistic that I've solved the problem.  If my git
does terminate early then I'll try a 'git svn fetch' to complete the
clone, based on what you said in your post.

-- 
Steven Line
303-910-1212
sline00@gmail.com
