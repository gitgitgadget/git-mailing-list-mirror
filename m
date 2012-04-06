From: demerphq <demerphq@gmail.com>
Subject: Re: push.default: current vs upstream
Date: Fri, 6 Apr 2012 15:36:18 +0200
Message-ID: <CANgJU+VM4Dz3-EGa6z4hB8hB7ZvaahrG8tb5VCCzWQ=7zohBFA@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 15:36:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SG9Kz-0003hv-MW
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 15:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757215Ab2DFNgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 09:36:19 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59061 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753971Ab2DFNgT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 09:36:19 -0400
Received: by yhmm54 with SMTP id m54so1257453yhm.19
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 06:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3wSjKlYGvAL2p9ig8wvh0DOt6wrJmNxpXQ0UJRea3ng=;
        b=Dkn0C7ntm3nuwCYi+zRR69X6rLEhofIlwEj0c4cKAHw0BuBEKOSg4DnKKb142F3jcs
         WQUydJ7WtkE9owS/pevq1iIYO2e6mnEVc/VvXq69rS5XI331Yq8DsSK13o4bcZDytavb
         BvtKcW/Cb2YmAYq6O000VwDVk3dhqmkxnRHW8mC6cboN/5W9rmnuvnRX3yVP9gGxd1fe
         DIJblyHAaXN+ZoDWQhC7AbS4uYEW5Pilnb+3NAZKV3QsEed53tfg1I8vOmb1+WK6cuLj
         JFon6maTnNoMeyUQ9IMzsIYddB0oeBnXhQ91p42PBiH9rrbAJN4T06LpJHROGHilLGwX
         sn2Q==
Received: by 10.236.195.34 with SMTP id o22mr6948444yhn.75.1333719378694; Fri,
 06 Apr 2012 06:36:18 -0700 (PDT)
Received: by 10.236.78.103 with HTTP; Fri, 6 Apr 2012 06:36:18 -0700 (PDT)
In-Reply-To: <CAHkcotjrVqvYnAV5U7gPngbW0saghAv8vZB3jh=dOKLPmYdJrQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194872>

On 6 April 2012 13:38, Dmitry Potapov <dpotapov@gmail.com> wrote:
> Seriously, why do you care about beginners who use a centralized workflow
> and not beginners who have to use with existing projects that use more or
> less distributed workflow,

Because the former are unlikely to be self-selected users of git and
instead are likely to be forced to use git because their $work has
dictated it to be so. The self-selected users of git IMO would tend to
both have the motivation and the basic skills to learn whatever they
need and are unlikely to blame their mistakes on git. The ones forced
to use git are *very* likely to say "git is broken", or "git doesn't
work" and then start arguing that "cvs never had that problem". Do you
really want a bunch of users of your software thinking CVS was
superior?

I would say the right default is the one that keeps idiot users happy,
and has the least "out of the box surprises" for them. The smart ones
will figure things out anyway and configure their tools appropriately.

cheers
Yves




-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
