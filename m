From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Tue, 23 Apr 2013 14:11:01 -0500
Message-ID: <CAMP44s2QVOSgT+GdZ9BhahGXmtJXO4Fv_WmPSkmEzjsdbe0hDw@mail.gmail.com>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
	<CAMP44s2_wiNr4RaBOEnKnZzT4CF0qKK+bp+Lyi=Nfx3Q9ggqOQ@mail.gmail.com>
	<7vip3npet0.fsf@alter.siamese.dyndns.org>
	<CAMP44s3NE3yrQoa1nZXAgy3KFXGF56Ki8icJ2z2TDigzax0nWg@mail.gmail.com>
	<8761zm4wzg.fsf@linux-k42r.v.cablecom.net>
	<CAMP44s0a2VsPBMd9Vrrhwdw=SPp2HrvDdXZ9Dmzhr9A6T+Sz7w@mail.gmail.com>
	<CABURp0qGYG4T+t36=Us328YdLzy9KjBOWot2gSOk=FgCRUCLnQ@mail.gmail.com>
	<CAMP44s3pZt3QVjS7GbXqjMS4ti3p=Vs2DmFXQjsMM3rs9qURmw@mail.gmail.com>
	<CALkWK0nji4m0zJPf_s0G5jfWaAN_RTGFZ6dSxfahq2OcRsu5xQ@mail.gmail.com>
	<CAMP44s1RpgM5U0ySsof_sgEHNS1p-seQ=ciVCth9gOJMG0cpHw@mail.gmail.com>
	<CALkWK0krWM4kJ5GTnQ2SL7HoNfNMNA0-xdRVbeatAFpyKW_RtA@mail.gmail.com>
	<CAMP44s0KW4_Q6-d-3=M7GzWmHwy4H--FcemK4UF5FS0t3wnOgg@mail.gmail.com>
	<CALkWK0ncfuzuYSKjkT2uQy4dGR=TSnHoJNdhU9ownDUytysL6w@mail.gmail.com>
	<CAMP44s162msct=W0eV93LX15Bho=DA1baLZcgFCouSRH=z0mDQ@mail.gmail.com>
	<CALkWK0m05nWS=fQVCkFhNx7BT6_7qHN8W2WVW=6mGFeKKfN1Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phil Hord <phil.hord@gmail.com>, Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 21:11:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUicQ-0006bw-8i
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 21:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756851Ab3DWTLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 15:11:05 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:50641 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756697Ab3DWTLD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 15:11:03 -0400
Received: by mail-lb0-f176.google.com with SMTP id y8so981046lbh.21
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 12:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=03Y6+lHMu9gLW50V6uzVAqG25XZkKK+dYRr6fEk2oow=;
        b=P5luaIgGTApo243AVype+WIe8jIcpLY2AOw+w/gtKCKiWYSV0FPwHMyA5GdssRco8/
         fjLmcPYlmV7nFt+Ze7FR8uhH86igdUtSNVf8XVIt3l2hYUGK9h8yqes48nVaZ+Cr32x5
         c8iGwyHoOHZVcWvNycybfLef5UeYPXY29Cx250/nPVDwp5n83KcAC/2GAgs2jbIJSDyB
         iwJVDXRityBPzy5VG2TA+HGpWtvFpir7c6kzA89xdZZjm7RXYtMDM13kSXZ3p2c51/3+
         ztPARWIE292ZBurCxsrfmP52AYEy7RFpJ6AOmvdkVfN1ZU2jiiT++58CjzPtKX0wL80N
         qguA==
X-Received: by 10.152.20.134 with SMTP id n6mr4260036lae.19.1366744262058;
 Tue, 23 Apr 2013 12:11:02 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Tue, 23 Apr 2013 12:11:01 -0700 (PDT)
In-Reply-To: <CALkWK0m05nWS=fQVCkFhNx7BT6_7qHN8W2WVW=6mGFeKKfN1Mw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222207>

On Tue, Apr 23, 2013 at 1:49 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:

> My point is simple: yes, it's nice to have a big user base.  We
> already do.  Now, what's the point of pitching to end-users who only
> use the most basic functionality?  Their inputs are likely to be
> useless (arising from misunderstandings) anyway.  They're not going to
> be the next developers.  And they're not going to help create what our
> next developer is looking for in us either (i.e. codebase, community).

That is your mistake right there. They *are* the next developers, you
yourself came from there. We all did.

In fact, this notion that there's a divide between users and
developers is a myth; it's a continuum that follows the Pareto
distribution. It happens in every healthy open source project.

And this is not an assumption, I've measured it:

http://felipec.wordpress.com/2011/11/21/no-project-is-more-important-than-its-users/

70% of the commits in git.git come from people that have provided less
than 6 patches. That 70% (maybe 80%, maybe 90%) would have never
happened, if git didn't have a large enough user-base. I'm not
idolizing the user-base, this project *is* the user-base, developers
are users, and without users there's no project.

Again, in the words of Linus: no project is more important than it's users.

Cheers.

-- 
Felipe Contreras
