From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] compat: Add another rudimentary poll() emulation
Date: Thu, 27 May 2010 16:15:01 +0200
Message-ID: <AANLkTimo2P3JIJ2zhD3QtT2wgfr4WmXPkVVxUDpiOfJH@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Thu May 27 16:15:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHdro-0007zz-8A
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 16:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756883Ab0E0OPK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 May 2010 10:15:10 -0400
Received: from mail-wy0-f180.google.com ([74.125.82.180]:58684 "EHLO
	mail-wy0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754963Ab0E0OPI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 May 2010 10:15:08 -0400
Received: by wyb36 with SMTP id 36so211395wyb.11
        for <git@vger.kernel.org>; Thu, 27 May 2010 07:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=OYcgdgqkuveJK+dxDSaJcx1VQVgBjON/5Bo/dgn9v1c=;
        b=otqsSJmDu8mdXyLGaAyloz6rN/gHpUqWVDuGw5AZSsyTBRM2y7kiivHDBiw6B64HXU
         dsW2POIZfDzazCW2ucW/IqGHlMmeW702IPgSzhTM47NpVfJ/nvw2sdJZ/gXqWdMN4Nr4
         nzcbX01tGHoB6k09D5NTLuEusVT3aBo3mXizs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=D9EUwTcB6zmqSaH151EcItDS2xSTh6S1W8K+3avGc7QQQZ5UmUYLsHTdivTzUKqrgF
         rUympAcV6nmJEZgV036AvniE3p0zHqKRijhAhX9ZL2gNSZ1h6T27xDOIV3mj1kYTWIPV
         nETOPssrquHumcn5LjcVQ2roDEENp0zzRr5Zk=
Received: by 10.216.160.205 with SMTP id u55mr658630wek.21.1274969704664; Thu, 
	27 May 2010 07:15:04 -0700 (PDT)
Received: by 10.216.21.73 with HTTP; Thu, 27 May 2010 07:15:01 -0700 (PDT)
In-Reply-To: <AANLkTil-nMo5E2laacYm48-HGbhseEICWsUHwTlc3l47@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147862>

On Thu, May 27, 2010 at 4:11 PM, Marko Kreen <markokr@gmail.com> wrote:
> On 5/27/10, Erik Faye-Lund <kusmabite@googlemail.com> wrote:
>> On Thu, May 27, 2010 at 3:58 PM, Marko Kreen <markokr@gmail.com> wro=
te:
>> =A0> On 5/27/10, Erik Faye-Lund <kusmabite@googlemail.com> wrote:
>> =A0>> On Thu, May 27, 2010 at 3:29 PM, Marko Kreen <markokr@gmail.co=
m> wrote:
>> =A0>> =A0> On 5/27/10, Erik Faye-Lund <kusmabite@googlemail.com> wro=
te:
>> =A0>> =A0>> On Thu, May 27, 2010 at 1:00 PM, Erik Faye-Lund
>> =A0>> =A0>> =A0<kusmabite@googlemail.com> wrote:
>> =A0>> =A0>> =A0> On Thu, May 27, 2010 at 12:10 PM, Jonathan Nieder <=
jrnieder@gmail.com> wrote:
>> =A0>> =A0>> =A0>> Implement the subset of poll() semantics needed by=
 git in terms of
>> =A0>> =A0>> =A0>> select(), for use by the Interix port. =A0Inspired=
 by commit 6ed807f
>> =A0>> =A0>> =A0>> (Windows: A rudimentary poll() emulation, 2007-12-=
01).
>> =A0>> =A0>> =A0>>
>> =A0>> =A0>> =A0>
>> =A0>> =A0>> =A0> A possible problem with this approach is that the m=
aximum number of
>> =A0>> =A0>> =A0> file descriptors poll can handle limited by RLIMIT_=
NOFILE, whereas the
>> =A0>> =A0>> =A0> maximum number of file descriptors select can handl=
e is limited by
>> =A0>> =A0>> =A0> FD_SETSIZE.
>> =A0>> =A0>> =A0>
>> =A0>> =A0>> =A0> I don't think this is a big problem in reality, tho=
ugh - both values
>> =A0>> =A0>> =A0> seem to be pretty high in most implementations. And=
 IIRC git-daemon is
>> =A0>> =A0>> =A0> the only one who needs more than 2, and it doesn't =
even check
>> =A0>> =A0>> =A0> RLIMIT_NOFILE.
>> =A0>> =A0>> =A0>
>> =A0>> =A0>>
>> =A0>> =A0>>
>> =A0>> =A0>> To be clear: I think this strategy is the best option (a=
t least for
>> =A0>> =A0>> =A0non-Windows, where select() might be our only option)=
=2E
>> =A0>> =A0>>
>> =A0>> =A0>> =A0But perhaps you should include a check along the line=
s of this:
>> =A0>> =A0>>
>> =A0>> =A0>> =A0if (nfds > FD_SETSIZE)
>> =A0>> =A0>> =A0 =A0 =A0 =A0 return errno =3D EINVAL, error("poll: nf=
ds must be below %d", FD_SETSIZE);
>> =A0>> =A0>>
>> =A0>> =A0>> =A0Just so we can know when the code fails :)
>> =A0>> =A0>
>> =A0>> =A0> Well, per your own FD_SET example, the FD_SETSIZE on wind=
ows
>> =A0>> =A0> means different thing than FD_SETSIZE on old-style bitmap=
-based
>> =A0>> =A0> select() implementation.
>> =A0>> =A0>
>> =A0>> =A0> On Unix, it's max fd number + 1, on windows it's max coun=
t.
>> =A0>> =A0>
>> =A0>>
>> =A0>>
>> =A0>> Are you sure this applies for all Unix, not just some given Un=
ix-y system?
>> =A0>
>> =A0> Not sure. =A0Just pointing out that the above check is not
>> =A0> universal enough.
>> =A0>
>>
>>
>> Isn't it? How could one possibly pass more than max fd number + 1 fi=
le
>> =A0descriptors, since they start at 0? I guess one could specify a g=
iven
>> =A0fd more than once, but that'd be kind of redundant... and also ve=
ry
>> =A0unlikely in our case ;)
>
> Pass one fd with value 70 it. =A0Check returns error, although
> everything would work.
>

No, not with the check I posted. I checked nfds, not the value of the
fds themselves. nfds is clearly the size of the fds array -- if it
wasn't, it'd be impossible for the poll-implementation to know how big
the array is!

--=20
Erik "kusma" Faye-Lund
