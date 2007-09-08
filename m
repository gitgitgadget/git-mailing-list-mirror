From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Fri, 7 Sep 2007 17:32:09 -0700
Message-ID: <a1bbc6950709071732s1f15e5ev28bdfc5c1ab5877b@mail.gmail.com>
References: <46DDC500.5000606@etek.chalmers.se>
	 <1189004090.20311.12.camel@hinata.boston.redhat.com>
	 <vpq642pkoln.fsf@bauges.imag.fr>
	 <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
	 <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org>
	 <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>
	 <Pine.LNX.4.64.0709071119510.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Matthieu Moy" <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Sep 08 02:32:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IToFF-0005Ij-96
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 02:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbXIHAcL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 20:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbXIHAcL
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 20:32:11 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:22717 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbXIHAcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 20:32:09 -0400
Received: by rv-out-0910.google.com with SMTP id k20so564063rvb
        for <git@vger.kernel.org>; Fri, 07 Sep 2007 17:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=LdVlF7RlAVFClJ2m5W8rgTWgRCgftpR/6jZxHIirykc=;
        b=dX9b9PWFzEVRROHp42YtuL567pWItycp7GHdbX/Dyuh6sO/7nhGlH9MIaU66AhUkaZ0dt3ah8WFxPesYe0ld6mlfeTIP0TZMUznt7fes+DIcdHWAe/vsH6f3Z1ksoe5Q0nsnLV1a/WtD18lV0SmI3iBIV2S1Hzgp91jt6GTojec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GuZKP/ZwcxTnvbR9olyApM/aAiFTIqqmu1C8JuizkBS4BDDICxNcGa+GDJ9ec7nMPywkZ6wth8Q0qFoSWqgjFCpnLnClzWzuQv6CEjiwM4sdHwdtrJA2YKKHHcxEYiLbCwqSbisev5V4S/7HIhRu6w/wUJv38kNxLSUjoKGs7pM=
Received: by 10.140.157.12 with SMTP id f12mr950918rve.1189211529220;
        Fri, 07 Sep 2007 17:32:09 -0700 (PDT)
Received: by 10.141.21.17 with HTTP; Fri, 7 Sep 2007 17:32:09 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0709071119510.28586@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58093>

On 9/7/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 6 Sep 2007, Dmitry Kakurin wrote:
>
> > Anyway I don't mean to start a religious C vs. C++ war.
>
> You have a very strange way of not meaning to start a C vs. C++ war.

I honestly didn't. I didn't even think it's possible. In the
environment of mainstream commercial software development the last war
on this subj was over 8-10 years ago.
Even wars like "do we use exceptions/templates/stl" are pretty much
over. Now days it's "do we use Boost", or "do we use template
metaprogramming". But even more often it's Java/C# vs. C++.

That's why I was wondering how come C was chosen for Git.

> > It's a matter of beliefs and as such pointless.
>
> No, it's not.  As has been shown by some very good _arguments_.  Once you
> have facts to back up your claims, it is not any belief any longer.

Well I've heard *opinions* and anecdotal evidence. No facts though.
And it's not surprising. There could be no hard facts in such a
matter. It always boils down to "most of all, I want my software to be
X" where X is different for different people (fast,maintainable,quick
to market, scalable, beautiful, etc ... to name a few).
With different values of X any debate is pointless. And X is exactly
the matter of believes.

Anyway my curiosity is satisfied (thru the roof so to speak) and I
think it's enough on the subj. It has reminded me of good old times
though.

-- 
- Dmitry
