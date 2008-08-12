From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: Summer of Code 2008 Midterm Summary
Date: Tue, 12 Aug 2008 17:25:25 +0200
Message-ID: <48A1AB65.2080809@gmail.com>
References: <20080726232743.GA16870@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 12 17:27:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSvmY-0005vn-D5
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 17:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752980AbYHLPZ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 11:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753331AbYHLPZ4
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 11:25:56 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:49282 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754673AbYHLPZz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 11:25:55 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1374916fgg.17
        for <git@vger.kernel.org>; Tue, 12 Aug 2008 08:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=mq2Ik7qfQVsu17IU/cwhnpbTZWAxmd3eU36GhNHoqX4=;
        b=rRomfj73vulIkF7XXputYnXkTnXnl1cn08/dT/y+QHbhjACCEbMpK7AdFSdd6SifuR
         8XA/YmI0PbJVv/IFambpESxLkY4KDGMrvgjfM7wE0IX6Ls93v1VzixwMB+PiOWGwXy8B
         CT27jH9QRbMUDSkr49cMtCWA2jSqBseJBkm2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=v6nimtFEVvix8v+YWrze19hFknazLl06pk+7vDIRsDp2cJxh8eDBMigpbIrXoHft+a
         NW5iLHDi4vSWaK8DwjpP9XdmpWz5PqyBrrrjragELZyzp8j3xqdxrMgCXDOykfeTKYHa
         tIyS88BkPTUCLZa+j+3tASakP4VKTFuRPSJ5A=
Received: by 10.86.27.19 with SMTP id a19mr10481140fga.56.1218554753606;
        Tue, 12 Aug 2008 08:25:53 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.192.246])
        by mx.google.com with ESMTPS id l12sm4181973fgb.6.2008.08.12.08.25.51
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 12 Aug 2008 08:25:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.16) Gecko/20080707 Thunderbird/2.0.0.16 Mnenhy/0.7.5.666
In-Reply-To: <20080726232743.GA16870@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92102>

I know I'm 2 weeks late ;-), but here are some comments (I'm a GSoC
student working on gitweb caching):

Shawn O. Pearce wrote:
> Q: How much time have you spent per week interacting with your mentor
> 
>    All of our students (except 1) said 0-5 hours per week [...].
>    Nearly all of the mentors on the other hand chose 6-10 hours

Maybe mentors tended to count public interaction (on the list), and
students tended not to (or to underestimate how long it takes to write
email).

>    In terms of community building this question's answers seem to
>    suggest we need to try harder to make our students included,

That could include making sure that all students are comfortable with
IRC (which I've found very helpful), and discouraging taking discussion
off the main list (like it happened with GitTorrent).

> Q: Do you feel that you are on track to complete your project?
> 
>    I'm not sure if this is good or bad.  3 students (50%!) are
>    ahead of schedule, 1 is on schedule, and 2 are behind.

I think it's actually fine, since this is mostly a function of how
optimistic your initial plan was.  I picked "ahead" because I got
through faster than I originally estimated, but it simply means I can
implement some 'optional' features.

>    [Since 3 students are ahead] I wonder if as mentors we didn't
>    demand enough of our students?

I'd guess the opposite is true -- demanding more (as long as you don't
hit the 'overwhelm' effect), if anything, tends to make me stay on track
better.  E.g. last year I was 'behind schedule', and part of the reason
was that I had to balance GSoC and life and my mentor didn't kick my
butt quite hard enough. ;-)

-- Lea
