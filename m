From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Git Rebase blows away GIT_AUTHOR_NAME
Date: Thu, 13 Jan 2011 18:47:28 +0100
Message-ID: <AANLkTikqfX3jhSdP5xhFj=VktqW2S6AeGL_MF18g8ZA_@mail.gmail.com>
References: <AANLkTinMX0yEPvSc-c=96R42SbFZTjW5Mnveuxk3ZHS=@mail.gmail.com>
 <20110112182150.GC31747@sigill.intra.peff.net> <AANLkTimanDRHwoqSj7i9sVCZkze1L3Qp-zFYwTwHAOHX@mail.gmail.com>
 <AANLkTimvK3p3M8kbGzLxyhchoFONiD4=FGPWxxs=i0GA@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: JT Olds <jtolds@xnet5.com>
X-From: git-owner@vger.kernel.org Thu Jan 13 18:47:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdRHA-0006nO-SG
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 18:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757030Ab1AMRrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jan 2011 12:47:52 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64311 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756934Ab1AMRru (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jan 2011 12:47:50 -0500
Received: by fxm20 with SMTP id 20so1915429fxm.19
        for <git@vger.kernel.org>; Thu, 13 Jan 2011 09:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=fynvXEKc108lzunYoT0LHVWgALBAB/RCvjzm0zF5OW8=;
        b=A23TkwfJrZEVX9ZXsA2r+jeA4RkOcT7Qb+vnd7YCsgOai1tEh2//8mH5DpnQ54buOc
         AuKcOB6ovmnj12gCjaxlmQQGis7YO/H6h97j+19yby5j+dDz2BYH5gP5sX8x4BxRJLcJ
         W8rON6bDC+0Pbv7TfraaC2IQA08951tVZkVPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=ctxQKoMSqKdUXpdCmJUu4ttzWiyvisCaNNQZwOhkE2H0B6wZtnSora1A3ukBlLg2JO
         6DARDiPh/BazUdR9PW4CBQ3qgMkUN9L+EabKPOpsWQnQtQOiPQ7U64ROBq9RWNUwmJvp
         g0eReAKwn7oer2cVEPEP4mTIL5zmDkLkNc/d8=
Received: by 10.223.112.1 with SMTP id u1mr2631373fap.109.1294940868242; Thu,
 13 Jan 2011 09:47:48 -0800 (PST)
Received: by 10.223.79.3 with HTTP; Thu, 13 Jan 2011 09:47:28 -0800 (PST)
In-Reply-To: <AANLkTimvK3p3M8kbGzLxyhchoFONiD4=FGPWxxs=i0GA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165058>

On Thu, Jan 13, 2011 at 6:11 PM, JT Olds <jtolds@xnet5.com> wrote:
> I got a copy of git-sh-setup. All of my commits (that have either
> worked or that I fixed) look like this:
>
> GIT_AUTHOR_NAME='JT'
> GIT_AUTHOR_EMAIL='jt@instructure.com'
> GIT_AUTHOR_DATE='1294756950 -0700'
> Author: jt@instructure.com
> Email: jt@instructure.com
> Subject: removing nondeterminism from test
> Date: Tue, 11 Jan 2011 07:42:30 -0700
>
> Should "Author" be my name? Could that be what's going on? I don't
> even know where that gets set. The ones that I failed to notice that
> they broke before I pushed them look like this:
>

"git am" (which git rebase builds on) requires the author name to be
at least three characters long. This is a problem that has been
discussed before, see
<AANLkTinqTL7gH4CHEfy8UrhK13xcO_3UzgIyQka00MAh@mail.gmail.com>:

http://mid.gmane.org/AANLkTinqTL7gH4CHEfy8UrhK13xcO_3UzgIyQka00MAh@mail.gmail.com
