From: "Josh Boyer" <jwboyer@gmail.com>
Subject: Re: git-unpack-objects
Date: Thu, 4 May 2006 06:58:16 -0500
Message-ID: <625fc13d0605040458q1018c7ccl79e8effe23edf7d8@mail.gmail.com>
References: <625fc13d0605011552j4189338bx14083657acffc18e@mail.gmail.com>
	 <7vu089qr4t.fsf@assigned-by-dhcp.cox.net>
	 <625fc13d0605031035l721ab08dmee6f870abb49f4e4@mail.gmail.com>
	 <Pine.LNX.4.64.0605031041150.4086@g5.osdl.org>
	 <625fc13d0605031044y2ff03ed2h261db5455b234254@mail.gmail.com>
	 <Pine.LNX.4.64.0605031054300.4086@g5.osdl.org>
	 <625fc13d0605031731v7b65a738r6fc0169958235928@mail.gmail.com>
	 <20060504100237.GA10548@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 04 13:58:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbcTU-0005Bv-Tr
	for gcvg-git@gmane.org; Thu, 04 May 2006 13:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbWEDL6S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 07:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbWEDL6S
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 07:58:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:27837 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750945AbWEDL6R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 May 2006 07:58:17 -0400
Received: by ug-out-1314.google.com with SMTP id m3so271694ugc
        for <git@vger.kernel.org>; Thu, 04 May 2006 04:58:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eE1IfqkjLnx4+2nBBdsQliwLCglYOU6lQfOXYrbysH3mjWMCxN0QmW8LSBXX67elqqJ3TOJMd65TiKcYuOx4qsD/xPjeUOkPyt5hNjOwiaXk3V0jdms2cm7J35t2P9qQESbRNWeMK22UggzTw+59ZX8+GqjZTNrXf4a5oLboCHs=
Received: by 10.78.21.7 with SMTP id 7mr68672huu;
        Thu, 04 May 2006 04:58:16 -0700 (PDT)
Received: by 10.78.29.19 with HTTP; Thu, 4 May 2006 04:58:16 -0700 (PDT)
To: "Marco Roeland" <marco.roeland@xs4all.nl>
In-Reply-To: <20060504100237.GA10548@fiberbit.xs4all.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19566>

On 5/4/06, Marco Roeland <marco.roeland@xs4all.nl> wrote:
> On Wednesday May 3rd 2006 Josh Boyer wrote:
>
> > >It does. That's what the "-a" (for "all") does.
> >
> > Odd.  On one of my repos, I was seeing the correct behavior.  On
> > another, there were multiple packs left after doing the 'git repack -a
> > -d'.  Were there ever some packing bugs in older versions of git that
> > would have maybe produced some packs that wouldn't get deleted or
> > something?
>
> Have you checked with "git fsck-objects" that maybe the "remaining"
> packs contained non-reachable objects like dangling commits from resets
> or from following volatile branches like +pu?

This was on a kernel repo, so no branches.  But dangling commits from
resets might have been present.  I can't tell now since I undid all
that packs and redid them into a single.  Thanks for the suggestion
though, that sounds like a perfectly reasonable explanation.

josh
