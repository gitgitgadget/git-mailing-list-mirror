From: Junio C Hamano <gitster@pobox.com>
Subject: Re: tracking branch for a rebase
Date: Thu, 10 Sep 2009 21:54:13 -0700
Message-ID: <7vy6om2ia2.fsf@alter.siamese.dyndns.org>
References: <20090904135414.GA3728@honk.padd.com>
 <4AA124DD.1030208@drmicha.warpmail.net>
 <20090904181846.GC19093@coredump.intra.peff.net>
 <20090904185949.GA21583@atjola.homenet>
 <20090905061250.GA29863@coredump.intra.peff.net>
 <20090905140127.GA29037@atjola.homenet>
 <20090905142841.GB15631@coredump.intra.peff.net>
 <7vfxaz9wfi.fsf@alter.siamese.dyndns.org>
 <20090907084324.GB17997@coredump.intra.peff.net>
 <alpine.DEB.1.00.0909071126040.8306@pacific.mpi-cbg.de>
 <20090909104550.GA20108@coredump.intra.peff.net>
 <7vzl93cncn.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0909100941330.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 11 06:54:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mly9v-0001U6-Kr
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 06:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbZIKEya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 00:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbZIKEy3
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 00:54:29 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45334 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbZIKEy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 00:54:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 833C84C5AF;
	Fri, 11 Sep 2009 00:54:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mX1/FcmkNvd/0Z/XTa9m98DZADc=; b=qDrF/v
	ppkGIZT3K+MQPkUmqRvkt3RUY1Mwpjzk0wiDUHzUDrvBwJ/x3GsF/lWVgYaw8Wrr
	iEjoabNQzIlHROKeU6WfwnIggola6M36O7vh89eY2BasH2/xc+RBlpZE8ny/BUmR
	u3TwB5vg2+Y6SBF3ETOBNvYrXbTWacAcJCmcw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U3yfmDrUJMkW32QYBt8yfs0/fl7fkD9a
	jYLbzk3aoQSaRtavf0rBEtJpXcRghTzeVU6ozBkwhAqTXAJpueDMSs934XtlzWhh
	h6bvWYHm1Do59RSNhHc8V7r3/RXHDTkmLYYDjU5SwqeeYsGpgQFWNiaeM3Pa4Ko/
	CiR1Dov3Rpo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2EFE04C5AD;
	Fri, 11 Sep 2009 00:54:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B46C84C5AA; Fri, 11 Sep 2009
 00:54:15 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0909100941330.8306@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Thu\, 10 Sep 2009 09\:47\:52 +0200
 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2D13886A-9E8F-11DE-9F50-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128168>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> How about ^^branch? *ducks*

You'd better duck.

Just like %branch, it is a selfish and short-sighted "good enough for this
particular case but there is no room for extending it" hack that I have
serious problem with.  It closes the door for people who come later, and
such an attitude is okay only if this is _the last great invention_ and
there is no more great feature that deserves short-and-sweet notation to
come.  It might be the _latest_ great invention, but chances are that it
won't be the last.

> Seriously again, I think that ^{tracking} (with shorthand ^t, maybe) is 
> not too shabby an option.  The point is: if we make this unattractive 
> enough by requiring a lot of typing, we will never get to the point where 
> it is popular enough to make a shorthand: it just will not be used at all.

I actually think it is the other way around.

If it is so useful to be able to specify the ref your branch is based on
by applying a magic to the name of your branch, the users will use it even
if it is rather long to type, as long as the feature is easy to discover
and remember, and then they will demand a short-hand.

If on the other hand users say "Hey, I know can say 'git log X@{upstream}'
but why bother?  I always build my branch X on top of origin/X anyway, so
I'd forego that feature and type 'git log origin/X'.  It's not worth my
time to type that long magic," then the feature is not as useful as you
hoped.  And there is no point in coming up with a short-hand syntax for
it.

I personally suspect that users love to use the feature _despite_ the
initial lack of short-hand, and we would end up adding some short-hand,
and that would be a far better proof that the feature itself is useful
than "it is used just %X happens to be shorter than origin/X".

But before that happens, I'd rather not waste short-hand notations, such
as @{t} or @{u}, that will be in short-supply in the longer term.
