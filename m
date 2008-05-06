From: Roman Shaposhnik <rvs@sun.com>
Subject: Re: Making submodules easier to work with
Date: Tue, 06 May 2008 16:17:52 -0700
Message-ID: <1210115872.25663.1097.camel@work.sfbay.sun.com>
References: <8B885217-8C18-417E-8F11-BB6661792CD3@gmail.com>
 <alpine.DEB.1.00.0804301121240.17469@eeepc-johanness>
 <BC221793-3FB5-4249-8E8D-819C1B413592@gmail.com>
 <32541b130804301331o70310831raf71db7cbb51d507@mail.gmail.com>
 <EFEF26F9-D5D6-4BAC-9A8F-6D96E45AFAF7@gmail.com>
 <32541b130804301448i537a0b98ta01cecc472e20aec@mail.gmail.com>
 <1209594215.25663.864.camel@work.sfbay.sun.com>
 <32541b130804301528k70ae2f7eq5229c0b4bb1d3788@mail.gmail.com>
 <20080501183837.GA4772@pvv.org>
 <3B9C16C0-0D0C-42D3-8315-72C8D8C88452@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Cc: Finn Arne Gangstad <finnag@pvv.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Wed May 07 01:13:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtWM6-0005vY-N9
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 01:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761310AbYEFXNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 19:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763098AbYEFXNB
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 19:13:01 -0400
Received: from sca-es-mail-1.Sun.COM ([192.18.43.132]:53302 "EHLO
	sca-es-mail-1.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761310AbYEFXM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 19:12:59 -0400
Received: from fe-sfbay-10.sun.com ([192.18.43.129])
	by sca-es-mail-1.sun.com (8.13.7+Sun/8.12.9) with ESMTP id m46NCubT022485
	for <git@vger.kernel.org>; Tue, 6 May 2008 16:12:56 -0700 (PDT)
Received: from conversion-daemon.fe-sfbay-10.sun.com by fe-sfbay-10.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0K0G00001Z1B1800@fe-sfbay-10.sun.com> (original mail from rvs@sun.com)
 for git@vger.kernel.org; Tue, 06 May 2008 16:12:56 -0700 (PDT)
Received: from [129.146.84.200] by fe-sfbay-10.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPSA id <0K0G00KMJZ5K87A0@fe-sfbay-10.sun.com>; Tue,
 06 May 2008 16:12:56 -0700 (PDT)
In-reply-to: <3B9C16C0-0D0C-42D3-8315-72C8D8C88452@midwinter.com>
X-Mailer: Evolution 2.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81386>

On Thu, 2008-05-01 at 16:29 -0700, Steven Grimm wrote:
> On May 1, 2008, at 11:38 AM, Finn Arne Gangstad wrote:
> > Where do we want to go with submodules?
> 
> I have two uses for submodules.
> 
> The first one is... well, not really submodules at all. I really want  
> sparse checkout so I can avoid bothering with parts of the larger  
> project tree I don't care about or need.

When you say "checkout" do you really mean "git checkout" (IOW, you
still have the history for *everything* in .git but you just
don't want your working tree to be polluted by the stuff you don't
need at the moment) or are you talking about "partial cloning"?
The reason I'm asking is because a need for "partial cloning"
is very real around where I work. Which is easy to understand
because TeamWare (a precursor to BitKeeper) supports such a
concept. Now, before I get beaten to death: I DO understand why 
"partial cloning" and changeset-oriented SCMs don't go together
well. Yet, it seems to me that a sort of "transitive closure"
of the changesets for the files I'm actually interested in might
be a natural way of having such a feature.

>  But right now submodules are  
> the only way to approximate sparse checkout, 

For us submodules seem to be  the only way to approximate "sparse
cloning" and that's why the usage patterns I worry about don't
necessarily match the ones that drive "git submodule"

Thanks,
Roman.
