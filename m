From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new git-remote-hd helper
Date: Wed, 17 Oct 2012 18:38:23 +0200
Message-ID: <CAMP44s1WY+Q7jyy4PQvwff7JSxHsnkhrPWozOLnNuNOrn7FGBA@mail.gmail.com>
References: <1350478721-3685-1-git-send-email-felipe.contreras@gmail.com>
	<alpine.DEB.1.00.1210171759230.3049@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 17 18:38:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOWdg-0006Og-3q
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 18:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757306Ab2JQQiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 12:38:24 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:53534 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756455Ab2JQQiX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 12:38:23 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so7627950oag.19
        for <git@vger.kernel.org>; Wed, 17 Oct 2012 09:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MvUs4TvQYuM32q9ufuJlypvOxr0OBQAHq5/681mcB8s=;
        b=ol8yp60ezMkpGAnAgvjQ0CWuIYH+bsTkMoqnX1shmKpJxfhRTqeBihjVfDIhe72XXM
         JaKmT1PaKJ8soohkemIziY3F0HiMZw6+8NWO+lgzTZ4RuIcJ8mFjEvrRECi27iBi8XUr
         a502lYZf/Os358/dPVv6pwJaLw+3h1fT3BtehV55KScm3bZ3weibCoBCcb0ZeQR5iCpf
         e0tkEybqu1I7As90ZAFWpmkriXuo5mQ+r+wOYWAIXuTXYYHuH5eVPaiEL3ajEa5k8PKu
         6x5EErwl9xQ/MTCAS0MBcOME3VB4tcwS8efAurBvzs918wb5Pk0rebYedHsG1mjXwXgI
         9JZg==
Received: by 10.182.245.20 with SMTP id xk20mr15832155obc.89.1350491903110;
 Wed, 17 Oct 2012 09:38:23 -0700 (PDT)
Received: by 10.60.58.137 with HTTP; Wed, 17 Oct 2012 09:38:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1210171759230.3049@bonsai2>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207920>

On Wed, Oct 17, 2012 at 6:03 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Wed, 17 Oct 2012, Felipe Contreras wrote:
>
>> I've looked at many hg<->git tools and none satisfy me. Too complicated,
>> or too slow, or to difficult to setup, etc.
>
> The one I merged into Git for Windows (since that is what I install on all
> my machines even if they run Linux) is rock-solid. It also comes with
> tests. And it requires a fix I tried to get into git.git (but failed,
> since I was asked to do much more in addition to what I needed for myself,
> and I lack the time to address such requests these days).

Maybe, but who uses it? It's quite a lot of code, and it's quite
difficult to setup--you would need a non-vanilla version of git.

Compare this:
32 files changed, 3351 insertions(+), 289 deletions(-)

To this:
1 file changed, 231 insertions(+)

I would like to first get something that works in, and then step by
step work on top of that.

Anyway, I'm not even sure which version you are talking about, because
there's plenty out there:
https://github.com/SRabbelier/git/network

> So I have to admit that I do not quite see the point of avoiding to
> enhance the existing work of Sverre (and a little bit of me, too, in a
> hackathon for which I traveled half the continent back in July 2011).

It's way too much code, to be specific; 15x the code I just submitted.
It would be better to work together, but to me the code-styles are way
too different, the difference between night and day. If you are
interested in simplifying that code, get rid of the classes of classes
of classes and have something more consolidated, I could try to
contribute, but I doubt that's the case.

Anyway, this is 231 lines of code, and works just fine, which is
better than what we have in git.git for mercurial: basically nothing.

Cheers.

-- 
Felipe Contreras
