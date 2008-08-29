From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Fri, 29 Aug 2008 19:11:26 +0300
Message-ID: <94a0d4530808290911j32bf5ee0q869dfe39483297f8@mail.gmail.com>
References: <18219E52-E56F-43D9-B28D-0CC74E225CC5@cs.indiana.edu>
	 <7BC51BEC-E230-48C5-BD3E-2CECE3C7FC98@cs.indiana.edu>
	 <20080828195211.GA3545@mithlond.arda.local>
	 <4B9831F7-3CB8-49CB-A1DB-111481A271FE@cs.indiana.edu>
	 <20080828212346.GA27867@coredump.intra.peff.net>
	 <1C144B19-DA21-4CB4-B872-C1F154B031CF@cs.indiana.edu>
	 <20080828215907.GE27867@coredump.intra.peff.net>
	 <3DE083DB-ADFF-45E7-B3EB-A76985941271@cs.indiana.edu>
	 <881C17DA-2FE2-49A7-A4A9-FACA7720599C@cs.indiana.edu>
	 <20080829152451.GA20629@yugib.highrise.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Perry Wagle" <wagle@cs.indiana.edu>, "Jeff King" <peff@peff.net>,
	"Teemu Likonen" <tlikonen@iki.fi>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Petr Baudis" <pasky@suse.cz>,
	"Kristian H??gsberg" <krh@redhat.com>,
	"Matthias Kestenholz" <mk@spinlock.ch>,
	"Steven Rostedt" <rostedt@goodmis.org>,
	"Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>,
	"Andi Kleen" <andi@firstfloor.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>,
	"David Woodhouse" <dwmw2@infradead.org>, git@vger.kernel.org
To: "Aidan Van Dyk" <aidan@highrise.ca>
X-From: git-owner@vger.kernel.org Fri Aug 29 18:12:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ6aQ-0001kt-Uh
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 18:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbYH2QL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 12:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753195AbYH2QL2
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 12:11:28 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:57145 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752195AbYH2QL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 12:11:27 -0400
Received: by rv-out-0506.google.com with SMTP id k40so942001rvb.1
        for <git@vger.kernel.org>; Fri, 29 Aug 2008 09:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=JfvWZZFcnbRABciPvzjKAxjtZUSpzFpAZi1RrDS42aA=;
        b=QBq3Mv40F+xpebXRZLOBuarsX0ajUx2H+gVS54DWOQn0RJS/3tDAjIJZ8CAqedPS3n
         lV5764P9WEfyjmnuiqgTc6O93cFGN26fTfKdUA4Orz0XV2j0SBoWeALff4ihE2iFpkyU
         zbNJXGEL0/C56uNIje2wA0TgKZw+aUbkeQsVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=T73LRqjBCAQIDAErfFmkGrNK1srLIWUTBWAxPP3SIZSl7eCetw2hkVfkkIW/1iVN27
         7Sk1mqbN6LvLzOs6Ret29OYQSmzr0q/+50FkdTJtXEd0SG924iLML4AOSbnpOdym/Cte
         RYo1K5/Z7+aRbisxWI/F6wofscbOhGb4MnYFU=
Received: by 10.141.197.14 with SMTP id z14mr1585296rvp.283.1220026286531;
        Fri, 29 Aug 2008 09:11:26 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Fri, 29 Aug 2008 09:11:26 -0700 (PDT)
In-Reply-To: <20080829152451.GA20629@yugib.highrise.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94307>

On Fri, Aug 29, 2008 at 6:24 PM, Aidan Van Dyk <aidan@highrise.ca> wrote:
> * Perry Wagle <wagle@cs.indiana.edu> [080801 00:00]:
>> Jeff King has convinced me that it's perfectly legitimate to introduce
>> non-upward compatibilities in minor version releases of "young"
>> software.
>
> This is the gist of the problem.  You keep hammering about a
> "non-upwards compatibilities in minor version releases", yet you have
> *not* pointed out one such in-compatibility in a minor version release..
>
> Remember, in git, 1.6 is a "major version" release, with release notes, etc.
> 1.5.X is a "minor version" release.
> 1.5.X.Y is a "patch" release.

What is X (2.0)?

-- 
Felipe Contreras
