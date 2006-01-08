From: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
Subject: Re: git pull on Linux/ACPI release tree
Date: Mon, 9 Jan 2006 00:06:11 +0100
Message-ID: <20060108230611.GP3774@stusta.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com> <Pine.LNX.4.64.0601081111190.3169@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	"David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>,
	linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	akpm-3NddpPZAyC0@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
X-From: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org Mon Jan 09 00:06:29 2006
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Envelope-to: glad-acpi-devel-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Evjc8-0003lW-Tm
	for glad-acpi-devel-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org; Mon, 09 Jan 2006 00:06:18 +0100
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org via listexpand
	id S1161227AbWAHXGN (ORCPT <rfc822;glad-acpi-devel@m.gmane.org>);
	Sun, 8 Jan 2006 18:06:13 -0500
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org id S1161233AbWAHXGN
	(ORCPT <rfc822;linux-acpi-outgoing>); Sun, 8 Jan 2006 18:06:13 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14608 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161227AbWAHXGM (ORCPT <rfc822;linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>);
	Sun, 8 Jan 2006 18:06:12 -0500
Received: (qmail 18141 invoked from network); 8 Jan 2006 23:06:11 -0000
Received: from r063144.stusta.swh.mhn.de (10.150.63.144)
  by mailhub.stusta.mhn.de with SMTP; 8 Jan 2006 23:06:11 -0000
Received: by r063144.stusta.swh.mhn.de (Postfix, from userid 1000)
	id CCF8D1479D3; Mon,  9 Jan 2006 00:06:11 +0100 (CET)
To: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601081111190.3169-hNm40g4Ew95AfugRpC6u6w@public.gmane.org>
User-Agent: Mutt/1.5.11
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Precedence: bulk
X-Mailing-List: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Sun, Jan 08, 2006 at 11:41:28AM -0800, Linus Torvalds wrote:
>...
> What I object to is that there were _also_ two automated merges within ten 
> hours or each other, with absolutely _zero_ development in your tree in 
> between. Why did you do that in your development tree? By _definition_ you 
> had done zero development. You just tracked the development in _my_ tree.
>...

My impression is that you and Len are talking at different levels.

I can't speak for Len, but let me try to describe a problem in this area 
I don't know the solution for:

Consider I want to do the following:
1. update my tree daily from your tree
2. include 10 patches per week into my tree
3. ask you once a month to pull from my tree

How should step 1 be done?

In CVS, I'd do a "cvs update -dP ."
In cogito, the equivalent command seems to be "cg-update".

CVS has no problems if I have changed MAINTAINERS in one place and it 
changes daily in your tree in other places, but how do I do the same in 
git/cogito without creating the merges you don't want to see?

The solution might be described somewhere in TFM, but this is the class 
of problems people like me run into when the goal is simply a git tree 
to both track your tree and send changes to you without any interest in 
advanced SCM knowledge.

> 		Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
