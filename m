From: "Whit Armstrong" <armstrong.whit@gmail.com>
Subject: Re: git failure on Solaris t3701-add-interactive.sh -- git version 5cc8f372509298d13632d8784bc851a587937550
Date: Tue, 1 Apr 2008 03:02:15 -0400
Message-ID: <8ec76080804010002x79aa003ala9a1f66147157b85@mail.gmail.com>
References: <8ec76080803250529i5765cc9ar2d6fc3356800cb14@mail.gmail.com>
	 <8ec76080803250534x5373b0c6p6165a7dc17971e4a@mail.gmail.com>
	 <20080325234033.GA18348@coredump.intra.peff.net>
	 <8ec76080803260519s6088b773qc3a9cf982993f53@mail.gmail.com>
	 <20080326183453.GA4471@coredump.intra.peff.net>
	 <8ec76080803261357n1a07e4b7p5103901fdeef4458@mail.gmail.com>
	 <20080331072713.GA11490@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Jeff King" <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 01 09:03:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgaWK-00010J-16
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 09:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbYDAHCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 03:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751963AbYDAHCR
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 03:02:17 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:41507 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbYDAHCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 03:02:16 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1970826wff.4
        for <git@vger.kernel.org>; Tue, 01 Apr 2008 00:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=wdvLjJGpEdr1W4wdlI+mLYpAij98kevyQ+sBoYkPR0w=;
        b=DIZhUPXg+PnZEVmxrDQaYuO/WJ5Yijnb2qruLn+uC47qnRy9KbHfwsJPWmxOmE+CXEcfv2sVIa2qnPH24wKn6Px0quW7pgfu4sldJ2AYCo13szHJuQe4OGH1MKjH6VLKuB+Xjnv4ly8HGmA+0QZUdb8IO5JqsrJfLGiu01lGaoM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PoTi5fo9pm3HJMmjNw8pgmpT/FkZQ9f4WmKVTkr+WODSjToD2ORYfMQN/ejk1k2L+e8Uo+LkYf+nlmkIvZAo+XTq0brZpvnzRZWBQvE/YLzmi2E073AroUbHjs+eZaCsWHNmXFHL4NC0IvZpknfYTRaUPI1fLCYikKRxL/OJpVE=
Received: by 10.142.127.10 with SMTP id z10mr4468907wfc.122.1207033335709;
        Tue, 01 Apr 2008 00:02:15 -0700 (PDT)
Received: by 10.142.187.13 with HTTP; Tue, 1 Apr 2008 00:02:15 -0700 (PDT)
In-Reply-To: <20080331072713.GA11490@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78636>

Peff,

Thanks for looking.  I'm sure you have been busy preparing for the next release.

Sorry for the list omission on the last email, it was an oversight.

I just did the test suite on origin/next, so this test run was done
with git b0a67ea72573692994090d92e300cddaf20ac69d.

and here is the list of tests that are failing:

#       deleted:    t/t3701-add-interactive.sh
#       deleted:    t/t3900-i18n-commit.sh
#       deleted:    t/t3901-i18n-patch.sh
#       deleted:    t/t4116-apply-reverse.sh
#       deleted:    t/t4200-rerere.sh
#       deleted:    t/t5000-tar-tree.sh
#       deleted:    t/t7400-submodule-basic.sh
#       deleted:    t/t7401-submodule-summary.sh
#       deleted:    t/t7501-commit.sh
#       deleted:    t/t9001-send-email.sh

I'll send -v -i details on the ones that fail for me but not for you.

-Whit



On Mon, Mar 31, 2008 at 3:27 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Mar 26, 2008 at 04:57:38PM -0400, Whit Armstrong wrote:
>
> > Peff,
>
> [I think the list might benefit from our discussion; did you mean to
> respond off-list?]
>
> Sorry for the slow response...I haven't had much time to look at this
> stuff lately. This is an "off the top of my head" response; a lot of my
> points will need followup patches and testing.
>
>
> > I have failures with the following tests on our Solaris setup.
> > However, I did use a more recent version of perl (5.10 installed in my
> > home dir) with these tests.
> >
> > #       deleted:    t/t3900-i18n-commit.sh
> > #       deleted:    t/t3901-i18n-patch.sh
>
> I think something is lacking in the Japanese charset support on Solaris.
> Maybe there is some extra package that needs to be installed. I haven't
> looked much further.
>
>
> > #       deleted:    t/t4116-apply-reverse.sh
>
> This is due to a warning from Solaris tar, which doesn't like the pax
> field in our generated tarfile. I think it's just being used to make a
> copy of the tree, so we can probably get around it by using
> git-checkout-index directly. More portable, and should be faster.
>
>
> > #       deleted:    t/t4118-apply-empty-context.sh
>
> I don't have this in my list of broken tests. Might just be an
> oversight on my part, though.
>
>
> > #       deleted:    t/t4200-rerere.sh
>
> This definitely passed for me, since I submitted fixes. But there was
> much discussion afterwards, so one of the followups might have re-broken
> it.
>
>
> > #       deleted:    t/t8001-annotate.sh
>
> I'm pretty sure this passed for me.
>
>
> > #       deleted:    t/t9001-send-email.sh
>
> I couldn't even try this because of the perl version issues.
>
>
> > this is using origin/pu -- commit 9606c1c61e3a5b5acbb3f3dcccea37e00bcca145
>
> Yikes. I would stick with 'next' at the most. Junio makes sure all tests
> work (on Linux) on 'master', and I think 'next'. But 'pu' is a no-man's
> land of quality.
>
>
> > Let me know if you want test.sh -v -i output for these.
>
> For the ones that I marked as "passed", sure. For the other ones, either
> we have the same failure, in which case I can generate it myself, or we
> don't, in which case I need to fix my bug before your bug will make any
> sense to me. :)
>
>
> > Also, is there a way to ask "make test" to continue the test suite
> > from a certain point?  I kept deleting the test that was failing, and
> > then restarting the whole "make test," which I'm sure you know is
> > quite long to run from start to finish.
>
> No, there isn't. During my test-fixing spree, I just did something like:
>
>  make test
>  # oops, we failed in 3900; continue after
>  make test t390[123]*.sh t4*.sh t5*.sh ...
>
> and so forth, shrinking my commandline each time. Hack-ish, but what
> we're doing is probably not worth implementing the 'resume at last
> failure' feature (especially because most of the time you are fixing
> _git_, not the test scripts, so it is a good idea to run the whole
> suite).
>
> What I'd really like is the ability to run the test scripts in parallel;
> test-lib.sh would need to put each in its own directory.
>
> -Peff
>
