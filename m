From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC PATCH 0/24] Documentation: refactor config variable 
	descriptions
Date: Mon, 26 Jul 2010 19:05:51 +0000
Message-ID: <AANLkTikPg3icj2u7IedfkHStsK4lBI27KAAzUXVFJeyY@mail.gmail.com>
References: <cover.1280169048.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jul 26 21:06:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdT07-0004ny-9F
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 21:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754971Ab0GZTFx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jul 2010 15:05:53 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:63811 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754416Ab0GZTFw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jul 2010 15:05:52 -0400
Received: by gwb20 with SMTP id 20so190310gwb.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 12:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=enCo2STW+WtI5077Kuz6N3vLtx4dJqYpswxdNTF6tKA=;
        b=wwM4sD6uW/upcXVai2QjysFQzyQm5O3l/uuxEMxYNoSeRuH7ecYhAMdYWANlnOzYf8
         qkJM/I69BUO+XZPBEPZ62kR7XKZTvnDZ+yMoXZCYwTxs4pbWEoOWyPnL8TRLxk3P0MYH
         ZxhnzkXuePIJy5Tnnf38i4lEoFzcU005tqgbM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=m1IC/YuMofVNjqvjTai0YADDo6xXMxnR7P5gMm+FXzfjZDB0mq239VzGDBfDXSqJOB
         E1/c/0KgDO2rigUQiXpjiRETpAIKSIpW3I2u07/WrYA7qtcYc8Izbe4kMNz/90JYkj7T
         xzkjw1IwuBp5qKtIBOPa0cbouAy93kAQHi8P8=
Received: by 10.100.34.19 with SMTP id h19mr8267510anh.2.1280171151541; Mon, 
	26 Jul 2010 12:05:51 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Mon, 26 Jul 2010 12:05:51 -0700 (PDT)
In-Reply-To: <cover.1280169048.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151883>

On Mon, Jul 26, 2010 at 18:48, Thomas Rast <trast@student.ethz.ch> wrot=
e:
> This little series is a bit of a spinoff from
>
> =C2=A0http://article.gmane.org/gmane.comp.version-control.git/146696
> and
> =C2=A0http://article.gmane.org/gmane.comp.version-control.git/145139
>
> Since I didn't want to spam the list with 24 RFC emails, I squashed
> all the manpage-specific patches into one for this submission. =C2=A0=
You
> can find the originals at
>
> =C2=A0git://repo.or.cz/git/trast.git t/doc-config-extraction
>
> Judging from its size it's quite possible that
>
> =C2=A0[1/24] Documentation: Move variables from config.txt to separat=
e file
>
> won't make it through to the list, either, and -M doesn't help, so yo=
u
> may have to look it up at the above repository too.
>
>
> Work so far:
>
> I moved the variables from config.txt and merge-config.txt to a new
> file, and made a little helper script that expands @@CONFIG(key)@@ in
> the asciidoc files, driven by the Makefile of course.
>
> I then went over the manpages in the "Main Porcelain Commands" list o=
f
> git(1) and either (easy case) added a "CONFIGURATION" section with th=
e
> relevant variables or (hard case) tried to refactor the descriptions
> so that they are only kept in one place.
>
> =C3=86var kindly rewrote the Perl script in a more readable and error=
-safe
> style, which I squashed for this posting. =C2=A0It's still a separate=
 patch
> at the above link, too.

This whole series does some much needed improvement on config documenta=
tion.

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

> Further directions:
>
> I'm a bit hesitant to go in Peff's suggested direction of outright
> removing all variables from git-config(1). =C2=A0I would prefer to bo=
th
> have the short list and group them by some category system, if that
> happens to work out. =C2=A0Perhaps the categorized list can eventuall=
y be
> removed once we can verify that all variables are documented in
> another manpage.
>
>
> Known omissions/todos:
>
> * git-gc has an elaborate prose section to the same effect that I
> =C2=A0wasn't quite ready to tear apart yet
>
> * git-notes has excellent custom descriptions from Jonathan's series
> =C2=A0that I didn't want to refactor
>
> * The description of format.pretty in git-log.txt is unsatisfactory
>
> * check-docs or some other make target should verify that no manpage
> =C2=A0links to itself

All these can be done later.
