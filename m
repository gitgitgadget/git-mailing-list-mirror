From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Git Rebase blows away GIT_AUTHOR_NAME
Date: Fri, 14 Jan 2011 17:30:51 +0100
Message-ID: <AANLkTimcQq++CLv66AyTve+PiXBhYdUPk2epCyOXX1c0@mail.gmail.com>
References: <AANLkTimvK3p3M8kbGzLxyhchoFONiD4=FGPWxxs=i0GA@mail.gmail.com>
 <AANLkTikqfX3jhSdP5xhFj=VktqW2S6AeGL_MF18g8ZA_@mail.gmail.com>
 <AANLkTimf2rwKqyWwQbdj7cjS8YcQwCXYGRCvQbZ5HZ19@mail.gmail.com>
 <AANLkTik15iV9SOv6rRL5+DQkAZ4JwBGTS+gqS3nXy2hN@mail.gmail.com>
 <AANLkTikk7Xdiey76Dmy848_B4qNX2-Vbis7p=E8vtNL9@mail.gmail.com>
 <AANLkTimONqL4=E4Unrsj9PU5u57KGXrmO6xWUOCLorgs@mail.gmail.com>
 <AANLkTi=PTgmOSC7pRLjujO5fi9Wdp69Jmj4zCkhGSYSz@mail.gmail.com>
 <AANLkTiksAZSi-Yo8yJv5ca9XWWvB3iVQhZOJtTs-F8gk@mail.gmail.com>
 <AANLkTi=Z6Dx6m68zi7Q1eRVxX3DXOyKj+Ff177UCQrAj@mail.gmail.com>
 <AANLkTimZF+r2aNzrXsUuHVZR65N5wpOYLutFgGAGoci_@mail.gmail.com> <20110114162144.GA867@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Tor Arntsen <tor@spacetec.no>, JT Olds <jtolds@xnet5.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 14 17:32:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdmZD-0007rL-NP
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 17:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757934Ab1ANQby convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Jan 2011 11:31:54 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46488 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757950Ab1ANQbx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jan 2011 11:31:53 -0500
Received: by bwz15 with SMTP id 15so2678012bwz.19
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 08:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=vljOBfTvm3RlB8V1QMeK6bAtP1lmKAUZjE2jUfq5tEA=;
        b=mwstma9kx1vekZBA61YN84y6oHV0XHvt/WDTMWt8RV/RmX5dm9sSpEydCpj6b7ihFa
         4Ec0Zt2uCZGWs6Uua0R6ArUmye9vGqDCW5Z2iwGJtKywAJe34nv8RpmAeDqz6ylYXdka
         BNF8JSN9jHOW4XMUclaUjldiGwGWTvkJAGpc0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=FaYz9jrR+jUlJg5VapdThzg/qhGpw0iyffquvnk5F6tXU/h90czN+JoynSO90HcRJ5
         Cs0rbyQ2KFytLGa3HwJLxR7CY0WGD5eNoUNfiirkXcD2/6Juz90Z8EUdtgUi4SbFU1Sj
         WhTll8UriZ/m3WNrwFjehMIn0S6zM2HCJclsA=
Received: by 10.223.73.198 with SMTP id r6mr949202faj.14.1295022671617; Fri,
 14 Jan 2011 08:31:11 -0800 (PST)
Received: by 10.223.79.3 with HTTP; Fri, 14 Jan 2011 08:30:50 -0800 (PST)
In-Reply-To: <20110114162144.GA867@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165112>

On Fri, Jan 14, 2011 at 5:21 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Jan 14, 2011 at 05:13:59PM +0100, Erik Faye-Lund wrote:
>
>> > The three-letter minimum is just a sanity check. If your name real=
ly
>> > is even just three letters, I suspect you're just lying. I don't k=
now
>> > of anybody named "A B".
>> >
>> Thanks for clarifying that it's not there for a technical reason. Th=
e
>> thing is, git-am seems to be the only place where such a sanity-chec=
k
>> is performed. Shouldn't git-commit rather perform such checks also (=
if
>> such a check should be done at all), perhaps with an override simila=
r
>> to --allow-empty? And on top of all it doesn't barf, it just silentl=
y
>> replace the name with the e-mail...
>
> I tend to agree with Linus on the stupidity issue, but I do worry abo=
ut
> the subtlety of the results. It causes silent data corruption during =
a
> rebase (or when somebody is applying an emailed patch). On the other
> hand, I do understand why Linus made a sanity check in the first plac=
e;
> his use case is to deal with whatever crap people happen to mail him,
> whether they have used git or not.
>
> So we should probably do one or both of:
>
> =A01. Make an --allow-any-name option to mailinfo, and use it when we
> =A0 =A0 invoke mailinfo internally for rebasing. That still doesn't s=
olve
> =A0 =A0 the emailed patch problem, but at least keeps purely internal
> =A0 =A0 operations sane.
>
> =A02. Bump the check up to git-commit time, which is the best place t=
o
> =A0 =A0 catch and tell somebody that their name is too short, because=
 they
> =A0 =A0 can actually fix it.
>

The problem with (2) is that git-am uses git-commit-tree rather than
git-commit. But I do think that adding the same checks to git-commit
would make sense. Unless we decide to remove the checks, that is...
