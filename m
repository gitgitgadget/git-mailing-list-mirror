From: Wolfgang Denk <wd@denx.de>
Subject: Re: Cannot install git RPM
Date: Wed, 10 Aug 2005 21:44:58 +0200
Message-ID: <20050810194458.1F1F5353C12@atlas.denx.de>
References: <20050810162307.GE8041@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Ryan Anderson <ryan@michonline.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 10 21:46:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2wWA-0005Ka-Lp
	for gcvg-git@gmane.org; Wed, 10 Aug 2005 21:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbVHJTp3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Aug 2005 15:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbVHJTp3
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Aug 2005 15:45:29 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:36496 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1030219AbVHJTp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2005 15:45:29 -0400
Received: from fwd19.aul.t-online.de 
	by mailout06.sul.t-online.com with smtp 
	id 1E2wVk-0002qm-02; Wed, 10 Aug 2005 21:45:12 +0200
Received: from denx.de (VgwhRYZTge8Y041XKqlqOMq87yIpeYMA0Nv+dwjQR05G30dMoqOxw4@[84.150.65.8]) by fwd19.sul.t-online.de
	with esmtp id 1E2wVY-0qcfHk0; Wed, 10 Aug 2005 21:45:00 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 7A7A342CB2; Wed, 10 Aug 2005 21:44:58 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 1F1F5353C12;
	Wed, 10 Aug 2005 21:44:58 +0200 (MEST)
To: Chris Wright <chrisw@osdl.org>
In-reply-to: Your message of "Wed, 10 Aug 2005 09:23:07 PDT."
             <20050810162307.GE8041@shell0.pdx.osdl.net> 
X-ID: VgwhRYZTge8Y041XKqlqOMq87yIpeYMA0Nv+dwjQR05G30dMoqOxw4@t-dialin.net
X-TOI-MSGID: a57a482a-1efd-47b6-96bb-53eb0bc5332e
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

In message <20050810162307.GE8041@shell0.pdx.osdl.net> you wrote:
> * Wolfgang Denk (wd@denx.de) wrote:
> > It's then the "perl(Email::Valid)" and "perl(Mail::Sendmail)"  depen-
> > dencies  which  cause  problems.  I  installed  all perl packages and
> > modules I was able to find in the standard FC places,  but  this  did
> > not solve the problem. Maybe this is actually a bug in Fedora Core ?
> 
> No, you probably missed the earlier thread on this.  It's not a bug,
> those are real dependencies which rpm automagically discovers (along
> with things like shared library dependencies).  The issue is the
> git-send-email-script uses Mail/Sendmail.pm and Email/Valid.pm which
> aren't part of standard install.  Your choices are to grab the relevant

They are not only not part of a standard installation, but:

o I was not able to find any perl modules in the  whole  Fedora  Core
  distribution that satisfied these dependencies.

o Manually  installing  Email::Valid  and  Mail::Sendmail  (plus  the
  required  prerequisites)  from  CPAN  worked  find,  but  RPM still
  complains.

> packages, do an install with --nodeps (and know that

That's what I did.

> git-send-email-script will not work), make a subpackage for that script

But it will work, as the required Perl modules are installed.


My problem is that I cannot satisfy the dependencies in a  way  which
gets visible to RPM. And this is where I feel this is a bug in Fedora
Core. But probably I'm just too dumb.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A mouse is an elephant built by the Japanese.
