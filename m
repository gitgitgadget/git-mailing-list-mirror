From: Scott Chacon <schacon@gmail.com>
Subject: Re: [linux.conf.au] VCS Interoperability
Date: Sun, 22 Jan 2012 16:43:47 -0800
Message-ID: <CAP2yMaLHK2md=MHFmV--R6rmr4q3XuZxqsb2fUszMhssx3GDoA@mail.gmail.com>
References: <CAFfmPPMH2643JMMZdVbOQJL7DB-DiRYQS8x0TqEaSbGmhMdBNw@mail.gmail.com>
 <CALkWK0kMmDMZ4wiMSmOfwBLzd+xBEA+WKsviu9FVcvj9eZEahg@mail.gmail.com>
 <CAFfmPPOZfDdH+GF91Dxyy5yfX8TmGDmsbpHz=CVLcBY0c-pCsQ@mail.gmail.com>
 <CALkWK0nsO2EBLUrO_iWAdGYpULt=oug4yPDnczX9c44hzdwzqg@mail.gmail.com>
 <alpine.DEB.2.02.1201221310540.28747@asgard.lang.hm> <3BC64515-C4C0-4D32-97B0-8FFD14BB903C@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: david@lang.hm, Ramkumar Ramachandra <artagnon@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Mon Jan 23 01:44:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rp81G-0005eh-MX
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 01:44:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540Ab2AWAoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jan 2012 19:44:11 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:50357 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526Ab2AWAoK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jan 2012 19:44:10 -0500
Received: by vcbgb30 with SMTP id gb30so588004vcb.19
        for <git@vger.kernel.org>; Sun, 22 Jan 2012 16:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=a8//4m+uY4VMIJna8+dGsA9OlthpQKIHQ//zIiifhPE=;
        b=Ig0IJPwr/pJQvlbfoi3y7qae737lvPTDD9Bb/4XadYZ1z/vnW0jJ5+o0FoNqWMtHk+
         wVMgD9OMjE1/RLShuHU7DQqP7kT4qfE4HqX+AKk5Kac3RoS2hCN0X+V0+tSJCsKmRQdn
         u5hU26wJ2e3F/SkqyUY5JZaOrGlxfpUC9AAMM=
Received: by 10.220.153.134 with SMTP id k6mr3412062vcw.23.1327279449110; Sun,
 22 Jan 2012 16:44:09 -0800 (PST)
Received: by 10.220.63.193 with HTTP; Sun, 22 Jan 2012 16:43:47 -0800 (PST)
In-Reply-To: <3BC64515-C4C0-4D32-97B0-8FFD14BB903C@silverinsanity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188976>

Hey,

On Sun, Jan 22, 2012 at 3:33 PM, Brian Gernhardt
<benji@silverinsanity.com> wrote:
>
> On Jan 22, 2012, at 4:12 PM, david@lang.hm wrote:
>
>> On Sun, 22 Jan 2012, Ramkumar Ramachandra wrote:
>>
>>> 3. What are your thoughts on lib'ifying Git so that others can call
>>> into it using an API?
>>
>> This is something that everyone agrees would be a good thing. There have been many people who have started projects to do so, but they have all stalled.
>
> I believe libgit2 is still under active development.
>
> http://libgit2.github.com
>

Yes, GitHub alone actually has 2 full time employees and 1 contractor
who are entirely dedicated to the project. It also ships with the
GitHub for Mac product, so it's used in production by tens of
thousands every day. If any of you want to get involved, you can check
out the mailing list (libgit2@librelist.org) or (probably more
usefully) the GitHub project page:

https://github.com/libgit2/libgit2

Open tickets, contribute code, review PRs, etc.

Scott
