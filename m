From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] compat: Add another rudimentary poll() emulation
Date: Thu, 27 May 2010 16:44:03 +0200
Message-ID: <AANLkTin8MTa5zUhqh3dOfNN0nmI2kAeiqNreYn7TZnf1@mail.gmail.com>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org>
	<1274948384-167-2-git-send-email-abcd@gentoo.org>
	<20100527101043.GA4390@progeny.tock>
	<AANLkTikYa2vq4PrKrO2QIkHVxYqbhUZRw42kQq875FNT@mail.gmail.com>
	<AANLkTikezlVaX8ARkRw8kEk9wL9RL_5I6X3vK83nzFUl@mail.gmail.com>
	<AANLkTil_dqbXChKpMJ_ZFTuNrF8tQRwJd5j4SkLOaPaJ@mail.gmail.com>
	<AANLkTik2UAA51BZWIKadAcIg8t2xg1u980Gq_IOSyz6o@mail.gmail.com>
	<AANLkTiko_Azw-cXNFe11oXkijvtER2I9qiRE_gVFouht@mail.gmail.com>
	<AANLkTikDcZRHpKp9phlThK5x-8A0OfTYIlhGkqookiFj@mail.gmail.com>
	<AANLkTil-nMo5E2laacYm48-HGbhseEICWsUHwTlc3l47@mail.gmail.com>
	<AANLkTimo2P3JIJ2zhD3QtT2wgfr4WmXPkVVxUDpiOfJH@mail.gmail.com>
	<AANLkTilsqlqX0f8_LhXBssCGMuTdS_mCw7V3lVrMb4XK@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jonathan Callen <abcd@gentoo.org>, git@vger.kernel.org,
	mduft@gentoo.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Sixt <j6t@kdbg.org>,
	msysGit <msysgit@googlegroups.com>
To: Marko Kreen <markokr@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 27 16:44:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHeJn-000257-WE
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 16:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757858Ab0E0OoK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 May 2010 10:44:10 -0400
Received: from mail-ww0-f52.google.com ([74.125.82.52]:45206 "EHLO
	mail-ww0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757709Ab0E0OoJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 May 2010 10:44:09 -0400
Received: by wwg30 with SMTP id 30so20126wwg.11
        for <git@vger.kernel.org>; Thu, 27 May 2010 07:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=zfe9IqeyXFRlBCwwcSOJABcHzaNgjXbOPotyAyGaCuA=;
        b=Ky9BKlxdVGGZorzv7eIpSkD7N4YEMr2zxLYtbYtzhUu1ZOrSmQEwl0usvBqXkJWfrM
         +wrxIPPg52bYKh5C4CiXbgjowEcfi713P5aKy6lH79ADrZYsbdYP37/kt8SAqp3W/c0M
         Jstn9TyzKzAIwLgE50fe23JEtxy15T+sZN4ys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=Iby740d27QPx148y8lrdPsEDSHnAwHATsXsbW6jgZML/AHAM+msE9NQpEQfuVn5xm1
         X/DU/kdnnfr41N4ipNeXzyd5H0nscesecTQ9NizZvIEFrfUejlme0movRsY5+RyeNphS
         O81KyI4ztbl6accQzW8hodpmHw63QEn2W1cxs=
Received: by 10.216.85.74 with SMTP id t52mr712018wee.99.1274971444295; Thu, 
	27 May 2010 07:44:04 -0700 (PDT)
Received: by 10.216.21.73 with HTTP; Thu, 27 May 2010 07:44:03 -0700 (PDT)
In-Reply-To: <AANLkTilsqlqX0f8_LhXBssCGMuTdS_mCw7V3lVrMb4XK@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147866>

On Thu, May 27, 2010 at 4:32 PM, Marko Kreen <markokr@gmail.com> wrote:
> On 5/27/10, Erik Faye-Lund <kusmabite@googlemail.com> wrote:
>> On Thu, May 27, 2010 at 4:11 PM, Marko Kreen <markokr@gmail.com> wro=
te:
>> =A0> On 5/27/10, Erik Faye-Lund <kusmabite@googlemail.com> wrote:
>> =A0>> On Thu, May 27, 2010 at 3:58 PM, Marko Kreen <markokr@gmail.co=
m> wrote:
>> =A0>> =A0> On 5/27/10, Erik Faye-Lund <kusmabite@googlemail.com> wro=
te:
>> =A0>> =A0>> On Thu, May 27, 2010 at 3:29 PM, Marko Kreen <markokr@gm=
ail.com> wrote:
>> =A0>> =A0>> =A0> On 5/27/10, Erik Faye-Lund <kusmabite@googlemail.co=
m> wrote:
>> =A0>> =A0>> =A0>> On Thu, May 27, 2010 at 1:00 PM, Erik Faye-Lund
>> =A0>> =A0>> =A0>> =A0<kusmabite@googlemail.com> wrote:
>> =A0>> =A0>> =A0>> =A0> On Thu, May 27, 2010 at 12:10 PM, Jonathan Ni=
eder <jrnieder@gmail.com> wrote:
>> =A0>> =A0>> =A0>> =A0>> Implement the subset of poll() semantics nee=
ded by git in terms of
>> =A0>> =A0>> =A0>> =A0>> select(), for use by the Interix port. =A0In=
spired by commit 6ed807f
>> =A0>> =A0>> =A0>> =A0>> (Windows: A rudimentary poll() emulation, 20=
07-12-01).
>> =A0>> =A0>> =A0>> =A0>>
>> =A0>> =A0>> =A0>> =A0>
>> =A0>> =A0>> =A0>> =A0> A possible problem with this approach is that=
 the maximum number of
>> =A0>> =A0>> =A0>> =A0> file descriptors poll can handle limited by R=
LIMIT_NOFILE, whereas the
>> =A0>> =A0>> =A0>> =A0> maximum number of file descriptors select can=
 handle is limited by
>> =A0>> =A0>> =A0>> =A0> FD_SETSIZE.
>> =A0>> =A0>> =A0>> =A0>
>> =A0>> =A0>> =A0>> =A0> I don't think this is a big problem in realit=
y, though - both values
>> =A0>> =A0>> =A0>> =A0> seem to be pretty high in most implementation=
s. And IIRC git-daemon is
>> =A0>> =A0>> =A0>> =A0> the only one who needs more than 2, and it do=
esn't even check
>> =A0>> =A0>> =A0>> =A0> RLIMIT_NOFILE.
>> =A0>> =A0>> =A0>> =A0>
>> =A0>> =A0>> =A0>>
>> =A0>> =A0>> =A0>>
>> =A0>> =A0>> =A0>> To be clear: I think this strategy is the best opt=
ion (at least for
>> =A0>> =A0>> =A0>> =A0non-Windows, where select() might be our only o=
ption).
>> =A0>> =A0>> =A0>>
>> =A0>> =A0>> =A0>> =A0But perhaps you should include a check along th=
e lines of this:
>> =A0>> =A0>> =A0>>
>> =A0>> =A0>> =A0>> =A0if (nfds > FD_SETSIZE)
>> =A0>> =A0>> =A0>> =A0 =A0 =A0 =A0 return errno =3D EINVAL, error("po=
ll: nfds must be below %d", FD_SETSIZE);
>> =A0>> =A0>> =A0>>
>> =A0>> =A0>> =A0>> =A0Just so we can know when the code fails :)
>> =A0>> =A0>> =A0>
>> =A0>> =A0>> =A0> Well, per your own FD_SET example, the FD_SETSIZE o=
n windows
>> =A0>> =A0>> =A0> means different thing than FD_SETSIZE on old-style =
bitmap-based
>> =A0>> =A0>> =A0> select() implementation.
>> =A0>> =A0>> =A0>
>> =A0>> =A0>> =A0> On Unix, it's max fd number + 1, on windows it's ma=
x count.
>> =A0>> =A0>> =A0>
>> =A0>> =A0>>
>> =A0>> =A0>>
>> =A0>> =A0>> Are you sure this applies for all Unix, not just some gi=
ven Unix-y system?
>> =A0>> =A0>
>> =A0>> =A0> Not sure. =A0Just pointing out that the above check is no=
t
>> =A0>> =A0> universal enough.
>> =A0>> =A0>
>> =A0>>
>> =A0>>
>> =A0>> Isn't it? How could one possibly pass more than max fd number =
+ 1 file
>> =A0>> =A0descriptors, since they start at 0? I guess one could speci=
fy a given
>> =A0>> =A0fd more than once, but that'd be kind of redundant... and a=
lso very
>> =A0>> =A0unlikely in our case ;)
>> =A0>
>> =A0> Pass one fd with value 70 it. =A0Check returns error, although
>> =A0> everything would work.
>> =A0>
>>
>>
>> No, not with the check I posted. I checked nfds, not the value of th=
e
>> =A0fds themselves. nfds is clearly the size of the fds array -- if i=
t
>> =A0wasn't, it'd be impossible for the poll-implementation to know ho=
w big
>> =A0the array is!
>
> Ah, ok. =A0I though this is the nfds for select(). =A0In this case it=
 can
> still fail, as nfds=3D1 for poll() can still go over FD_SETSIZE for
> select() if the fd value is big enough. =A0On non-windows, that is.
>

I don't quite get where one would get a fd that's value is FD_SETSIZE
or above from. I mean, FD_SETSIZE would have to be the maximum value
of a file descriptor, or else you risk open() or socket() returning
file descriptors that cannot be select()'ed. Which would just be
insane, no?

--=20
Erik "kusma" Faye-Lund
