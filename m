From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v1 04/25] contrib: remove 'buildsystems'
Date: Fri, 9 May 2014 11:10:07 +0200
Message-ID: <CABPQNSay4gDJ2Ea-w0=wnU1oqVZ_ATm1Q_M71zt+rAd1XUr0zg@mail.gmail.com>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <1399597116-1851-5-git-send-email-felipe.contreras@gmail.com>
 <CABPQNSYZ4eWS_9_omZGK5wCD7ap_siEkC10e4ayT8Jp9w1bOSw@mail.gmail.com>
 <536c8e63448c2_25d198d30c55@nysa.notmuch> <CABPQNSYgfUdtfT0sYCwGsWQgW3QFOZvSZSyG76dmF6+ZSMaByw@mail.gmail.com>
 <536c966cf0e9c_2bf0e952f079@nysa.notmuch>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 11:10:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WigpS-0004ma-KK
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 11:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755919AbaEIJKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 05:10:49 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:42871 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505AbaEIJKs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 05:10:48 -0400
Received: by mail-ig0-f180.google.com with SMTP id c1so881333igq.13
        for <git@vger.kernel.org>; Fri, 09 May 2014 02:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=IFOTcxPSdby7A1VdJMUGV/mHY2u3kGlJ/vJBrd263D0=;
        b=dqD9aeQzjmN14ZLz+qTrwHW47rlNgo0xmPMRT6P40f85ytGvAXOSON0HUUAd2P+FgQ
         dtpoCP7q9YZPI27bh9FxQWQKkOTTukdauDBo5SFCgaRsPqv5QL3Uj/I1sE1lBnyxISkW
         jbGkM9edzGVFQ7ovQYYGsURMJyrgSOIt/QxAqn6TXXDyG0G9x6YLUq7onG6O9b8Ufcwz
         fBdndjTI0re8CzQGgStGsH58FViH63TT6rNpesuA7pIe7dQOksYtEArF1Ans8MQZ+Aty
         LMclSl+Q1IJAI5gs36U791i01FiVpP5a/7kiPZEj1sDS0PXahhfUpUs5f2nIxndjmoW/
         8P0g==
X-Received: by 10.50.50.146 with SMTP id c18mr6160571igo.42.1399626647616;
 Fri, 09 May 2014 02:10:47 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Fri, 9 May 2014 02:10:07 -0700 (PDT)
In-Reply-To: <536c966cf0e9c_2bf0e952f079@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248539>

On Fri, May 9, 2014 at 10:48 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Erik Faye-Lund wrote:
>> On Fri, May 9, 2014 at 10:14 AM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>> > If you want this script to remain in contrib, please:
>> >
>> >  a) Write at least a few tests
>> >  b) Write some documentation
>> >  c) Explain why it cannot live outside the git.git repository like other
>> >     tools. [1][2][3]
>>
>> (Adding Marius, the original author to the CC-list)
>>
>> Uh, why is such a burden required all of a sudden? contrib/README
>> mentions no such requirements, and the scripts have been accepted (and
>> maintained) since.
>
> contrib/README mentions clearly the expectation that these scripts
> eventually move to the core once they mature. This is never going to
> happen for these.

Yes, *expectation*. Not requirement.

> It also mentions that inactive ones would be proposed for removal, and
> this one is clearly inactive. It has 9 commits (if you count the one
> that changes the execution bit).

It mentions that Junio *might* suggest things to be removed, not that
things *should* be removed if left unmaintained.

And this script is not unmaintained, it's simply just still working.

>> Besides, you say "No activity since 2010" - this is not the case,
>> bc380fc is from November 2013.
>
> You think changing the execution bit of a file is considered "activity"?
>

Well, now we're getting into semantics, which I don't care so much
about. It shows some sort of interest in the scripts, at least.

>> And there's already *some* documentation in the scripts themselves.
>
> That's nice. So you can just copy that into a README.

Feel free to scratch that itch yourself, you're the one inventing new
requirements here.

>> Please stop your pointless crusade that'll only break other people's work-flows.
>
> If you care about these scripts, it should be trivial for you to add at
> least a few tests, souldn't it?

Again, testing this is not my itch. Feel free to scratch that one
yourself, but please don't remove the script.

> Please tell me how exactly will your work-flow be broken. More
> specifically, tell me why your scripts cannot be moved outside of git,
> like git-extras[1], git-deploy[2], git-ftp[3], and countless other
> tools.

Moving the script out of the repo makes it less convenient to bisect
issues with MSVC, as it depends heavily on the top-level Makefile.
Moving it out would require figuring out what version of the script
matches a given git revision, which is a hassle.

Again, please stop this pointless crusade.
