From: Stefan Beller <sbeller@google.com>
Subject: Re: [ANNOUNCE] Git Merge Contributors Summit, April 8th, Paris
Date: Mon, 6 Apr 2015 13:28:18 -0700
Message-ID: <CAGZ79kat=W2mod_c8u2ojUG08faw8KU5N5BDeBLvJ4iOUv_=bQ@mail.gmail.com>
References: <20150224220923.GA23344@peff.net>
	<CAEcj5uV7XpXZTEyDrubXfWoN5uYn5BJbGaMbrWrmXbmgiCOHqg@mail.gmail.com>
	<CAP8UFD2rtxL29TqkxFXyGwW4g96TgFFLDJhhyYuAi850p64OjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Jeff King <peff@peff.net>, Git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 22:28:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfDdB-0005ig-5r
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 22:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753031AbbDFU2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2015 16:28:20 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:36029 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983AbbDFU2T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 16:28:19 -0400
Received: by igblo3 with SMTP id lo3so30554365igb.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 13:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rDtzUmnoiG2SW6ahcEwMV0UyAf4f9iBmlKeuxWCc++Y=;
        b=UZEcmNv0Rta7HII2ifHI+kXq1fQ0uw4euGbADDX8OEN4eE4mBXwWBATNN02urBpcSE
         D8HXk1uXqlTql4nAMPVOI0jWEq8TcyVeK7zvn9MqpGkyUodZHO3zU8CqWf5ELwGvZnQA
         d0rpmryjcQ3tT/amkz6qaiUp5J10wbLIM/VwLNWvZ2nk+ToYAT4M+fWEgQim0IOwyg7t
         QNjQqeb65ryll24FqVBIVcG6NUIjwQGenhULuIBk61WpsaijHMLY+Wj9zPD8nv2xVN4r
         VvaogJ0CW6fYVsHEDzzb/b0L77Qf8yWHkK9Hzinvr80WSlVlWpb1sRImVw1bRti6lLM9
         dB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=rDtzUmnoiG2SW6ahcEwMV0UyAf4f9iBmlKeuxWCc++Y=;
        b=QNDookEbR7vT7+2OEh7pXB+eoKSQGxtGLNOQwlzDDvPvDOLJgTY2wusRjXAWafZ8EB
         4U6iM6ch5X9xZ20yqqcwW8dNsO07oXbIcFEP8+L2adzesylRmfNDxmVafBq73rT+CfnK
         dwhfInghNtlaZ/+dQdT1Rbz/jO7tVERnjRCMhb3gRW83GtD16/ZTgrE/TikUNrxVBeRd
         6zjA06nTbVyErjDEA7nUjWJ20pirDhPSNSQ83SlDWskktK6DdmJohC3r+anImNu9IC2Y
         UqDelkAwvw3rDpZWihUsO+4whpcz9A2Z4oCY7TT5yoszwAo66o6Ows1W930OnXMoP+nT
         VcFQ==
X-Gm-Message-State: ALoCoQndS8bMwkm7Xz6Tcmi4fCO5i4+VJO2bEjJyjVHpXf/Z8YVyON1vdELXyMxI2AJ3jjCaj30o
X-Received: by 10.42.92.16 with SMTP id r16mr21712939icm.95.1428352098812;
 Mon, 06 Apr 2015 13:28:18 -0700 (PDT)
Received: by 10.107.46.31 with HTTP; Mon, 6 Apr 2015 13:28:18 -0700 (PDT)
In-Reply-To: <CAP8UFD2rtxL29TqkxFXyGwW4g96TgFFLDJhhyYuAi850p64OjQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266879>

I am interested in discussing the git pack protocol v2.
(I have been thinking about that for a while now,
though not sharing a lot on the mailing list, so feedback is
somewhat limited. :( )


On Mon, Apr 6, 2015 at 12:08 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Mon, Apr 6, 2015 at 12:48 AM, Thomas Ferris Nicolaisen
> <tfnico@gmail.com> wrote:
>> On Tue, Feb 24, 2015 at 11:09 PM, Jeff King <peff@peff.net> wrote:
>>> I wanted to make one more announcement about this, since a few more
>>> details have been posted at:
>>>
>>>   http://git-merge.com/
>>>
>>> since my last announcement. Specifically, I wanted to call attention to
>>> the contributor's summit on the 8th. Basically, there will be a space
>>> that can hold up to 50 people, it's open only to git (and JGit and
>>> libgit2) devs, and there isn't a planned agenda. So I want to:
>>>
>>>   1. Encourage developers to come. You might meet some folks in person
>>>      you've worked with online. And you can see how beautiful we all
>>>      are.
>>>
>>>   2. Get people thinking about what they would like to talk about.  In
>>>      past GitTogethers, it's been a mix of people with prepared things
>>>      to talk about, group discussions of areas, and general kibitzing.
>>>      We can be spontaneous on the day of the event, but if you have a
>>>      topic you want to bring up, you may want to give it some thought
>>>      beforehand.
>>>
>>> If you are a git dev and want to come, please RSVP to Chris Kelly
>>> <amateurhuman@github.com> who is organizing the event. If you would like
>>> to come, but finances make it hard (either for travel, or for the
>>> conference fee), please talk to me off-list, and we may be able to help.
>>>
>>> If you have questions, please feel free to ask me, and I'll try to get
>>> answers from the GitHub folks who are organizing the event.
>>>
>>
>> I'll be arriving around 11 am on the 8th, if anyone wants to record
>> something for the GitMinutes podcast [1]. Send me an email directly,
>> or just walk up to me at the conference and say hi! I'll hopefully be
>> hanging around the contributor's summit area with some microphones,
>> but I've been unable to get any feedback from GitHub about whether
>> this is OK, so.. I guess we'll just wing it when I get there.
>>
>> [1] http://www.gitminutes.com/
>
> By the way as far as I know nothing has been planned for the
> Contributors Summit on the 8th.
> Maybe we could list some topics that we could discuss.
>
> I will probably write very short articles about some of the
> discussions for the next Git Rev News edition, but I would be happy if
> other people would like to contribute some. Please tell me and Thomas
> if you are interested.
>
> Also I am not sure if something is planned for the evening of the 8th
> or not. If nothing is planned maybe we could discuss having dinner
> together or something.
>
> And if someone needs help or arrives in Paris early or leaves late and
> is interested in meeting up, feel free to contact me.
>
> Best,
> Christian.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
