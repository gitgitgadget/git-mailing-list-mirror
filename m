From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Git Rebase blows away GIT_AUTHOR_NAME
Date: Fri, 14 Jan 2011 17:13:59 +0100
Message-ID: <AANLkTimZF+r2aNzrXsUuHVZR65N5wpOYLutFgGAGoci_@mail.gmail.com>
References: <AANLkTinMX0yEPvSc-c=96R42SbFZTjW5Mnveuxk3ZHS=@mail.gmail.com>
 <20110112182150.GC31747@sigill.intra.peff.net> <AANLkTimanDRHwoqSj7i9sVCZkze1L3Qp-zFYwTwHAOHX@mail.gmail.com>
 <AANLkTimvK3p3M8kbGzLxyhchoFONiD4=FGPWxxs=i0GA@mail.gmail.com>
 <AANLkTikqfX3jhSdP5xhFj=VktqW2S6AeGL_MF18g8ZA_@mail.gmail.com>
 <AANLkTimf2rwKqyWwQbdj7cjS8YcQwCXYGRCvQbZ5HZ19@mail.gmail.com>
 <AANLkTik15iV9SOv6rRL5+DQkAZ4JwBGTS+gqS3nXy2hN@mail.gmail.com>
 <AANLkTikk7Xdiey76Dmy848_B4qNX2-Vbis7p=E8vtNL9@mail.gmail.com>
 <AANLkTimONqL4=E4Unrsj9PU5u57KGXrmO6xWUOCLorgs@mail.gmail.com>
 <AANLkTi=PTgmOSC7pRLjujO5fi9Wdp69Jmj4zCkhGSYSz@mail.gmail.com>
 <AANLkTiksAZSi-Yo8yJv5ca9XWWvB3iVQhZOJtTs-F8gk@mail.gmail.com> <AANLkTi=Z6Dx6m68zi7Q1eRVxX3DXOyKj+Ff177UCQrAj@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tor Arntsen <tor@spacetec.no>, JT Olds <jtolds@xnet5.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 14 17:14:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdmIE-0002zz-5C
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 17:14:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757884Ab1ANQOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 11:14:22 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33051 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757637Ab1ANQOU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 11:14:20 -0500
Received: by fxm20 with SMTP id 20so2911860fxm.19
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 08:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=VgpIofF7v2OF2XJyTwwi85K1crOmyHSr5+IUquxO2qA=;
        b=B0wLusQ97Tx3IFhDhZxQXE7UOYZcYEAFWBzA09XHNXQQbrKqcyfQCZWccT0OMJItQ4
         gI/KMls6XGCTqsjZrQm69BTccLt7gMks7xbtc4hGECULWXC204bgj8xQVVviQk+i/Qlq
         2wJnzKz9L3DbTR3hH3+7px7CeYL3sdrBtAqvM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=ir+6MFaktgLCANsLzf4xckkDHzWpkqr+aN61N0HFbsuXWoWcMTOeKHre+BwWVTCLZY
         quoXG+LVa8TmOsPmjYoEhF6ZSQD4gUPx/oN16ZVnNXs/PGU0hFgQowfBS7H8goJ7m5mt
         m6IiV0GSMg888QUcENwer7DggnX9GeGgo6ReU=
Received: by 10.223.83.197 with SMTP id g5mr917061fal.52.1295021659210; Fri,
 14 Jan 2011 08:14:19 -0800 (PST)
Received: by 10.223.79.3 with HTTP; Fri, 14 Jan 2011 08:13:59 -0800 (PST)
In-Reply-To: <AANLkTi=Z6Dx6m68zi7Q1eRVxX3DXOyKj+Ff177UCQrAj@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165108>

On Fri, Jan 14, 2011 at 4:41 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Jan 14, 2011 at 1:53 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>>
>> Linus, you wrote sanity_check (from 2744b23). Do you remember if there
>> were any specific reason for the minimum length of 3 of an
>> author-name? It seems that in Sweden, legal names can be even a single
>> letter (see Tor's comment)...
>
> Even if the legal name would be a single letter, you'd still need to
> have a surname.
>

I think Tor pointed out that he knew a swede with his full legal name
to be only one letter long. I would suppose that meant that he didn't
have a surename?

> The three-letter minimum is just a sanity check. If your name really
> is even just three letters, I suspect you're just lying. I don't know
> of anybody named "A B".
>

Thanks for clarifying that it's not there for a technical reason. The
thing is, git-am seems to be the only place where such a sanity-check
is performed. Shouldn't git-commit rather perform such checks also (if
such a check should be done at all), perhaps with an override similar
to --allow-empty? And on top of all it doesn't barf, it just silently
replace the name with the e-mail...

> That thing is supposed to be a *NAME*. Not shorthand. Not your first
> name. Not your nickname. If you have a nickname, put it in quotes
> inside the real name.
>
> I've seen too many broken source control systems that just take your
> login as a name *cough*CVS*cough*, and then people think it's
> "convenient" and "cool" to have a short name.
>
> It's not convenient. It's not cool. It's just shorthand where
> shorthand doesn't help. Then you end up using it in a public setting,
> and suddenly your cool shorthand or nickname isn't even remotely
> unique.
>
> No, there is no uniquness "requirements" for the name, but come on.
> Look at shortlog output some day. We try to use just the name because
> it looks better. But if people don't use their full name, it just
> looks _stupid_

I agree with you that using nicknames etc as author-name is a bit
silly, but I'm not sure if I want my version control system to tell me
that it thinks my author-name looks stupid :)

IMO, we should probably just remove the check altogether.

There's also an upper-bound of 60 characters. I'm wondering if this
could be hit by valid names, especially with non-western UTF-8
characters. Perhaps this should be removed also. The check for '@',
'<' and '>' is probably still OK.
