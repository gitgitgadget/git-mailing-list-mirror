From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Sun, 1 Mar 2015 11:56:10 -0800
Message-ID: <CAGZ79kaHGw=OyrkktWeo-MR0V1_bASB1cioP+c2Ngpt6fkRxBA@mail.gmail.com>
References: <1424747562-5446-1-git-send-email-sbeller@google.com>
	<CACsJy8BSf2h_xD-Q1tudAg_xCzffRQM+7xzUgprONxD7vM5RYw@mail.gmail.com>
	<CAPc5daVbrUaU6LFM65evru0+1tBT916+0AOyids=f7DZThTPGw@mail.gmail.com>
	<xmqq1tl9gld9.fsf@gitster.dls.corp.google.com>
	<CACsJy8DKbfU7TBHhT5_qpL0QM3zbxkaF+B4x3hQDpomQ_9OSEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 20:56:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YS9yL-0005wU-IT
	for gcvg-git-2@plane.gmane.org; Sun, 01 Mar 2015 20:56:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbbCAT4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2015 14:56:13 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:46901 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbbCAT4M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2015 14:56:12 -0500
Received: by iecvy18 with SMTP id vy18so42801411iec.13
        for <git@vger.kernel.org>; Sun, 01 Mar 2015 11:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BdtaD9+V7sIfIFAiGxmlGhIXxTfO8B4ipJAquepxW8w=;
        b=YmwAJbEF/yt/hf6IkOdYAQ2/Ysiasdaz/Xc2/5GeP/H64nWN3Ow1VNBq5Pe1qaeP8K
         AGjLvD8BjX5O9e1fAEcpN12RuhnSuhArkppQybr3ZEyNhq9a1+URZoZpbhKm98HYgAVd
         kPJ3QZiuqjCiK4A0o6uH43SNXzm24mhvdCZlybbuTBqF+vYWrmQnGtDv/JWJp/eFtehE
         kHYy1I/LgvZ0dbKYE7nLXREKqmtvtbSPoN3wrqH4EomBIYE8JX+/nOOslgPR/Q8Ia6ji
         h324FuB6/wbFoYRyL2oDg8pEeUAi9uyNbaP3Bxl46TJosMSE26KranxbBcYiDv8iepLk
         5tqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=BdtaD9+V7sIfIFAiGxmlGhIXxTfO8B4ipJAquepxW8w=;
        b=W5AxcB3lIivgn2CQueJ0dJR3B5vWGa6FUI2FuOVp+LMu0ckBX4iYlgjACXVV7CRaU9
         RbOoFzKgXy9LK6ngfUz7p5kPaJ9USF2+/UXClkaLtpa2g5RmzCa+ai3H4NXAAdyETrF4
         taVol+xU+nO6QkD0QJz7PhwZSv6pGb/7w/G03Sb4z75khvzOhM40Yvm1zJ2uZht9KFNI
         R5Xd6+sQ+BzD6bSOEo8a7SHNsI/fYNcB/4tOcuhXELaOHMwsmtgi43jl81EEnE794iLk
         fWNyfVfMx3fpyLjv+h9DhaKgNboCzOfCw9jbEFZfyVmszQFaj30JTS1JmtesSQmaYBT1
         Vsng==
X-Gm-Message-State: ALoCoQmtUgxHAU+yF8IYlBqGK1SxyCLhWLN7u9Dw0AsTWtSo/oNOqFNWqv8LdVJDL34wMh8tIoSH
X-Received: by 10.43.100.67 with SMTP id cv3mr27242208icc.92.1425239770804;
 Sun, 01 Mar 2015 11:56:10 -0800 (PST)
Received: by 10.107.46.31 with HTTP; Sun, 1 Mar 2015 11:56:10 -0800 (PST)
In-Reply-To: <CACsJy8DKbfU7TBHhT5_qpL0QM3zbxkaF+B4x3hQDpomQ_9OSEg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264564>

On Sun, Mar 1, 2015 at 3:32 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Mar 1, 2015 at 3:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>  - Because the protocol exchange starts by the server side
>>>    advertising all its refs, even when the fetcher is interested in
>>>    a single ref, the initial overhead is nontrivial, especially when
>>>    you are doing a small incremental update.  The worst case is an
>>>    auto-builder that polls every five minutes, even when there is no
>>>    new commits to be fetched [*3*].
>
> Maybe you can elaborate about how to handle states X, Y... in your
> footnote 3. I just don't see how it's actually implemented. Or is it
> optional feature that will be provided (via hooks, maybe) by admin? Do
> we need to worry about load balancers? Is it meant to address the
> excessive state transfer due to stateless nature of smart-http?

The way I understand Junio here is to have predefined points which
makes it easier to communicate. There are lots of clients and they usually
want to catch up a different amount of commits, so we need to recompute it
all the time. The idea is then to compute a small pack from the original point
to one of these predefined points.
So a conversion might look like:
Client: My newest commit is dated 2014-11-17.
Server: ok here is a pack from 2014-11-17 until 2014-12-01 and then
I have prepared packs I sent out all the time of 2014-12 and 2015-01
and 2015-02 and then there will be another custom pack for you describing
changes of 2015-02-01 until now.

Mind that I choose dates instead of arbitrary sha1 values as I feel
that explains the
point better, the packs in between are precomputed because many
clients need them.

Personally I don't buy that idea, because it produces a lot of question, like
how large should these packs be? Depending on time or commit counts?

The idea I'd rather favor (I am repeating myself from another post,
but maybe a bit clearer now):

    Client: The last time I asked for "refs/heads/*" and I got a refs
        advertisement hashing to $SHA1
    Server: Ok, here is the diff from that old ref advertisement to the
        current refs advertisement.

I realize that these two ideas are not contradicting each other, but
could rather
help each other as they are orthogonal to each other. One is about
refs advertising
while the other is about object transmission.

>
>>> I'd like to see a new protocol that lets us overcome the above
>>> limitations (did I miss others? I am sure people can help here)
>>> sometime this year.
>>
>> Unfortunately, nobody seems to want to help us by responding to "did
>> I miss others?" RFH, here are a few more from me.
>
> Heh.. I did think about it, but I didn't see anything worth mentioning..
>
>>  - The semantics of the side-bands are unclear.
>>
>>    - Is band #2 meant only for progress output (I think the current
>>      protocol handlers assume that and unconditionally squelch it
>>      under --quiet)?  Do we rather want a dedicated "progress" and
>>      "error message" sidebands instead?
>>
>>    - Is band #2 meant for human consumption, or do we expect the
>>      other end to interpret and act on it?  If the former, would it
>>      make sense to send locale information from the client side and
>>      ask the server side to produce its output with _("message")?
>
> No producing _(...) is a bad idea. First the client has to verify
> placeholders and stuff, we can't just feed data from server straight
> to printf(). Producing _() could complicate server code a lot. And I
> don't like the idea of using client .po files to translate server
> strings. There could be custom strings added by admin, which are not
> available in client .po. String translation should happen at server
> side.
>
> If we want error messages to be handled by machine as well, just add a
> result code at the beginning, like ftp, http, ... do. Hmm.. this could
> be the reason to separate progress and error messages.
> --
> Duy
