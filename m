From: David Barr <davidbarr@google.com>
Subject: Re: [linux.conf.au] VCS Interoperability
Date: Fri, 27 Jan 2012 10:47:08 +1100
Message-ID: <CAFfmPPPvpbsYz9cjN6OspivCN3dbuPGOU7fyaVdnic3D4V855w@mail.gmail.com>
References: <CAFfmPPMH2643JMMZdVbOQJL7DB-DiRYQS8x0TqEaSbGmhMdBNw@mail.gmail.com>
	<CALkWK0kMmDMZ4wiMSmOfwBLzd+xBEA+WKsviu9FVcvj9eZEahg@mail.gmail.com>
	<CAFfmPPOZfDdH+GF91Dxyy5yfX8TmGDmsbpHz=CVLcBY0c-pCsQ@mail.gmail.com>
	<CALkWK0nsO2EBLUrO_iWAdGYpULt=oug4yPDnczX9c44hzdwzqg@mail.gmail.com>
	<alpine.DEB.2.02.1201221310540.28747@asgard.lang.hm>
	<3BC64515-C4C0-4D32-97B0-8FFD14BB903C@silverinsanity.com>
	<CAP2yMaLHK2md=MHFmV--R6rmr4q3XuZxqsb2fUszMhssx3GDoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Brian Gernhardt <benji@silverinsanity.com>, david@lang.hm,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 27 00:47:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqZ2S-00051U-2p
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 00:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645Ab2AZXr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 18:47:26 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39312 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323Ab2AZXrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 18:47:09 -0500
Received: by ghrr11 with SMTP id r11so549891ghr.19
        for <git@vger.kernel.org>; Thu, 26 Jan 2012 15:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-system-of-record:content-type;
        bh=I7JVgNiGOaO24MST213KfasFEw1keM8TtNVsd7163Mg=;
        b=FXHWilAhx5ATZ/eKwAwNcT45oo2tVe5T8NGyrSP1dYFVyg2VYh/eBhT2ydBckiJyVc
         5vvf+f/hyxd2IILWA5NVJ0wKnXllr4MVH5wnNgXeCxS8vA382ZXvRxjbd/qZoLS4FZ6m
         tuI+6B9cwYOAmFjMiIojQtqW9rqZ+2rNG9yyw=
Received: by 10.236.173.132 with SMTP id v4mr6620026yhl.78.1327621628321;
        Thu, 26 Jan 2012 15:47:08 -0800 (PST)
Received: by 10.236.173.132 with SMTP id v4mr6620008yhl.78.1327621628225; Thu,
 26 Jan 2012 15:47:08 -0800 (PST)
Received: by 10.101.144.22 with HTTP; Thu, 26 Jan 2012 15:47:08 -0800 (PST)
In-Reply-To: <CAP2yMaLHK2md=MHFmV--R6rmr4q3XuZxqsb2fUszMhssx3GDoA@mail.gmail.com>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189174>

>>>> 3. What are your thoughts on lib'ifying Git so that others can call
>>>> into it using an API?
>>>
>>> This is something that everyone agrees would be a good thing. There have been many people who have started projects to do so, but they have all stalled.
>>
>> I believe libgit2 is still under active development.
>>
>> http://libgit2.github.com
>>
>
> Yes, GitHub alone actually has 2 full time employees and 1 contractor
> who are entirely dedicated to the project. It also ships with the
> GitHub for Mac product, so it's used in production by tens of
> thousands every day. If any of you want to get involved, you can check
> out the mailing list (libgit2@librelist.org) or (probably more
> usefully) the GitHub project page:
>
> https://github.com/libgit2/libgit2
>
> Open tickets, contribute code, review PRs, etc.

I'm thinking libgit2 is where git features that have stablised are formalised.
On the other hand, git-core is where features are incubated.

I would like to see fast-import ported to libgit2 when it stabilises ;)

After giving my talk, I feel compelled to reroll the historic vcs-svn series.
I'm pushing as I go to my GitHub account:

  https://github.com/barrbrain/git/commits/svn-fe-reroll

--
David Barr
