From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Efficiency of initial clone from server
Date: Mon, 12 Feb 2007 11:40:13 -0500
Message-ID: <9e4733910702120840p3fd2a18ar2e3b91564556dc43@mail.gmail.com>
References: <9e4733910702111153p1691ad99nda97325b34b7a13f@mail.gmail.com>
	 <7vd54gau3r.fsf@assigned-by-dhcp.cox.net>
	 <9e4733910702112029k6ef3fb7bl3bdb134a787512e8@mail.gmail.com>
	 <7v4ppsatbr.fsf@assigned-by-dhcp.cox.net>
	 <9e4733910702112053q2c196ddcr970a062281d332b7@mail.gmail.com>
	 <9e4733910702112101h256b1468j5de65c6e89109a22@mail.gmail.com>
	 <7vzm7k9c3c.fsf@assigned-by-dhcp.cox.net>
	 <9e4733910702112155m3f5da9abgbeb2b6783005296f@mail.gmail.com>
	 <7vr6svaowm.fsf@assigned-by-dhcp.cox.net>
	 <9e4733910702120724y2a0ba6b0h3f571aa2306872a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 12 17:41:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGeEg-0003oi-Ln
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 17:41:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbXBLQkV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 11:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbXBLQkV
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 11:40:21 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:6427 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964972AbXBLQkT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 11:40:19 -0500
Received: by ug-out-1314.google.com with SMTP id 44so640866uga
        for <git@vger.kernel.org>; Mon, 12 Feb 2007 08:40:14 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Tp11R0VCVUwsNvXjMenTtIX51lVs3zeHIpwr6HRizhYYMJrlk8wspXTTpPUP6syX9tpA340sr6JV0VTMoGdV6KXUc1dmKgeBDP3bjLrIeMK8AiUSL5VhXkSACSl8sJDAV3T5HdgOz8cwzc3649Suv5bXc++nnEoi4GScCy789xA=
Received: by 10.114.78.1 with SMTP id a1mr7058269wab.1171298413506;
        Mon, 12 Feb 2007 08:40:13 -0800 (PST)
Received: by 10.114.195.13 with HTTP; Mon, 12 Feb 2007 08:40:13 -0800 (PST)
In-Reply-To: <9e4733910702120724y2a0ba6b0h3f571aa2306872a5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39413>

On 2/12/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 2/12/07, Junio C Hamano <junkio@cox.net> wrote:
> > "Jon Smirl" <jonsmirl@gmail.com> writes:
> >
> > > I am guilty of doing initial clones for different kernel trees from
> > > kernel.org when I could be doing a local clone of linus' tree and then
> > > pulling the deltas from kernel.org. But I'm lazy, I just kick the
> > > clone off in the background and it finishes in three or four minutes.
> > > I also do the clones when I have messed my local trees up so much that
> > > I don't know what is in them anymore.
> >
> > Time to learn to use --reference perhaps?
> >
> >         git clone --reference linux-2.6 git://.../linville/wireless-dev.git
> >
> > where "linux-2.6" is local repository which is my personal copy
> > of Linus's repo.

Does this use hard links so that if I whack my linux-2.6 it won't also
destroy my wireless-dev repo?


-- 
Jon Smirl
jonsmirl@gmail.com
