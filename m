From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Helping on Git development
Date: Thu, 15 Sep 2011 16:24:22 +1000
Message-ID: <CAH5451n=yEYYb0jO85+5_0dkuupQA2_WLvnH-fwPESS1GWy4Sg@mail.gmail.com>
References: <CAOz-D1JW8RSR8kVWhT7v-DCbWayU8KhbePJwWrWvJwbmueRezQ@mail.gmail.com>
 <CAOz-D1+77JZRXa57GLz=vZyrcGs4Ojj6Wa0cSD4QcEkMP3PPsA@mail.gmail.com>
 <CAH5451me+MDe34Boak=UDjH9T_WAnO6wxa6pW+JHOoGADoNfkQ@mail.gmail.com>
 <7vehzjugdz.fsf@alter.siamese.dyndns.org> <20110914231427.GA5611@sigill.intra.peff.net>
 <7vd3f2snox.fsf@alter.siamese.dyndns.org> <20110915000851.GA6238@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Eduardo D'Avila" <erdavila@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 15 08:24:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R45NR-0006C7-A6
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 08:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624Ab1IOGYo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Sep 2011 02:24:44 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57070 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754403Ab1IOGYn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2011 02:24:43 -0400
Received: by fxe4 with SMTP id 4so319530fxe.19
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 23:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=qD/aWM8vMv7CgHJFY3XbK+WJTOZRD2pS9aZWg5lsXz8=;
        b=pINNoJrjtdtz6RUQo92aRCehEa258rdQoynuNSsonb0+J4aC1bnte+/keowfTgJN8S
         sDyisVF0lXcmaOMKJDxpwIHxRWxDO429wKQCYV9XjxJIurIQV+BPRuXZYNY7QtvePSyd
         slMlyuP/fBoiXqPb1M7vppctVD7gX6KLYFvVA=
Received: by 10.223.95.148 with SMTP id d20mr733473fan.59.1316067882316; Wed,
 14 Sep 2011 23:24:42 -0700 (PDT)
Received: by 10.152.1.161 with HTTP; Wed, 14 Sep 2011 23:24:22 -0700 (PDT)
In-Reply-To: <20110915000851.GA6238@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181442>

On 15 September 2011 10:08, Jeff King <peff@peff.net> wrote:
> On Wed, Sep 14, 2011 at 04:34:38PM -0700, Junio C Hamano wrote:
>
>> > Is there such a thing as enough coders? :)
>>
>> Ever heard of the Mythical Man-Month ;-)?
>
> I thought git was a silver bullet. :)
>
>> I was simply saying that there already are many people who scratch h=
is
>> own real itch, and we are short of the bandwidth to review them all.
>> It would not help the project at all to add more people who scratch
>> some random non-itches that nobody is actually interested in (e.g. a=
n
>> entry in an unmaintained "bug tracker" that may list irrelevant and
>> stale non issues).
>
> Yeah, that may be. But I don't look at it as "we have enough
> itch-scratchers, so we don't need more". I see it as survival of the
> fittest. You may post a patch series that needs a lot of help, but
> nobody else cares, and it dies off. Or your series may be interesting
> enough that it draws attention, to the detriment of somebody else's
> series (which may take longer to get reviewed and merged). But natura=
l
> selection only works if we have a diverse population to select from.
>
> The downside, of course, is that somebody may end up wasting time goi=
ng
> down a fruitless road. But for a new contributor, hopefully they lear=
n
> something in the process.
>
>> > =C2=A0 2. Read the list. People will report bugs. Try reproducing =
them,
>> [...]
>>
>> Yes. In the earlier steps in the above, you may find out that the
>> report was actually not a bug at all (e.g. old issue that has long
>> been fixed, pebcak, or wrong expectation), but even in such a case,
>> reporting your finding would help others.
>
> Very much agreed. I think big organizations like mozilla have people =
who
> do nothing but bug triage. We are not that big, but it has proven to =
be
> one area that is easy to break out and distribute to other people.
>
> -Peff
>

Does git even have an issue tracker? I have not seen one anywhere.

>> If you are looking to contribute to the project, a good place to sta=
rt
>> is http://git-blame.blogspot.com/p/note-from-maintainer.html and in
>> Documentation/howto/maintain-git.txt
>
> I am moderately averse to hardcoding that URL that is guaranteed not =
to
> survive the maintainer change in our README file. The howto/maintain-=
git
> document mentions the periodical "A note from the maintainer" posting=
 to
> the list that has the same text, which is a more appropriate referenc=
e.

Would a link to the wiki be more appropriate? Perhaps even a 'getting
started' page that collates information like this?

At the moment, while it is easy enough to find the information needed
to understand how the project fits together if you know where to look,
there isn't any concise summation of roles and pain points. The note
from the maintainer goes over the procedures fairly well, and the
what's cooking gives a good idea of what features are being worked on,
but it seems a little disconnected.

When kernel.org comes back online I may have a go at creating such a
page. Any thoughts?

Andrew
