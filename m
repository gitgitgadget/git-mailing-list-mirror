From: Rob Hoelz <rob@hoelz.ro>
Subject: Re: [PATCH] push: Alias pushurl from push rewrites
Date: Wed, 27 Mar 2013 12:20:59 -0500
Message-ID: <20130327122059.7e9da729@hoelz.ro>
References: <20130318220224.3b23a381@hoelz.ro>
	<20130318231043.GD5062@elie.Belkin>
	<7v38vsma9o.fsf@alter.siamese.dyndns.org>
	<20130319015541.GH5062@elie.Belkin>
	<7vwqt3i7p9.fsf@alter.siamese.dyndns.org>
	<5149AC88.9090206@hoelz.ro>
	<7vk3p2gmup.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	josh@joshtriplett.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 18:21:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKu2W-00082j-7D
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 18:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234Ab3C0RVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 13:21:04 -0400
Received: from hoelz.ro ([66.228.44.67]:39245 "EHLO mail.hoelz.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751457Ab3C0RVC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 13:21:02 -0400
Received: from localhost.localdomain (108-234-129-20.lightspeed.milwwi.sbcglobal.net [108.234.129.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.hoelz.ro (Postfix) with ESMTPSA id 00E53280F3;
	Wed, 27 Mar 2013 13:21:00 -0400 (EDT)
In-Reply-To: <7vk3p2gmup.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.9.0 (GTK+ 2.24.16; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219286>

On Wed, 20 Mar 2013 07:35:58 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Rob Hoelz <rob@hoelz.ro> writes:
> 
> > On 3/19/13 7:08 PM, Junio C Hamano wrote:
> >> Jonathan Nieder <jrnieder@gmail.com> writes:
> >>
> >>> Junio C Hamano wrote:
> >>>> Jonathan Nieder <jrnieder@gmail.com> writes:
> >>>>> Test nits:
> >>>>> ...
> >>>>> Hope that helps,
> >>>>>
> >>>>> Jonathan Nieder (3):
> >>>>>   push test: use test_config where appropriate
> >>>>>   push test: simplify check of push result
> >>>>>   push test: rely on &&-chaining instead of 'if bad; then echo
> >>>>> Oops; fi'
> >>>> Are these supposed to be follow-up patches?  Preparatory steps
> >>>> that Rob can reroll on top?  Something else?
> >>> Preparatory steps.
> >> OK, thanks.  I'll queue these first then.
> >>
> > Should I apply these to my patch to move things along?  What's the
> > next step for me?
> 
> You would fetch from nearby git.git mirror, find the tip of
> Janathan's series and redo your patch on top.  Perhaps the session
> would go like this:
> 
>     $ git fetch git://git.kernel.org/pub/scm/git/git.git/ pu
>     $ git log --oneline --first-parent ..FETCH_HEAD | grep
> jn/push-tests 83a072a Merge branch 'jn/push-tests' into pu
>     $ git checkout -b rh/push-pushurl-pushinsteadof 83a072a
>     ... redo the work, perhaps with combinations of:
>     $ git cherry-pick -n $your_original_branch
>     $ edit t/t5516-fetch-push.sh
>     ... and then
>     $ make test
>     $ git commit
> 

Ok, changes applied.  New patch coming.
