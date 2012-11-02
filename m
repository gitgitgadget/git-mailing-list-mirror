From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] test-lib: avoid full path to store test results
Date: Fri, 2 Nov 2012 16:17:27 +0100
Message-ID: <CAMP44s2bZa4BnTnSv0Zgdh52Vy613R3cWE3nSxXdR4dDVhJAyw@mail.gmail.com>
References: <1351570377-894-1-git-send-email-felipe.contreras@gmail.com>
	<20121030044609.GA10873@elie.Belkin>
	<CAMP44s3ap19TDsSo_fmNqJp+ROWo2Ka8bc35YQmR3mMw375WsQ@mail.gmail.com>
	<20121031012730.GY15167@elie.Belkin>
	<CAMP44s1xAeW2QZsNwRVRx+DEhYVVdiKbw-y-aNuo6unuv7pYZQ@mail.gmail.com>
	<20121031021318.GB15167@elie.Belkin>
	<CAMP44s3WODA2Vru0Q1b5EWA6_1vdHnPmFfUmDg0Phh0S=76O9w@mail.gmail.com>
	<509167C8.6090600@kdbg.org>
	<20121102131726.GC2598@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 02 16:17:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUJ0A-0007UK-1G
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 16:17:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756982Ab2KBPR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 11:17:29 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:48384 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756619Ab2KBPR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 11:17:28 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so3700548obb.19
        for <git@vger.kernel.org>; Fri, 02 Nov 2012 08:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=V7YI8MIx9odLHmKvMPvwEFY5yfpa6cH+58a+uI1SwgQ=;
        b=R6FIxXCdykYkRQ9OtiDBa7O/SXP3J4QZP00xPNd2M/il9jvm2zBOGGwqgDw9qwhmj0
         fsVZZEgLNrA7pum9TLJ7IO057SGZgoq8YON5AU6wbQpv/itDRBZgceQn7yPI9S9qcbMX
         ZlA+GQ5dE82FN9M7EXWKVUQGDtbFFCdDR3JqKtwYAL2QKubO5byZY9cgcc5N25DTkaJ5
         5HzXvUS4z/MvLuJ1UOcUv8EmDQKEC5ecMzZ9W91V7n7bm0K9XVYQ2E+pRNXvKcbR4S08
         MQzy2vSSA+7y0ZGjFwPGoERTpnRFlLqwgnH7ySXAl6vujw7N3PGYk+39S8dywWDO7Z0k
         kr/A==
Received: by 10.60.31.241 with SMTP id d17mr1580511oei.107.1351869447768; Fri,
 02 Nov 2012 08:17:27 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Fri, 2 Nov 2012 08:17:27 -0700 (PDT)
In-Reply-To: <20121102131726.GC2598@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208947>

On Fri, Nov 2, 2012 at 2:17 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Oct 31, 2012 at 07:02:48PM +0100, Johannes Sixt wrote:
>
>> Am 31.10.2012 03:28, schrieb Felipe Contreras:
>> > On Wed, Oct 31, 2012 at 3:13 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> >> Felipe Contreras wrote:
>> >>
>> >>> It's all fun and games to write explanations for things, but it's not
>> >>> that easy when you want those explanations to be actually true, and
>> >>> corrent--you have to spend time to make sure of that.
>> >>
>> >> That's why it's useful for the patch submitter to write them, asking
>> >> for help when necessary.
>> >>
>> >> As a bonus, it helps reviewers understand the effect of the patch.
>> >> Bugs averted!
>> >
>> > Yeah, that would be nice. Too bad I don't have that information, and
>> > have _zero_ motivation to go and get it for you.
>>
>> Just to clarify: That information is not just for Jonathan, but for
>> everyone on this list and those who dig the history a year down the
>> road. Contributors who have _zero_ motiviation to find out that
>> information are not welcome here because they cause friction and take
>> away time from many others for _zero_ gain.
>
> And me, who is trying to figure out what to do with this patch. It is
> presented on its own, outside of a series, with only the description "no
> reason not to do this".

Yeah, because I think it stands on its own. But I'll include it in the
remote-hg patch series, I already have it queued up.

> But AFAICT, it is _required_ for the tests in
> the remote-hg series to work. Isn't that kind of an important
> motivation?

It's not _requied_, you will see that error at the end, and the
aggregate results would all be 0, but the tests would still work.

> Yet it is not in the commit message, nor does the remote-hg series
> indicate that it should be built on top. Or am I wrong that the one is
> dependent on the other?

They are not dependent.

Cheers.

-- 
Felipe Contreras
