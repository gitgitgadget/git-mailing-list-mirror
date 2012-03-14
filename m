From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Wed, 14 Mar 2012 20:47:23 +0300
Message-ID: <CAHkcothjDBP+cyGRf--mNgwF5Sp2UiR3Gq1Vb-XwsKmMH_JCvA@mail.gmail.com>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
	<1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
	<1331288715.21444.38.camel@beez.lab.cmartin.tk>
	<4F5A4C45.7070406@xiplink.com>
	<4F5AF1A8.4050604@alum.mit.edu>
	<4F5E12A5.6030701@xiplink.com>
	<vpqzkblixmb.fsf@bauges.imag.fr>
	<20120312183725.GA2187@sigill.intra.peff.net>
	<vpqy5r44zg7.fsf@bauges.imag.fr>
	<CAHkcotg1FKxfMR4Fe9Xfo_i4nuxzXdfVWe80HZu0wQEkiXhhmA@mail.gmail.com>
	<vpqhaxrzh2a.fsf@bauges.imag.fr>
	<CAHkcotgMgqr29WEQfiH+89JVbTAAQyLwscXRtTyrf3JRxEuVbA@mail.gmail.com>
	<vpqhaxrz1c6.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Marc Branchaud <marcnarc@xiplink.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Mar 14 18:47:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7sIN-00071D-Cx
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 18:47:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761306Ab2CNRr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 13:47:26 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39548 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761133Ab2CNRrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 13:47:25 -0400
Received: by eaaq12 with SMTP id q12so1136457eaa.19
        for <git@vger.kernel.org>; Wed, 14 Mar 2012 10:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4H2zzVcmM8cYPtCDwzSM/E7s/y12/QMrctkSt5bZS3s=;
        b=nnZqalpRXTwgO0jhU6480Vlq4vGkp7BezZQ6f+nVlxAWoRvlmWxgqaPxLUATBrOTIs
         Rkjzr7s5iQHal3EOB0ioKTbylKjGLhRO5BBIMDVsPRIzJ0H0gvzKGUngZEecNg8WbsBN
         /VWYw5Wv0P05Ys+7Xgf5u1O1kHAFrziF+afNJ5I4Ld/5YtfhqEHIo6aN28FJlHVJJ6ti
         gjS8IhtJyRaIzEwxXS4oD74G58ds60qTM8Z3UnWRiN3JLvPIl56+Pfi0A3m80dB2uosm
         c/5tgw9DZnUANMkm8X5IF00JLHs44+vu+2sBxXRJDIQ5KKEGwx9Py/8GyGv2153likJE
         zbuA==
Received: by 10.224.59.208 with SMTP id m16mr4148991qah.37.1331747243910; Wed,
 14 Mar 2012 10:47:23 -0700 (PDT)
Received: by 10.229.135.130 with HTTP; Wed, 14 Mar 2012 10:47:23 -0700 (PDT)
In-Reply-To: <vpqhaxrz1c6.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193139>

On Wed, Mar 14, 2012 at 6:47 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Dmitry Potapov <dpotapov@gmail.com> writes:
>
>> Not of course. I said above non-fast forward push should not be used by
>> beginners.
>
> Do you mean "beginners should not force non-fast forward push", or
> "beginners should not use flow where push may be denied because of
> non-fast forward"?

Of course, the former. I have never said that the centralized workflow
should never been used. I have only said that it is not scalable and
lead to problems in larger projects.

> If the second, this implies that beginners should never have a shared
> repository,

Well, you can set up a shared repository where everyone has their own
namespaces to push. I don't say that that it is better than having one
public repository per user, but it may be easier to setup...

So it only implies that you cannot have a centralized workflow in this
way.

> either shared for one user and multiple machines, or shared
> between developers?

I am not sure that I understood this part.

> If you mean that shared repositories are too complex for beginners, my
> experience is exactly the opposite.

It is not too complex but it is wrong for any more or less serious project.
Git is flexible enough to cover different workflows, including some variant
of a centralized workflow, but git was not designed with the centralized
workflow in mind. So some trade-offs are different in it than in VCS that
were designed primary (if not only) to be used with a centralized workflow.
IMHO if you teach git then you should teach a distributed workflow,
because it is the workflow where advantages of git is most obvious...

Dmitry
