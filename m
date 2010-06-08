From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: DWIM "git checkout frotz" to "git checkout -b frotz
 origin/frotz"
Date: Tue, 8 Jun 2010 09:29:58 +0200
Message-ID: <20100608072958.GA24302@localhost>
References: <20100605110930.GA10526@localhost>
 <vpqljas5e33.fsf@bauges.imag.fr>
 <20100606164642.GA10104@localhost>
 <buobpbnz6mh.fsf@dhlpc061.dev.necel.com>
 <20100607185439.GB17343@localhost>
 <AANLkTilccgKxO7YCTJYc5rTzhov5Tku2z8jSfWU_B4ui@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Peter Rabbitson <ribasushi@cpan.org>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jun 08 09:30:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLtGP-0004z4-Kf
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 09:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914Ab0FHHaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 03:30:14 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65342 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036Ab0FHHaM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 03:30:12 -0400
Received: by fxm8 with SMTP id 8so2621938fxm.19
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 00:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=lrMu9+eKWtNDL3qzWkLfrqQKtRIUp4clhDobN+kI5PM=;
        b=HFMWUdV6Xm1dlapslrMpQJCtZF24XHm7/y1T3LQpZk7HfWoN3fbDn0wcKs/JapLPcL
         uLSdkcNVv5/apcTHfe6SNZvrw0MQS/bz3dxyGjyxEeCZmhsoxYo2VtYVOAsUNxyN/zS8
         S5Z04H6yostIVEiFoiEoWD7TaG1cdlBZggKXg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=AptqiUHGp6dWsC3ltprPZu9MFGWbQe0IVH1Ic4FIrSzb3EPfZG/pTyW6o1uoKGaOrq
         aDmdwSlr1UpH/ENBkoRkFQQpAViB1BM5wRP95QOjf/gV3sP+QZyLwjHnQx0KCBXmFcAV
         u4+Xl134+vBp2HPdMKje/7frQqraty4aHrcDY=
Received: by 10.223.5.89 with SMTP id 25mr16064919fau.87.1275982211266;
        Tue, 08 Jun 2010 00:30:11 -0700 (PDT)
Received: from darc.lan (p549A3632.dip.t-dialin.net [84.154.54.50])
        by mx.google.com with ESMTPS id 13sm24138854fad.19.2010.06.08.00.30.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Jun 2010 00:30:10 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OLtG2-0006a9-3u; Tue, 08 Jun 2010 09:29:58 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTilccgKxO7YCTJYc5rTzhov5Tku2z8jSfWU_B4ui@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148647>

On Tue, Jun 08, 2010 at 09:25:07AM +0900, Miles Bader wrote:
>
> > And it makes me sad that you think it silly to even talk about it.
> 
> I don't think it's silly to note your concern, I think it's silly to
> put a fair amount of effort into a campaign for its removal, which is
> what you are doing.  If new points can be made, fair enough, but so
> far it seems mainly a lot of back and forth stating the same things
> over and over.

Since I started this, I feel responsible for responding to people's
comments. I do not think I am doing anything wrong. So please
forgive me for responding to you as well, even if you think it
silly of me.

> > I believe that it's because of things like this that many users
> > still consider git to be complicated and hard to use. That's what
> > really bothers me.
> 
> Why do you think that?  I mean, you could be right, but it's certainly
> conceivable that this feature causes users to consider git _simpler_
> to use, because it lets them think about local branches only.

Thinking about local branches only is wrong.

Let's assume the user "just wants to check out branch X." Such a
use case has been mentioned previously in this thread. So they say
"git checkout X", and voila, they get what they wanted.

It did what they meant it to do. Everybody is happy. But not for
long.

Because the next time they "just want to check out branch X," they
will remember, it's time for "git checkout X." But what's this?
This is not what they wanted. It does not have the latest changes
on branch X! Didn't they do the same thing they did last time?

No they did not, because last time they _created a branch_.
Eventually, if they are lucky, they will learn in #git that they
were supposed to "git merge <remote>/X." And they will think "WTF?
Why do I have to _merge_? And what's this business about remotes?
Why is git is so complicated?"

So all we did was delay the user's confusion, and make it worse,
because now the mind model of "local branches only" they have
developed, is broken.

Git uses slightly different semantics than other VCSs, especially
when it comes to branches. And that often causes users to become
confused. But I happen to think that git's branch model is
superior, and easy to understand once you unlearn what you know
from other VCSs.

But if we try to hide that fact and imitate other VCSs on the
surface, that will only make it harder to learn.

Regards,
Clemens
