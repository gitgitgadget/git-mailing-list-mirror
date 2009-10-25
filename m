From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 0/2] user-manual: new "getting started" section
Date: Sun, 25 Oct 2009 06:14:38 -0500
Message-ID: <20091025111438.GA11252@progeny.tock>
References: <1256377489-16719-1-git-send-email-felipe.contreras@gmail.com>
 <7vy6n065os.fsf@alter.siamese.dyndns.org>
 <7vr5ss64e5.fsf@alter.siamese.dyndns.org>
 <94a0d4530910241316r3fc4136emd036d18aa45a4192@mail.gmail.com>
 <7vy6n02mrk.fsf@alter.siamese.dyndns.org>
 <94a0d4530910250243k4cbc3c18l5e018a05e5afdb2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Hannu Koivisto <azure@iki.fi>, Jeff King <peff@peff.net>,
	Wincent Colaiuta <win@wincent.com>,
	Matthias Lederhofer <matled@gmx.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 12:05:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N20ud-00005T-E8
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 12:05:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322AbZJYLFE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Oct 2009 07:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753311AbZJYLFE
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 07:05:04 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:42780 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753299AbZJYLFC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 07:05:02 -0400
Received: by ywh40 with SMTP id 40so7550931ywh.33
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 04:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=bLdjqkoFVv5pY9TyjxgdcRsj55emm4ysiIxtiNd9Thc=;
        b=Z6oNAf6ClilXL+O/W3v3e9DCWqFP2fgQa9GFnO47knDQIQydOw7M8wv78Nyi/rjyie
         4RfoHmdWHz/Np7iSHzwdrPJU2/QNCtTUEABG2cTuGWyBYunx4KZSEzEl0BNvrPMeQeQz
         i27yXJWrX9FWFzqp/8cMVCAPVeT7ycJuSE01s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=OZsgxh8P9Fnhh65LxXPQ6pehkiCmdW4SHhiZg749ExPPyERnl62GUa3/68tmFTcWoi
         YRArxzN7vGJaH50Z0ty4TQRgX1763Po7ztKTeEs/+SqXe+38gXh47qamTPmuKWUhvNs4
         N0yCtH4FUBh67GA3u81Bwcbl7TTd1/yDT1jAk=
Received: by 10.101.56.19 with SMTP id i19mr8258527ank.134.1256468706354;
        Sun, 25 Oct 2009 04:05:06 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm968487yxe.21.2009.10.25.04.05.04
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 04:05:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <94a0d4530910250243k4cbc3c18l5e018a05e5afdb2d@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131198>

Hi Felipe,

=46elipe Contreras wrote:

> I disagree. I think it's awfully useful to have color.ui =3D auto
> configured before reading the multitude of 'git branch', 'git show',
> and 'git diff' commands that are presented on first two sections. So
> useful, in fact, that I think it should be enabled by default.

This is why I think you had a good idea here.  When a program doesn=E2=80=
=99t
behave as I would like, it can be very comforting to know where its
dotfile is and be able to edit it (I=E2=80=99m not sure how I learn thi=
s for
most programs).  And it is much easier to parse git output without
reading it all when color is turned on, so that is a setting I imagine
could be useful to people.

On the other hand, it is far more pleasant to use a program that
doesn=E2=80=99t need configuration at all.  And as I mentioned before, =
it is
best to avoid wasted time at the beginning of the manual.

> Supposing that color.ui is 'auto' by default,

Should it be?  I think it would not be too hard to detect a color
terminal by checking $TERM.  Are many people bothered by color?  Do we
need some way to make it more obvious how to turn color _off_?

> No, but "improving" needs "changing", and the discussion I see is
> biased towards "not changing".
[...]
> I don't think the user manual is achieving that purpose. I don't know
> if it's the user manual's fault, or git's UI. Both areas need a lot o=
f
> improvement (as the git user survey suggests), and I've tried to
> improve both with a lot resistance in both. So I'm not very hopeful
> anymore.

I hope you have not misunderstood.  I cannot speak for everyone else
here, but I know I am happier when (1) fixes match problems to be
solved in a documented way and (2) fixes do not unnecessarily break
unrelated habits.  One way to bring this about is to justify each
change by explaining what real problem it will solve and how it avoids
collateral damage.  Without that justification, a change is indeed
dangerous and might be worth resisting until it gets clarified.  But
this is not meant to prevent fixes from occuring at all.

Could you list some UI patches that were overlooked or not properly
addressed?  Maybe people just forgot about them or were waiting for an
updated version, or maybe the problems some solve weren=E2=80=99t artic=
ulated
clearly yet.  I would be glad to help out in any way I can.

> However, I haven't met any proficient git user that got to that point
> by reading the user manual, so I think it must be completely
> re-thought.

I have met one.  (Well, he read the git tutorial and learned by using
git, too.)  I think the user manual=E2=80=99s pretty well written, thou=
gh it
certainly has its gaps and rough spots.

> Judging from the luck I've had pushing even the simplest
> changes I don't think it will improve much more, unfortunately.

Even the simplest changes can be hard.  But I hope they do not amount
to nothing.  I hope at the very least the git-config manual page will
improve...

Thank you for working on this.  I hope you succeed in improving git=E2=80=
=99s
usability, one way or another.

Regards,
Jonathan
