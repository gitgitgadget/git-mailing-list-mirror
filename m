From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Dropping '+' from fetch = +refs/heads/*:refs/remotes/origin/*?
Date: Mon, 5 Sep 2011 14:14:57 -0700
Message-ID: <CAJo=hJvFSegSzTOMj824PoG=soj75JMChfRnjyz4rNgUcVM=Jw@mail.gmail.com>
References: <7vliu8w25g.fsf@alter.siamese.dyndns.org> <20110902000039.GB9339@sigill.intra.peff.net>
 <4E6088F9.5070102@drmicha.warpmail.net> <20110902152947.GB19213@sigill.intra.peff.net>
 <7v4o0uncq0.fsf@alter.siamese.dyndns.org> <20110902162524.GC19690@sigill.intra.peff.net>
 <CAJo=hJtuUe1ajjW9dNU4JzjE+P94a42W7ZvC+iQBQTeGXVvS8Q@mail.gmail.com>
 <20110905204729.GB4221@sigill.intra.peff.net> <CAJo=hJtvU+ujYBMvrgVJpBdaTUq+NOsQwVFkL-A4pHv-CRPdDg@mail.gmail.com>
 <20110905205735.GA5578@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 05 23:15:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0gVp-0005qt-Fm
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 23:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371Ab1IEVPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 17:15:20 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62488 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950Ab1IEVPS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 17:15:18 -0400
Received: by iabu26 with SMTP id u26so6741998iab.19
        for <git@vger.kernel.org>; Mon, 05 Sep 2011 14:15:17 -0700 (PDT)
Received: by 10.43.48.198 with SMTP id ux6mr4127572icb.227.1315257317134; Mon,
 05 Sep 2011 14:15:17 -0700 (PDT)
Received: by 10.42.163.70 with HTTP; Mon, 5 Sep 2011 14:14:57 -0700 (PDT)
In-Reply-To: <20110905205735.GA5578@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180763>

On Mon, Sep 5, 2011 at 13:57, Jeff King <peff@peff.net> wrote:
> On Mon, Sep 05, 2011 at 01:53:42PM -0700, Shawn O. Pearce wrote:
>
>> > Sure. I'm totally open to the idea of making the non-fast-forward
>> > warning more obvious. Suggestions for wording (though I am tempted by
>> > "HEY STUPID" above ;) )?
>>
>> I'm not suggesting all non-fast-forward should issue a bigger warning.
>> pu updates daily with a non-fast-forward. That isn't useful.
>>
>> But if the local reflog hints that this reference almost never does a
>> non-fast-forward, and then it does, that should be a big warning.
>
> Right. What I mean is, what should the bigger warning look like?

Its a bikeshed. I refuse to paint bikesheds. :-)

> Also, you suggested caching to avoid looking through the whole reflog
> each time. I think you could probably just sample the last 10 or so
> reflog entries to get an idea.

Good point. 10 or so last records might be representative of the
branch's recent behavior, which is all that matters to the user who
wants this warning.

-- 
Shawn.
