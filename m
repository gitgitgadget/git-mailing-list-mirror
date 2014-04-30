From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: Re: [PATCH] subtree/Makefile: Standardize (esp. for packagers)
Date: Tue, 29 Apr 2014 21:20:45 -0600
Message-ID: <20140430032045.GA4613@comcast.net>
References: <1398304336-1879-1-git-send-email-nod.helm@gmail.com>
 <CAHYYfeGNDLVxzP6zMyJnSi8GxpQaUKGAkqaLfXbZ=8B1k7vvyQ@mail.gmail.com>
 <3cb4338e-de68-404d-86dc-70cac7e13606@email.android.com>
 <20140426072520.GB7558@sigill.intra.peff.net>
 <6a7bcc79-d9c3-4cf8-8f3b-a6a16298c221@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: James Denholm <nod.helm@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 05:28:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfLCa-0005B8-VB
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 05:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbaD3D2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 23:28:52 -0400
Received: from qmta09.emeryville.ca.mail.comcast.net ([76.96.30.96]:47284 "EHLO
	qmta09.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751678AbaD3D2w (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Apr 2014 23:28:52 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Apr 2014 23:28:52 EDT
Received: from omta15.emeryville.ca.mail.comcast.net ([76.96.30.71])
	by qmta09.emeryville.ca.mail.comcast.net with comcast
	id w3MU1n0021Y3wxoA93Nn1t; Wed, 30 Apr 2014 03:22:47 +0000
Received: from mmogilvi.dynu.net ([50.183.52.75])
	by omta15.emeryville.ca.mail.comcast.net with comcast
	id w3Lm1n00F1dMQzW8b3Lm4S; Wed, 30 Apr 2014 03:20:47 +0000
Received: by mmogilvi.dynu.net (Postfix, from userid 501)
	id 0D0D31E960C8; Tue, 29 Apr 2014 21:20:45 -0600 (MDT)
Content-Disposition: inline
In-Reply-To: <6a7bcc79-d9c3-4cf8-8f3b-a6a16298c221@email.android.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1398828167;
	bh=5uBKokc7mmgSwUmEBMVtjfPHGaV6GWHpq5BjINmEp7c=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=NUcu8Mo2/68eKLFvRyaosGbVn+zv5uN9Yg+5PQgfZDpGs3dAMh9+/etg33d1CALgG
	 KX4/yfuLgiwTVuUCneENvO2Qlsg9w3s+L48pgtFio2WDq7Dq5DPqKChaQaPffSIq2F
	 6yutR0Z2X82nAQfO1mso9Ry+ahuvJlcErasrCe5WUTsopzVNhqzsZ2yf37fWFZhfiI
	 3CiS72LgdJx20LHnV96RQuCWlVsIuptpoLIEo4WMIZWRNONb1FvgDQ51vnJ+5Lg8ln
	 28souVGZ15MH3XEXZaPyZZwdWbMeK47hm/fowbWT3RAWJEtXqOV45Cf9UKLhcH0Wkk
	 jkXXwvoGEFdVg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247672>

On Sun, Apr 27, 2014 at 12:35:13PM +1000, James Denholm wrote:
> Jeff King <peff@peff.net> wrote:
> >I think the problem is that
> >contrib/subtree does not really have an active dedicated area
> >maintainer.
> 
> Yeah, I can see how that might become a bit of a problem. I was
> actually thinking of doing a bit of work on subtree beyond this
> specific patch, so hopefully that won't be a show-stopper. We'll
> see what happens, I guess.

Agreed.  It also doesn't help that when subtree patches are proposed
(especially new features instead of obvious bugs), there often seems
to be little or no feedback from anyone.

--------
Depending on how much time you have:

This may be outside the scope of work you were planning on, but
it might be worth grepping through old mailing list archives for
"subtree" patches that haven't been merged, and see if there is
anything worth revisiting/resubmitting.  I believe most of the
following (at least) kind of languished and died, often with little
or no real review and feedback:

http://marc.info/?l=git&m=138644067726844&w=2
http://marc.info/?l=git&m=138523794407181&w=2
  - My own series, plus another patch that has roughly the
    same description, but different semantics.

http://marc.info/?l=git&m=136321400525507&w=2
http://marc.info/?l=git&m=136321400525507&w=2
  - Some series from Paul Campbell.

http://marc.info/?l=git&m=136122107605036&w=2
http://marc.info/?l=git&m=135813589922554&w=2
http://marc.info/?l=git&m=136415434127550&w=2
http://marc.info/?l=git&m=136127692217856&w=2
  - Other series.

http://marc.info/?l=git&m=138557714926045&w=2
http://marc.info/?l=git&m=138129106613560&w=2
http://marc.info/?l=git&m=136415882128742&w=2
http://marc.info/?l=git&m=136415654228062&w=2
  - Miscellaneous

And probably others...

(I don't know if these are the latest or "best" versions of these, nor
have I really looked at them closely to decide if they are worth
including at all.  Be sure to exameine not just the discussion around
the specific patches, but also the other patches in each series...)

                     - Matthew Ogilvie
