From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 18:19:52 -0400
Message-ID: <i2l32541b131005071519nf49f8703s76f42f4fe9939b6f@mail.gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com> 
	<g2s32541b131005071258s92e058bakc8f3a4df1e1dc634@mail.gmail.com> 
	<alpine.LFD.2.00.1005071303040.901@i5.linux-foundation.org> 
	<alpine.LFD.2.00.1005071306190.901@i5.linux-foundation.org> 
	<576B55DC-C92D-4FEB-B4E8-4A042D6F024B@gmail.com> <alpine.LFD.2.00.1005071355380.901@i5.linux-foundation.org> 
	<384AA932-227B-43B0-9D38-560A3567918A@gmail.com> <alpine.LFD.2.00.1005071421340.901@i5.linux-foundation.org> 
	<m2z32541b131005071430vcd851ac8yd3c783429a84f875@mail.gmail.com> 
	<alpine.LFD.2.00.1005071441341.901@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	hasan.aljudy@gmail.com, kusmabite@googlemail.com, prohaska@zib.de
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat May 08 00:20:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAVu9-0006j1-G2
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 00:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800Ab0EGWUO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 18:20:14 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55436 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460Ab0EGWUN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 18:20:13 -0400
Received: by gyg13 with SMTP id 13so935263gyg.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 15:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=hwpzQW0yQ7h5t6jHw4spE0OFwWIlBREHfiZ+f9lOEYE=;
        b=P3Ky1FWezvBi1tRjwsqzsfrS18AGZofQ+k0eN33aR+ZhZebn0fkujGrUmOH6lc+u3r
         Jcs5qGhvlK+DyksVjl7AZgTRMrDbspUUUwrZk3e3rLZlxOH+l6J5WqLqebJT6JmnyVgW
         koNvIf5ifsYxROLOuh5bSchMMg0H3dkAZXFyU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=XA5lhukUagE5CitvYycSZOJEmhDDZgPdW8aaOCIuLf4MV+VL5clmdEg3XIHefB7Md6
         ltkx9jUatWuH/k/u8flzrjO+NEWTEbLPkeaTikF6tXtKCznrMIOGQqkg9BMA4fZpNYEW
         f0SQJCRcR4l9VDoAya6duY49KQO5+hPRI0AC0=
Received: by 10.150.254.5 with SMTP id b5mr4108398ybi.161.1273270812223; Fri, 
	07 May 2010 15:20:12 -0700 (PDT)
Received: by 10.150.217.12 with HTTP; Fri, 7 May 2010 15:19:52 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1005071441341.901@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146612>

On Fri, May 7, 2010 at 5:54 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, 7 May 2010, Avery Pennarun wrote:
>> > I think "* auto-eol=3Dtrue" is just crazy. We would _never_ want t=
o do that.
>> > Any project that does that should be shot in the head.
>>
>> Just to clarify, is it crazy because that line would convert all
>> files, even binary ones, where core.autocrlf auto-detects whether
>> files are binary or text?
>
> No, presumably 'auto-eol' does the same auto-detection. Otherwise the=
 name
> wouldn't make sense.
> [...]
> Eyvind Bernhardsen wrote:
>> Also, I meant to write "* crlf=3Dauto", not "* auto-eol=3Dtrue", if =
that makes it
>> any less crazy.
>
> Oh, yes. See my other email. "* crlf=3Dauto" is at least sensible, al=
though
> somewhat scary. At least with core.autocrlf=3Dtrue, the user has to h=
ad
> [...]
> =A0(b) But let's say that you want to do it anyway (because you're la=
zy
> =A0 =A0 and because autocrlf works pretty damn well in practice), isn=
't that
> =A0 =A0 a really ugly and crazy thing to add _another_ attribute name=
 for
> =A0 =A0 that?
>
> =A0 =A0 IOW, if you really want to say "do automatic crlf for this se=
t of
> =A0 =A0 paths", the natural syntax for that would be
>
> =A0 =A0 =A0 =A0* crlf=3Dauto

Oh, good grief, I'm just getting more and more confused.

So just to keep all of this straight, I think there are still two
proposals under consideration here:

a) add an in-project .gitconfig, in which case the above crlf=3Dauto is
exactly equivalent to "crlf attribute missing" (which is different
from "crlf unset", hee hee, are we having fun yet?) since the crlf
attribute is ignored unless core.autocrlf=3Dtrue, and missing means to
use the core.autocrlf setting;

OR

b) change the semantics of the crlf attribute, in which case crlf=3Daut=
o
is a new mode that means "use autocrlf on this file even if
core.autocrlf is unset or unspecified".

Right?  So in case (a), the new crlf=3Dauto option is unneeded.  Though
it does seem as if we're trending toward case (b).

Thanks,

Avery
