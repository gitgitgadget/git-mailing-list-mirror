From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [ANNOUNCE] Git Merge Contributors Summit, April 8th, Paris
Date: Tue, 7 Apr 2015 15:55:55 +0200
Message-ID: <CACBZZX5mZgHxicZGTGsgAxBCZuRymrariAeHK0vf5+Qs1EzA2A@mail.gmail.com>
References: <20150224220923.GA23344@peff.net> <CAEcj5uV7XpXZTEyDrubXfWoN5uYn5BJbGaMbrWrmXbmgiCOHqg@mail.gmail.com>
 <CAP8UFD2rtxL29TqkxFXyGwW4g96TgFFLDJhhyYuAi850p64OjQ@mail.gmail.com> <CAGZ79kat=W2mod_c8u2ojUG08faw8KU5N5BDeBLvJ4iOUv_=bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Jeff King <peff@peff.net>, Git <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 15:56:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfTzM-00068H-6v
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 15:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145AbbDGN4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2015 09:56:20 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:33009 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754109AbbDGN4S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2015 09:56:18 -0400
Received: by oblw8 with SMTP id w8so39429875obl.0
        for <git@vger.kernel.org>; Tue, 07 Apr 2015 06:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vKK68LEl3QFHqMnG4JxLAq71bNLZhrcZ4BTAtTfaYaI=;
        b=I86QPTkZJ9dmpmo9baccv4zKex0gCWCf7mvUVo2aakUuXdiGdHGqFKLH+ukWaSZ4sq
         miWDEvL+CkGtLPIDPKCboTSdfd1c/DDZuj3/B9I0htHzR8BF6MtbVB+HFo15F8VrUGgm
         kpmyHlmk0oy/urcwEaz/jRbcKqXi4Lryk8GOBIENdZ0hYChh7Vpc74wxkvO0jqZyBh4P
         5EljfU8xdILtmPvEDIxVhIrmZGOokREhNXOkxFOavRw6nws1awoNTChNcNqG1bdDGFl6
         WlRVwtuzSaSW45+nfywY344lF0I5TqPtdQ2+d9C0cDckSHy3gqNpt/WlnbbYfdNW8lAe
         iOeg==
X-Received: by 10.182.250.134 with SMTP id zc6mr3723387obc.78.1428414975484;
 Tue, 07 Apr 2015 06:56:15 -0700 (PDT)
Received: by 10.76.82.1 with HTTP; Tue, 7 Apr 2015 06:55:55 -0700 (PDT)
In-Reply-To: <CAGZ79kat=W2mod_c8u2ojUG08faw8KU5N5BDeBLvJ4iOUv_=bQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266915>

On Mon, Apr 6, 2015 at 10:28 PM, Stefan Beller <sbeller@google.com> wrote:
> I am interested in discussing the git pack protocol v2.
> (I have been thinking about that for a while now,
> though not sharing a lot on the mailing list, so feedback is
> somewhat limited. :( )

I'm keen to talk about the new protocol and other scaling issues I
raised in the recent "Git Scaling: What factors most affect Git
performance for a large repo?" thread. Although from my testing the
main problems in performance are the local pack-refs file &
reachability checks, mostly not the protocol itself.

At the risk of using this list + the venue for soliciting I also want
to mention that my employer is willing to pay someone on a contract
basis to work on Git scalability issues, given the right person etc.
etc. So if someone's at the conference is interested in that I'd be
keen to talk to you.

> On Mon, Apr 6, 2015 at 12:08 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> On Mon, Apr 6, 2015 at 12:48 AM, Thomas Ferris Nicolaisen
>> <tfnico@gmail.com> wrote:
>>> On Tue, Feb 24, 2015 at 11:09 PM, Jeff King <peff@peff.net> wrote:
>>>> I wanted to make one more announcement about this, since a few more
>>>> details have been posted at:
>>>>
>>>>   http://git-merge.com/
>>>>
>>>> since my last announcement. Specifically, I wanted to call attention to
>>>> the contributor's summit on the 8th. Basically, there will be a space
>>>> that can hold up to 50 people, it's open only to git (and JGit and
>>>> libgit2) devs, and there isn't a planned agenda. So I want to:
>>>>
>>>>   1. Encourage developers to come. You might meet some folks in person
>>>>      you've worked with online. And you can see how beautiful we all
>>>>      are.
>>>>
>>>>   2. Get people thinking about what they would like to talk about.  In
>>>>      past GitTogethers, it's been a mix of people with prepared things
>>>>      to talk about, group discussions of areas, and general kibitzing.
>>>>      We can be spontaneous on the day of the event, but if you have a
>>>>      topic you want to bring up, you may want to give it some thought
>>>>      beforehand.
>>>>
>>>> If you are a git dev and want to come, please RSVP to Chris Kelly
>>>> <amateurhuman@github.com> who is organizing the event. If you would like
>>>> to come, but finances make it hard (either for travel, or for the
>>>> conference fee), please talk to me off-list, and we may be able to help.
>>>>
>>>> If you have questions, please feel free to ask me, and I'll try to get
>>>> answers from the GitHub folks who are organizing the event.
>>>>
>>>
>>> I'll be arriving around 11 am on the 8th, if anyone wants to record
>>> something for the GitMinutes podcast [1]. Send me an email directly,
>>> or just walk up to me at the conference and say hi! I'll hopefully be
>>> hanging around the contributor's summit area with some microphones,
>>> but I've been unable to get any feedback from GitHub about whether
>>> this is OK, so.. I guess we'll just wing it when I get there.
>>>
>>> [1] http://www.gitminutes.com/
>>
>> By the way as far as I know nothing has been planned for the
>> Contributors Summit on the 8th.
>> Maybe we could list some topics that we could discuss.
>>
>> I will probably write very short articles about some of the
>> discussions for the next Git Rev News edition, but I would be happy if
>> other people would like to contribute some. Please tell me and Thomas
>> if you are interested.
>>
>> Also I am not sure if something is planned for the evening of the 8th
>> or not. If nothing is planned maybe we could discuss having dinner
>> together or something.
>>
>> And if someone needs help or arrives in Paris early or leaves late and
>> is interested in meeting up, feel free to contact me.
>>
>> Best,
>> Christian.
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
