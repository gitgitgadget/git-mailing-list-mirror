From: Alexandru Sutii <sutii.alex@gmail.com>
Subject: Re: GSoC questions
Date: Thu, 31 Mar 2011 21:34:15 +0300
Message-ID: <AANLkTikMsQHL9RMm=uOse+OObavMNc=PJE7aOqA-WMkY@mail.gmail.com>
References: <AANLkTinTM8hQpcahGgDyB4UJvGbdN0xyp65wL5PDQGKa@mail.gmail.com>
	<20110328001152.GA11294@elie>
	<AANLkTikGb1=Rtz-T9p=u+X32KpL2AXq0AELdSJ2NMHrW@mail.gmail.com>
	<AANLkTink4wVb6O+yVm=HUh_s1GhKhyL4baqYGe=XFu04@mail.gmail.com>
	<AANLkTinZ2zbhCRAqAYkiAa1=K8aUhcAuEe6Q_gO-v2h_@mail.gmail.com>
	<AANLkTi=TOYOj2HWzy62G24Kg=NZC5X1=psA3GDhaH3Hc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Vicent Marti <vicent@github.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	libgit2@librelist.org, Jeff King <peff@peff.net>
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Thu Mar 31 20:34:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5MhN-0004DJ-Bs
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 20:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344Ab1CaSeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 14:34:19 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51089 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758834Ab1CaSeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 14:34:16 -0400
Received: by iwn34 with SMTP id 34so2664139iwn.19
        for <git@vger.kernel.org>; Thu, 31 Mar 2011 11:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=38SijftLjF6X9s0nO23aDmrOIBaJIJGMmeIez3WsRbI=;
        b=x3punw2DO27mJNtFb/oAlq8hfoYhID2rLap3cooByBotugOyYYd3hGiaQUiMfvQq4Z
         s2gi8kboBEW+DbNKOaBAps3M41P+Zgn3qTWifv41ZRwLoKPHFY6k0B0dj95WXSWPAvkh
         DTsbTikV6NOol95k47M5xL/kQqpqycaDgfqVs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=W3WFFQevBOtQoQzDevxiV0aQ3iP5HbixNI5uLl/S4SOrif/RnPbN98m94kvK2Ipwwm
         XijjZ/Ia2yp32sPciPgHZj69rTmj+Nww2cadUynWwgg55idngv1duUOKLpx+Qstrj+7S
         9HXZIYO7b3IPkJqyzR/fVz+iOVf28rAOD/bio=
Received: by 10.42.138.4 with SMTP id a4mr3716570icu.258.1301596455813; Thu,
 31 Mar 2011 11:34:15 -0700 (PDT)
Received: by 10.43.133.2 with HTTP; Thu, 31 Mar 2011 11:34:15 -0700 (PDT)
In-Reply-To: <AANLkTi=TOYOj2HWzy62G24Kg=NZC5X1=psA3GDhaH3Hc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170508>

> I guess the git2 client will consist solely of non-gitcore code, as
> all the gitcore code will be part of libgit2 eventually.
>
> I expect the transition to be not so difficult for many commands, but
> the challenge I see is to do it not by 'reusing' git code, but by
> 'sharing' the code. Otherwise we end up with a second Git and someone
> should spend a lifetime to keep the reused code in synchronisation
> with the git repo.
>
> This might, however, require some (major) refactorization to the Git
> code. I don't know whether that will be supported by everyone.
>
> On the other hand, we will get the bonus that using libgit2 in the
> upstream git code is then becoming more trivial.
>
> Maybe I'm aiming at too much here. It could well be that it is worth
> writing the minimal git client to just be able to test libgit2 using
> the git tests. Does anyone want to comment ?

Hello!

There have been a lot on discussions on the mailing list regarding
on what this client should look like and I understand that we are
expected to come with a specific approach. Also I understand there is
no interest for this project to become large.

Considering this circumstances I think we should implement the client
with the basic commands by reusing git's high level code. I am for building
it independently of the git's mainstream.

Anyway I am open to any proposals. Comments are still welcome.

--Alex
