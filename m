From: David Aguilar <davvid@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Thu, 5 May 2011 14:41:15 -0700
Message-ID: <88795B20-6994-46A5-9710-2ADC84E04695@gmail.com>
References: <4DB80747.8080401@op5.se> <BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com> <4DB82D90.6060200@op5.se> <7vbozr8uo8.fsf@alter.siamese.dyndns.org> <7vpqo77dlr.fsf@alter.siamese.dyndns.org> <1303930175.25134.38.camel@drew-northup.unet.maine.edu> <20110427194233.GA16717@gnu.kitenet.net> <7vwrif5q93.fsf@alter.siamese.dyndns.org> <20110427220748.GA19578@elie> <7vsjt35l84.fsf@alter.siamese.dyndns.org> <20110427234224.GA26854@elie> <7viptz5j82.fsf@alter.siamese.dyndns.org> <BANLkTi=w0aKH6dxu84i4DjkL-vNCWQi8pw@mail.gmail.com> <alpine.DEB.2.00.1104271751300.940@asgard.lang.hm> <BANLkTimnkBMRH7Spj1ByQRa9YdV9w+bwtQ@mail.gmail.com> <BANLkTikbcpzF203rUVB05OYyYhLmu3+n6w@mail.gmail.com> <BANLkTinQny-M0rL+Vs9L_cQhtVLyv6rqMw@mail.gmail.com> <4DB9329E.7000703@op5.se> <BANLkTikKp9-uFGLavBT0UA5+m
 aV5xiEJZA@mail.gmail.com>
Mime-Version: 1.0 (iPhone Mail 8C148a)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>,
	"david@lang.hm" <david@lang.hm>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 23:41:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI6Ii-0000O3-39
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 23:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533Ab1EEVlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 17:41:31 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:59885 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617Ab1EEVla convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 17:41:30 -0400
Received: by pvg12 with SMTP id 12so1149149pvg.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 14:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:references:in-reply-to:mime-version
         :content-transfer-encoding:content-type:message-id:cc:x-mailer:from
         :subject:date:to;
        bh=MdikyYCKZA9dkXVeRqWpMRY8F4xmS9xYY/NiTuWShHk=;
        b=lF3rUUfx9FvJY/CHj30N3J/dGTWOgKt/etjILf+uxzwVP23Fm47EXRq5RplYF+wZQB
         NRv39LEdYQblWMcvNYmie8vvdNjKluq21jLHWirhi3AacrOeLgF05RQRmHBiSRaRZ6ad
         7SW3Pulxf/Kvsa2Hmg6QLfvLD5dq66MF6nUE4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:in-reply-to:mime-version:content-transfer-encoding
         :content-type:message-id:cc:x-mailer:from:subject:date:to;
        b=gmnSU+oYBCPrkdIS3gOQGGfer/Qo3sH/wZlFstiM/WTDzR75GFMoYLrAZmSoZh0FJI
         0Ldke1cqN9TjqfieFobUz91opNe42pPUbZ3lARQKQF5PuNuafJLofOsgeYv0endgusxb
         o9fvltzEYne5tw8+cAjiwKQPtA56vXu8I/TLc=
Received: by 10.143.21.38 with SMTP id y38mr1543834wfi.342.1304631690075;
        Thu, 05 May 2011 14:41:30 -0700 (PDT)
Received: from [10.16.52.53] ([198.228.210.48])
        by mx.google.com with ESMTPS id p7sm1681524pbp.1.2011.05.05.14.41.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 May 2011 14:41:27 -0700 (PDT)
In-Reply-To: <BANLkTikKp9-uFGLavBT0UA5+maV5xiEJZA@mail.gmail.com>
X-Mailer: iPhone Mail (8C148a)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172917>

On Apr 28, 2011, at 3:56 AM, Jon Seymour <jon.seymour@gmail.com> wrote:
> What is so  hard about:
> 
>  app install plugin.
> 
> Forget git. Forget git work.
> 
> What is so hard about the concept of an application providing a
> facility that allows it to request, merely request, the installation
> of a plugin for itself by what ever happens to be the users choice of
> package manager or distribution.

It's not hard.  We simply don't need it. 

Why do I need to activate my "plugin"?  That seems like a needless feature. If I don't want "git gui" I apt-get uninstall git-gui.

I've read this thread and do not understand what problem this is trying to solve. I have personally gotten along just fine writing git applications and deploying them with existing package managers.  I've not once ran into any situation where I felt I needed more support from git in order to deploy git commands.

Users already know about their package manager. Why do we need them to learn about Yet Another system?


> Is such a concept really, fundamentally flawed?

Yes

> if so, replace "git" with "linux", "app" with "apt-get", "plugin" with
> "git-core" and explain to me why
> 
> apt-get install git-core
> 
> is such a bad idea.
> 
> Yes, different levels of abstraction, but the principles are the same.
> 
> Like it or not, git is a platform, there is absolutely no reason why
> it can't have sane plugin manager, other than complete lack of
> imagination.

It doesn't need one. I'm happy with apt, yum, etc.  I probably don't understand why I need to learn more, but ignorance is bliss and users like to be blissful.

Let's assume we did have this system for a minute. Now we are worse off because many git apps do not and will never use the new plugin system.

Are we going to one day remove the awesome "search for git-foo in path" behavior and break everyone?  I think not.  In other words, I see little incentive for existing, established git apps to use such a system.

Sorry if I seem like a hard-liner, but we should always strive to keep things as simple as possible. I don't see any downsides to the current situation which is why I would resist such a proposal.  The upside would have to be pretty significant to convince established git apps to switch.
-- 
                                        David