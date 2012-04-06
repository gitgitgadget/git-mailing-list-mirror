From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: push.default: current vs upstream
Date: Fri, 6 Apr 2012 22:03:25 +0400
Message-ID: <CAHkcotgiNyaSRr-AH2j7GXjwXVSKToegZbycLWitv1tEfW6uSg@mail.gmail.com>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
	<20120329095236.GA11911@sigill.intra.peff.net>
	<7vbonfqezs.fsf@alter.siamese.dyndns.org>
	<20120329221154.GA1413@sigill.intra.peff.net>
	<7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
	<20120330071358.GB30656@sigill.intra.peff.net>
	<7vty15ltuo.fsf@alter.siamese.dyndns.org>
	<vpqty12h995.fsf@bauges.imag.fr>
	<20120405131301.GB10293@sigill.intra.peff.net>
	<vpqwr5uceis.fsf@bauges.imag.fr>
	<CAHkcotjrVqvYnAV5U7gPngbW0saghAv8vZB3jh=dOKLPmYdJrQ@mail.gmail.com>
	<CANgJU+VM4Dz3-EGa6z4hB8hB7ZvaahrG8tb5VCCzWQ=7zohBFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 20:03:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGDVX-0002FD-F4
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 20:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757603Ab2DFSDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 14:03:30 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38608 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754386Ab2DFSD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 14:03:29 -0400
Received: by pbcun15 with SMTP id un15so2859509pbc.19
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 11:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=eb6nZRilfHrgGZe1m7jeKLh0FD8DKnvpt4Ppz8WacTs=;
        b=PF48K2Nh3ASgzXhRqxfPO9mXT0NzkdrW9NsmhhdAi9SKr8jroHN5e9gLYsfL9HhKRT
         erfrg54oodFBfko79HY8v6Z7gCldxky/3uQpQR/Eyo2Q7S6VROAk+wo4OSQB8nTbztgu
         sIckJIODk+eqyP5vjlwbr/fXiygMpYtrAi3SxeUagyhUVf3gG9F9NovRc/JZ6QjvlTmI
         w2XLoneef+4T3IwrPqTghqcPHMsouCEbqk0UoWx4RfHxuiQuRvt/+Ds+KGwD2al9CaZK
         Q2ZvqW+4MS7oJ96nQyI4AUi+pZkPv/Sz3C0aoKrY6ENHfmn6XSd/nFLCIXvJGG2ETL9x
         oX0w==
Received: by 10.68.136.41 with SMTP id px9mr17292300pbb.147.1333735405472;
 Fri, 06 Apr 2012 11:03:25 -0700 (PDT)
Received: by 10.143.66.9 with HTTP; Fri, 6 Apr 2012 11:03:25 -0700 (PDT)
In-Reply-To: <CANgJU+VM4Dz3-EGa6z4hB8hB7ZvaahrG8tb5VCCzWQ=7zohBFA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194890>

On Fri, Apr 6, 2012 at 5:36 PM, demerphq <demerphq@gmail.com> wrote:
> On 6 April 2012 13:38, Dmitry Potapov <dpotapov@gmail.com> wrote:
>> Seriously, why do you care about beginners who use a centralized workflow
>> and not beginners who have to use with existing projects that use more or
>> less distributed workflow,
>
> Because the former are unlikely to be self-selected users of git and
> instead are likely to be forced to use git because their $work has
> dictated it to be so.

Any decision is made by people. On its own, $work does not dictate what
VCS or what workflow should be used. There are many ways for those who
are in charge to screw up things. And a centralized workflow is not very
scalable and many bad practices associated with it. While it is not easy
to to convert a CVS/SVN repository to git that alone does not bring most
of git advantages, because those advantages come from the workflow.

> The self-selected users of git IMO would tend to
> both have the motivation and the basic skills to learn whatever they
> need and are unlikely to blame their mistakes on git. The ones forced
> to use git are *very* likely to say "git is broken", or "git doesn't
> work" and then start arguing that "cvs never had that problem". Do you
> really want a bunch of users of your software thinking CVS was
> superior?

Git is a distributed version control system. There is another VCS whose
whole designed was dictated by being a better CVS. It's called SVN and
if someone is happy with it, why do not use it?

I think git default settings should respect the main goal of git design:
a good support of a distributed workflow. Certainly git can be used in
many other ways: some people use it with a centralized workflow, some
use it to back up their configuration files, etc.. But those usage
should not dictate the default settings for git.

Dmitry
