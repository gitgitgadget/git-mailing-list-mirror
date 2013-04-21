From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/5] git-log.txt: rewrite note on why "--" may be required
Date: Sun, 21 Apr 2013 13:43:24 +0530
Message-ID: <CALkWK0mmvwnRzq5eYTzvZRmEwn7nyDLe5cJsV1iQvNnh1Y7xEw@mail.gmail.com>
References: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
 <1366458313-7186-5-git-send-email-artagnon@gmail.com> <7vtxn0wf4j.fsf@alter.siamese.dyndns.org>
 <CALkWK0nFAzPPb0_jTRev6nuicCV81sRQAbe=277nhyyY8TnQ7A@mail.gmail.com>
 <7v8v4cwd6g.fsf@alter.siamese.dyndns.org> <CALkWK0kiT7vggXgqGs2iiMooiw7TyJEgr2=Yy06S7H1NKiWJ3g@mail.gmail.com>
 <7vzjwsuxzp.fsf@alter.siamese.dyndns.org> <CALkWK0kEngwYQieR=Xmvzu+XqBe+ZFxiWj0C8M-euFavDDaD2Q@mail.gmail.com>
 <CAPc5daV39HsoRR2pj34Tz1kQKFVRrp+NZpMM2BremocqvToA+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 10:14:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTpPY-00045W-Cx
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 10:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347Ab3DUIOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 04:14:06 -0400
Received: from mail-ia0-f177.google.com ([209.85.210.177]:61577 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330Ab3DUIOF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 04:14:05 -0400
Received: by mail-ia0-f177.google.com with SMTP id y26so1987004iab.36
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 01:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=USR9H6G14Jg6frSd6IX7YQ2o0kpRsAGWjX6CRJOEVT4=;
        b=nmzkRp00YmqwMVJ3wyP4IhrjOO9v7Js+ZPnmvLp75LhQsDEjyZ4HKKcWcmo+mK+Yjc
         yIe4ZOShw3CbKlsVlnuD90NwbCOKGD5k8a4RO3rYuw9j3MVLlV68AxX89DA1wnJf8P1T
         2mf2DFo9vOm+JHtWQH56SseXI2vTcpT10q48Fk3iGbAgb8g+C67BDNpVPm2xZ9/l8XcO
         zm5ESCFe7alXY7OVVK3T4lDV9qwOl80VJw5V7aaXL54A1YNXaZ3jdR476I838TD2jeho
         vyyVwsXCzgyGs9/vZoDgFxab7ZO+od40N+znM9kweQvpPBN65AI4JK+2iAUlFS55RfiO
         4lUg==
X-Received: by 10.50.17.71 with SMTP id m7mr12792845igd.14.1366532044492; Sun,
 21 Apr 2013 01:14:04 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Sun, 21 Apr 2013 01:13:24 -0700 (PDT)
In-Reply-To: <CAPc5daV39HsoRR2pj34Tz1kQKFVRrp+NZpMM2BremocqvToA+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221916>

Junio C Hamano wrote:
> A revision range is a slice of history, so you don't need any further
> adjective.
>
> Please don't introduce new words that do not add any accuracies nor value.

I was just saying: I don't want to introduce new terms either.  I
think revisions.txt needs to be fixed.  Under the Specifying Ranges
section:

'<rev>'::
	Include commits that are reachable from (i.e. ancestors of)
	<rev>.

This doesn't make sense because <rev> might as well refer to a blob*.
So this should say s/<rev>/<rev> that names a commit object/.

* The first line in the Specifying Revisions section: A revision
parameter '<rev>' typically, but not necessarily, names a commit
object.
