From: Josef Wolf <jw@raven.inka.de>
Subject: Re: Re-Transmission of blobs?
Date: Thu, 12 Sep 2013 09:42:41 +0200
Message-ID: <20130912074241.GC14259@raven.wolf.lan>
References: <20130910130837.GA14259@raven.wolf.lan>
 <xmqqsixcy395.fsf@gitster.dls.corp.google.com>
 <20130911112758.GB14259@raven.wolf.lan>
 <xmqqsixbth4h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 12 09:50:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VK1fO-0008F0-Ok
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 09:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753717Ab3ILHuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 03:50:13 -0400
Received: from quechua.inka.de ([193.197.184.2]:54517 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751591Ab3ILHuM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 03:50:12 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1VK1fH-0005Xq-G4; Thu, 12 Sep 2013 09:50:11 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id 55AF07638E; Thu, 12 Sep 2013 09:42:41 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqqsixbth4h.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234628>

On Mi, Sep 11, 2013 at 10:14:54 -0700, Junio C Hamano wrote:
> Josef Wolf <jw@raven.inka.de> writes:
> > On Di, Sep 10, 2013 at 10:51:02 -0700, Junio C Hamano wrote:
> >> Consider this simple history with only a handful of commits (as
> >> usual, time flows from left to right):
> >> 
> >>               E
> >>              /   
> >>     A---B---C---D
> >> 
> >> where D is at the tip of the sending side, E is at the tip of the
> >> receiving side.  The exchange goes roughly like this:
> >> 
> >>     (receiving side): what do you have?
> >> 
> >>     (sending side): my tip is at D.
> >> 
> >>     (receiving side): D?  I've never heard of it --- please give it
> >>                       to me.  I have E.
> >
> > At this point, why would the receiving side not tell all the heads it knows
> > about?
> 
> It did.  The receiving end had only one branch whose tip is E.  It
> may have a tracking branch that knows where the tip of the sending
> end used to be when it forked (which is C), so the above may say "I
> have E and C".  It actually would say "I have B and A and ..." for a
> bounded number of commits, but that does not fundamentally change
> the picture---the important point is it is bounded and there is a
> horizon.

Therefore, the sending sinde has all information it needs to do any
optimizations you can think of...

> >> There are some work being done to optimize this further using
> >> various techniques, but they are not ready yet.
> 
> And this still stands.

Do you have a pointer or something? I'd like to check out whether I can
contribute to this work.

-- 
Josef Wolf
jw@raven.inka.de
