From: =?UTF-8?Q?Micha=C5=82_Staruch?= <msta@cinkciarz.pl>
Subject: Re: Is OS X still supported?
Date: Tue, 5 Apr 2016 23:08:49 +0200
Message-ID: <CAN1difsnc_FdDhJ+gZoR8o4VK3Xg0eyCsyqUS7DDF328B3Pjhg@mail.gmail.com>
References: <CAN1difv6C9VSwy6DAz7++R6PP6hpg9MD8v1aKk_4VTdBP5RwHw@mail.gmail.com>
 <xmqq4mbg2eqa.fsf@gitster.mtv.corp.google.com> <87EB5631-EB8F-41C3-B92C-3BEF03F1A9AF@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tim Harper <timcharper@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 23:09:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anYEE-0006DS-FJ
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 23:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbcDEVJc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Apr 2016 17:09:32 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:33551 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbcDEVJb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Apr 2016 17:09:31 -0400
Received: by mail-lb0-f177.google.com with SMTP id u8so17533581lbk.0
        for <git@vger.kernel.org>; Tue, 05 Apr 2016 14:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cinkciarz.pl; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EpeJYTG6sU52OF2AA+eDBXhRABMqoRFZNJcBQcunPUw=;
        b=Ds0sUJCmD6f5DG17QWWmfX4nIKzXcA+i1GhQ8NEpAh0vK8fTiK5jz8eaKjrsI/ng5e
         DRiEMRgOMSYLPyIZj6cDJRmQsQsOZYGAUvJVLbXXJrqo6l/hOFj1mdIjO/mlPJMJ0JOl
         Tmp/3E9wt4+/RtkKSSPzfVJATDed9znERAWH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EpeJYTG6sU52OF2AA+eDBXhRABMqoRFZNJcBQcunPUw=;
        b=L2wVasvPe1E+ClNP3HgZPXt5EszrkAY7htz2cz21mXXx15mv5IBKgUs/wM7szwINUy
         whKkM3CZEGRAOuuV2wsmuWoEDH/PFscLrJy2GlaXC7SlDPZ1AmZKf78H8hIqTfDXaqR7
         +LmeVyBJX+iptqHoWgYtMo8DQNrhjjVavoDYiZUEWXgVZkugX3Cuy3H3S6uVcC6UnN5Y
         PNETpg2Ixbo49w2zqwCXfxEbWJJmmllUvfDxgzlCtoBw7+z2A06SiGY+FU8yYcW9Z52h
         2xSTk7nV123NGO1CbNgkF1rXLknS4ZAi8yGx7Z/q5oB02gqMo12/xXjRBxtg1jt3aABO
         +5LA==
X-Gm-Message-State: AD7BkJL2zqYpAHN588rr+jwTf4TRNvKiZHnkImd0fiJGT7uB5NquxEO8JmbB/OxLq4NvbGLPw+ITox01GHpPUg==
X-Received: by 10.112.133.38 with SMTP id oz6mr327739lbb.64.1459890569091;
 Tue, 05 Apr 2016 14:09:29 -0700 (PDT)
Received: by 10.25.18.86 with HTTP; Tue, 5 Apr 2016 14:08:49 -0700 (PDT)
In-Reply-To: <87EB5631-EB8F-41C3-B92C-3BEF03F1A9AF@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290810>

Thanks for the information that binary builds are availably on
SourceForge faster than on git-scm. I can see the v2.8.1 for OS X was
uploaded few hours ago to the SF, so my main problem (lack of security
fixes in git for OS X) is solved.

The automation process should be probably reviewed, though - because
all the other folks around the world using git-scm (not the SF) to
download OS X builds are still stuck at v2.6.4. Ideally git-scm would
point to the new Mac version within single minutes since the release
(or even seconds) - not hours, days, or weeks.

=46rom my point of view SourceForge vs GitHub is kinda implementation
detail. I'd go with GitHub as it's more convenient to use and supported
HTTPS since the beginning. And then SF had really bad idea with pushing
malware (see https://sourceforge.net/p/forge/site-support/7414/). But
as long as git-scm will be getting binaries on time most folks won't
really care about details of delivery process.


On Tue, Apr 5, 2016 at 6:43 PM, Tim Harper <timcharper@gmail.com> wrote=
:
> It is still supported. I'm not sure why git-scm is pointing to the wr=
ong version. There's been some discussion to upload to github instead, =
which I'm for, but SourceForge publishing is already automated.
>
>> On Apr 5, 2016, at 10:38, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Micha=C5=82 Staruch <msta@cinkciarz.pl> writes:
>>
>>> I'd like to ask if OS X is still supported platform for git. Source=
s
>>> and Windows build were updated to version 2.8.1, while OS X build
>>> stopped at 2.6.4, staying vulnerable to CVE-2016-2315 and
>>> CVE-2016-2324.
>>
>> Thanks for asking.
>>
>> Tim Harper (CC'ed) helps the OSX users by supplying the OSX
>> installer.
>>
>> I think git-scm.com attempts to show the latest OSX installer from
>> https://sourceforge.net/projects/git-osx-installer/.
>>
>> It's funny that that
>>
>>  https://sourceforge.net/projects/git-osx-installer/files/
>>
>> does list 2.7.1 that is newer than 2.6.4, but the quick download
>> link on that page points at 2.6.2; there is something screwy
>> happening at sourceforge.  I am not sure how git-scm.com chooses to
>> claim that 2.6.4 is the latest.  There seems to be an issue open on
>> this.
>>
>>    https://github.com/git/git-scm.com/issues/715
>>
>> As I do not do binary packaging for individual platforms, I cannot
>> be of more help than what this message says; sorry about that.
>>
>> Next time please send any message that is related to Git to either
>> git@vger.kernel.org mailing list (public) or if you want to
>> privately discuss security related issues that are not yet known to
>> the public, then to git-security@googlegroups.com [*1*].  There are
>> at least three reasons to do so:
>>
>> - A message that is addressed only to gitster@pobox.com and not one
>>   of these lists are often eaten by spam filters and will not be
>>   seen by me.
>>
>> - I am not an expert on everything that is related to Git (this
>>   topic is a good example), and people more qualified to answer are
>>   on these lists.
>>
>> - I suspect that you are not the only Git user on OSX, so there
>>   must be more people wondering the same thing as you are, so
>>   asking git@vger.kernel.org would help other OSX users.
>>
>> I almost added "Cc: git@vger.kernel.org" myself on this response,
>> but I didn't because there might be a reason for you to hide your
>> e-mail address from the public (some people are weird that way, and
>> you might be one of them but I couldn't tell because I do not know
>> you).  If you do not mind helping other OSX users, I am fine if you
>> CC'ed your response to this message to git@vger.kernel.org while
>> quoting everything I wrote here.
>>
>> Thanks.
>>
>>
>> [Footnote]
>>
>> *1* Both of these two lists accept messages from non-subscribers,
>> i.e.  you can send messages to them without subscribing to them, and
>> you'll be kept in the loop in the discussion by CC'ing the original
>> poster.
>
