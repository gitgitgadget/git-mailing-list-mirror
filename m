From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 22:50:04 +1000
Message-ID: <BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
	<4DB80747.8080401@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Apr 27 14:50:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF4C6-0002qZ-Vm
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 14:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759049Ab1D0MuH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2011 08:50:07 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:62394 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758450Ab1D0MuF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 08:50:05 -0400
Received: by vxi39 with SMTP id 39so1263934vxi.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 05:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EtwJsfT/KejZXjfYFkeA+5ynRHe0evOK27PwaGS0M64=;
        b=ULm4RZFivHw6ViPULY7Enhnxk8ENfN84tq46xRGzVhzKjMv/TnAUMO0UQvGk/owu+i
         6Jy4RoXdfx1BkuwGlodw4jlG/HEVhBUEsfKheO7wG2HW0zZYpFPVA5xlJjGftgFb9wdT
         utWi4NqCL4Y2uOgv2fZE5HaK4gHDKEFOmYtRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FObOsMhQBGFgSV4o85mOlu8R/wPesZvxuqoWT0qQo3GeBIiejogcZgr+fFY3Un8T/W
         q8sIBHq+8jVITuf8ezTQQ8TyxEAzmgoKwSnoBVKEsl2zSj1IXKgNlcTHFwfoiW0lEfqj
         2Ii0YxTUP4Pupac1vusqmJwaB1ZCBhHPScLNo=
Received: by 10.52.99.98 with SMTP id ep2mr3060992vdb.159.1303908604770; Wed,
 27 Apr 2011 05:50:04 -0700 (PDT)
Received: by 10.52.160.66 with HTTP; Wed, 27 Apr 2011 05:50:04 -0700 (PDT)
In-Reply-To: <4DB80747.8080401@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172234>

On Wednesday, April 27, 2011, Andreas Ericsson  wrote:
> On 04/27/2011 05:36 AM, Jon Seymour wrote:
>> Has anyone ever given consideration to git supporting a plugin
>> architecture for git extensions?
>>
>> The idea would be to provide a consistent way to install, and addres=
s
>> extensions to the core git functionality in a manner that does not
>> require the extension to actually be integrated into the git core.
>>
>

> Horrible idea. There are already as many package managers as there
> are packages without us throwing another one into the mix.
>

I agree that there are too many package managers. But do you know
what? There isn't a single package manager that reliably works across
platform. apt-get? great. Except you need something else for Mac,
cywgin, or, um Fedora. Brew? Fine then you only need to worry about
Linux and cygwin. Cygwin? ...

The platform for my extension is git. Not Mac. Not Debian. Not Fedora.
Not cygwin. git.

The lowest common denominator across these environments is, um, git.

I challenge the sceptIcs to specify a one line command script that
works across all possible environment that is more succinct than:

   git pm install gitwork

It shouldn't be too hard. A tar command here, an enviroment  variable
edit there. Perhaps a curl command or a browser download.

You have 4 words. Knock yourself out.

>> For example, I have recently proposed a new command 'git work'
>> https://github.com/jonseymour/git/blob/master/README.md which I thin=
k
>> is a really useful extension to git.
>>
>> I haven't had much feedback for the concept. I am not sure if it is
>> because people are too busy, just don't grok it, or grok it and don'=
t
>> think it is useful.
>>
>
> I had a look at the manpage. It seems to do more or less exactly what
> the same command would do without the word "work" thrown in, so eithe=
r
> it's quite useless or you've failed to describe its usefulness in the
> manpage.
>

It is far from useless, so I have clearly failed with the explanation.
I will post later,perhaps with some diagrams.

> "git atomic" seems nice though.
>

Thank you!

>> So, perhaps it won't be included in git. That's fine, I can build my
>> own fork of git which includes the proposed extension [ indeed, this
>> is how I originally developed it]. That's fine for
>> me, but it isn't the most practical way to distribute it to others
>> since I'll have to produce distribution packages for a variety of
>> different distribution formats or fallback to tars and zips.
>>
>
> What you can do is let your Makefile (or some other install-script)
> take the destination path for "make install" (or equivalent) from
> the output of "git --exec-path".
>
> That way, you can ship "git extadd" or whatever you want to call it
> as a simple installer that installs executable and man-page in their
> proper locations. If the commands you install require configuration
> by default I'd say they're broken to begin with, but even that can
> be remedied by running "git config --add key value" from the installe=
r.
>
> So in a way, git is already its own pkg-config binary and anyone
> clever enough to write useful scripts that enhances git will almost
> certainly see that and use it from their favourite language quite
> without having to learn some new magic format for package management.
>

Those 3 paragraphs were substantially longer than 4 words. Again,
there is a tar ball, let me know how I can install it across alll
environments that got runs on. Make sure the man pages work.

jon.


> --
> Andreas Ericsson =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 andreas.ericsson@op5.se
> OP5 AB =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 www.op5.se
> Tel: +46 8-230225 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0Fax: +46 8-230231
>
> Considering the successes of the wars on alcohol, poverty, drugs and
> terror, I think we should give some serious thought to declaring war
> on peace.
>
