From: Christian Couder <christian.couder@gmail.com>
Subject: Fwd: [PATCH 7/8] config: add core.untrackedCache
Date: Fri, 18 Dec 2015 23:40:35 +0100
Message-ID: <CAP8UFD1kWd9Y9pLfz2aAHNQjtxOrhLk25ExZPU7p0OFfiixuow@mail.gmail.com>
References: <CAP8UFD3at0X9ThpXGTwyPnu_dXFj6x=YzfkCa82m+RsWwhFOOA@mail.gmail.com>
	<xmqq6100ke7v.fsf@gitster.mtv.corp.google.com>
	<xmqqa8pciuqq.fsf@gitster.mtv.corp.google.com>
	<CACBZZX6=sU2cb_vRn5DAqVEuNTwsk0m7vQ0_WUp5qPWeQq5JhQ@mail.gmail.com>
	<xmqqh9jjfqk4.fsf@gitster.mtv.corp.google.com>
	<CACBZZX7QW2J6DcMSXTa1y+QdMrqq5DXs1Fu3m8toV5a4yZKNjw@mail.gmail.com>
	<xmqqy4cvco25.fsf@gitster.mtv.corp.google.com>
	<20151216024605.GA618@sigill.intra.peff.net>
	<xmqqwpsfdl5y.fsf@gitster.mtv.corp.google.com>
	<xmqqoadrdj22.fsf@gitster.mtv.corp.google.com>
	<20151217074443.GA4830@sigill.intra.peff.net>
	<CACsJy8BwARfGmGBXEdWHnDxxXcubZDzjCg7Zy6qD0qzHZWGoFw@mail.gmail.com>
	<CAP8UFD0S_rWKjWiq_enkN+QVtvnq9fuwAxuuVTXTxu-F1mw4dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 18 23:40:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aA3he-0000BU-3K
	for gcvg-git-2@plane.gmane.org; Fri, 18 Dec 2015 23:40:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbbLRWkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2015 17:40:37 -0500
Received: from mail-lb0-f180.google.com ([209.85.217.180]:33718 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbbLRWkg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2015 17:40:36 -0500
Received: by mail-lb0-f180.google.com with SMTP id kw15so71489670lbb.0
        for <git@vger.kernel.org>; Fri, 18 Dec 2015 14:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1peCK4VDZJ/tPiJ2+3bownoevxHKjqAnuUEteWYlqQY=;
        b=gjWlZPX4OpmoThcP+ir0FDkqE6kunVSEOE9lmztxCakQ7zKOgXheGxI4lyTdvB5OvT
         cEcJoaL9wEWDPRRdYHNAcWg7cn6YBcZVIGqCIEIZ0ZhyWLKr1UQNaZ2B69BqL9Fb6Sir
         PqhcVI6gB0akE8Y/Z5R+AHj+niBbzVCWjsb6eFHQiy8UpdG/xUsfX4g1N7vfHc8m4HZ4
         H/5dfSPxUki+yyWqqYCtHW8o9UKm7yHpFGcFYRTsk4yglC9R4g9BPbR7LExFJSJtuM4E
         smfJI/+Mk/0qGqQ8QekMj+5AjPLElsXD6fRk5CheyGjmPAPP3Jl9RSV58xtSzbikKzEk
         fgkw==
X-Received: by 10.112.36.130 with SMTP id q2mr2292349lbj.116.1450478435136;
 Fri, 18 Dec 2015 14:40:35 -0800 (PST)
Received: by 10.25.152.7 with HTTP; Fri, 18 Dec 2015 14:40:35 -0800 (PST)
In-Reply-To: <CAP8UFD0S_rWKjWiq_enkN+QVtvnq9fuwAxuuVTXTxu-F1mw4dg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282718>

(Sorry I sent this one privately to Duy by mistake too.)


---------- Forwarded message ----------
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, Dec 18, 2015 at 11:35 PM
Subject: Re: [PATCH 7/8] config: add core.untrackedCache
To: Duy Nguyen <pclouds@gmail.com>


On Thu, Dec 17, 2015 at 1:26 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Dec 17, 2015 at 2:44 PM, Jeff King <peff@peff.net> wrote:
>> I think we may actually be thinking of the same thing. Naively, I would
>> expect:
>>
>> ..
>>   - if there is cache data in the index but that config flag is not set,
>>     presumably we would not update it (we could even explicitly drop it,
>>     but my understanding is that is not necessary for correctness, but
>>     only as a possible optimization).
>
> No, if somebody adds or removes something from the index, we either
> update or drop it, or it's stale. There's the invalidate_untracked()
> or something in dir.c that we can hook in, check config var and do
> that. And because config is cached recently, it should be a cheap
> operation.

I think I understand what you are saying but it took me a long time,
and I am not sure it is very clear to others.

What I understand is that you are talking about
validate_untracked_cache() in dir.c.
And you suggest to check there if the core.untrackedCache config var
is set, and, if it is not set, then to drop the UC there.
And the reason for that is that git operations on other parts of the
index should update the UC if it exists otherwise the UC content could
be wrong as you explained previously in your "git rm --cached foo"
example.

In the current patch, the code to create or remove the UC to reflect
the state of the core.untrackedCache config var is in
wt_status_collect_untracked().
I think it works well there, but if you are saying that it's better if
it is in validate_untracked_cache(), I am willing to consider moving
it to validate_untracked_cache().
Could you tell a bit though about why you think it's better in
validate_untracked_cache()?

> Apart from that the idea is fine.

Ok so, except maybe the part about wt_status_collect_untracked() vs
validate_untracked_cache(), what the patch does is ok for you?
