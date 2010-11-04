From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v6 00/16] daemon-win32
Date: Thu, 4 Nov 2010 10:15:20 +0100
Message-ID: <AANLkTimzS1tnykzjoywaLdBUi4zhwzUC6bght0-vnaGO@mail.gmail.com>
References: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
 <877hgunmdc.fsf@fox.patthoyts.tk> <AANLkTin2BCxDoKhDCSgSRG1eVUGVeQh6Bq_=FfAe0M_M@mail.gmail.com>
 <AANLkTim4_5dgPGcw5B3U-3UH63REL4QWsWPV=mDSJJ6D@mail.gmail.com>
 <AANLkTin6_RLBJZKDaDViZ2_v7_LKpyoyvofowArx9sas@mail.gmail.com>
 <AANLkTinS2PLD3qwHpf491J3bDjXO8PxF96KdF=fz9a8o@mail.gmail.com> <alpine.DEB.2.00.1011041053120.31519@cone.home.martin.st>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org,
	gitster@pobox.com
To: =?ISO-8859-1?Q?Martin_Storsj=F6?= <martin@martin.st>
X-From: git-owner@vger.kernel.org Thu Nov 04 10:15:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDvvA-0003XH-Nc
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 10:15:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754974Ab0KDJPn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Nov 2010 05:15:43 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47197 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754108Ab0KDJPm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Nov 2010 05:15:42 -0400
Received: by fxm16 with SMTP id 16so1246920fxm.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 02:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=mKyfIJOpKnAXH5CT5BnvZIsvbKaShTgWPcNVFsaO1Mo=;
        b=v5sp60UcJ90R11ht8sAgI0veGpV0BQJp8BLxKsPoJUteR+HeVrlXzl45iqcH8hS3BV
         4qN7aAd9+bXxm0lzkCBKVLOOdtD+rjV2sKMDZaZZa368/bXWo+qylJUkIUuPVovagEv9
         +DynHkjVvkhbeHiAY7vSyJNul4zYXDKV3SjsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=DMwH9FnsaW7NlQKa7GL3EPLW43p+DGZlq7fogqC5hhsBfxOWI2GN9nZkmg+ss8Qjtf
         +AQCi+zlQBJkfPO1QSua0Vd8518XLeSYP5xY/PxnW+aCCX2sL2IAPInq6G76RLZypYY+
         qr9lLNin0tgx1iGftMikC80AfwUrwpaK/LqfU=
Received: by 10.223.116.9 with SMTP id k9mr378343faq.124.1288862140719; Thu,
 04 Nov 2010 02:15:40 -0700 (PDT)
Received: by 10.223.108.73 with HTTP; Thu, 4 Nov 2010 02:15:20 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1011041053120.31519@cone.home.martin.st>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160699>

On Thu, Nov 4, 2010 at 9:58 AM, Martin Storsj=F6 <martin@martin.st> wro=
te:
> On Thu, 4 Nov 2010, Erik Faye-Lund wrote:
>
>> On Thu, Nov 4, 2010 at 1:06 AM, Erik Faye-Lund <kusmabite@gmail.com>=
 wrote:
>> > On Wed, Nov 3, 2010 at 11:58 PM, Erik Faye-Lund <kusmabite@gmail.c=
om> wrote:
>> >> On Wed, Nov 3, 2010 at 11:18 PM, Erik Faye-Lund <kusmabite@gmail.=
com> wrote:
>> >>> On Wed, Nov 3, 2010 at 10:11 PM, Pat Thoyts
>> >>> <patthoyts@users.sourceforge.net> wrote:
>> >>>> Erik Faye-Lund <kusmabite@gmail.com> writes:
>> >>>>
>> >>>>>Here's hopefully the last iteration of this series. The previou=
s version
>> >>>>>only got a single complain about a typo in the subject of patch=
 14/15, so
>> >>>>>it seems like most controversies have been settled.
>> >>>>
>> >>>> I pulled this win32-daemon branch into my msysgit build tree an=
d built
>> >>>> it. I get the following warnings:
>> >>>>
>> >>>> =A0 =A0CC daemon.o
>> >>>> daemon.c: In function 'service_loop':
>> >>>> daemon.c:674: warning: dereferencing pointer 'ss.124' does brea=
k strict-aliasing rules
>> >>>> daemon.c:676: warning: dereferencing pointer 'ss.124' does brea=
k strict-aliasing rules
>> >>>> daemon.c:681: warning: dereferencing pointer 'ss.124' does brea=
k strict-aliasing rules
>> >>>> daemon.c:919: note: initialized from here
>> >>>> daemon.c:679: warning: dereferencing pointer 'sin_addr' does br=
eak strict-aliasing rules
>> >>>> daemon.c:675: note: initialized from here
>> >>>> daemon.c:691: warning: dereferencing pointer 'sin6_addr' does b=
reak strict-aliasing rules
>> >>>> daemon.c:682: note: initialized from here
>> >>>>
>> >>>
>> >>> Yeah, I'm aware of these. I thought those warnings were already
>> >>> present in the Linux build, but checking again I see that that's=
 not
>> >>> the case. Need to investigate.
>> >>>
>> >>
>> >> OK, it's the patch "daemon: use run-command api for async serving=
"
>> >> that introduce the warning. But looking closer at the patch it do=
esn't
>> >> seem the patch actually introduce the strict-aliasing violation, =
it's
>> >> there already. The patch only seems to change the code enough for=
 GCC
>> >> to start realize there's a problem. Unless I'm misunderstanding
>> >> something vital, that is.
>> >>
>> >> Anyway, here's a patch that makes it go away, I guess I'll squash=
 it
>> >> into the next round.
>> >>
>> >
>> > Stuffing all of sockaddr, sockaddr_in and sockaddr_in6 (when built
>> > with IPv6 support) in a union and passing that around instead does
>> > seem to fix the issue completely. I don't find it very elegant, bu=
t
>> > some google-searches on the issue seems to reveal that this is the
>> > only way of getting rid of this. Any other suggestions, people?
>> >
>>
>> Just for reference, this is the patch that fixes it. What do you thi=
nk?
>>
>> diff --git a/daemon.c b/daemon.c
>> index 941c095..8162f10 100644
>> --- a/daemon.c
>> +++ b/daemon.c
>> @@ -902,9 +903,15 @@ static int service_loop(struct socketlist *sock=
list)
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < socklist->nr; i++) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pfd[i].revents & POL=
LIN) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct soc=
kaddr_storage ss;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 union {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct sockaddr sa;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct sockaddr_in sai;
>> +#ifndef NO_IPV6
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct sockaddr_in6 sai6;
>> +#endif
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } ss;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned=
 int sslen =3D sizeof(ss);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int incomi=
ng =3D accept(pfd[i].fd, (struct sockaddr *)&ss, &sslen);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int incomi=
ng =3D accept(pfd[i].fd, &ss.sa, &sslen);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (inco=
ming < 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 switch (errno) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 case EAGAIN:
>> @@ -915,7 +922,7 @@ static int service_loop(struct socketlist *sockl=
ist)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 die_errno("accept returned");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 handle(inc=
oming, (struct sockaddr *)&ss, sslen);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 handle(inc=
oming, &ss.sa, sslen);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 }
>
> As you say yourself, it's not elegant at all - sockaddr_storage is
> intended to be just that, an struct large enough to fit all the socka=
ddrs
> you'll encounter on this platform, with all fields aligned in the sam=
e way
> as all the other sockaddr structs. You're supposed to be able to cast=
 the
> sockaddr struct pointers like currently is done, although I'm not fam=
iliar
> with the strict aliasing stuff well enough to know if anything else w=
ould
> be required somewhere.
>

Strict aliasing isn't exactly about the structure being large enough
or not, it's only being able to access a particular piece of memory
through one type only (unless specificly marked with "union").
sockaddr_storage is an attempt at fixing the storage-problem without
addressing the type punning problem, which doesn't help us much.

> I didn't see any of these hacks in the v7 patchset - did the warning =
go
> away by itself there?
>

The strict aliasing problem was (as I described earlier, and you
pointed out later in your email) already present in the code. All the
patch did, was modify the code enough to make GCC realize it.

Since the code is removed by a later patch ("daemon: get remote host
address from root-process"), I figured adding a union just to remove
it was just noisy. So instead I changed the code enough for the
warning to go away again. It turned out that it was the assignment of
NULL to "peer" that triggered the warning, so I made two calls to
execute() instead, one that pass NULL and one that pass "peer".

Then in "daemon: get remote host address from root-process" which
causes a similar strict-aliasing issue (this time I'm the one who
introduced it, since the handle() code-path doesn't derefence "addr"),
I fixed it with a union.

> FWIW, the actual warning itself isn't directly related to any of the =
code
> worked on here, gcc just happens to realize it after some of these
> changes. I'm able to trigger the same warnings on the current master,=
 by
> simply doing this change:
>
> diff --git a/daemon.c b/daemon.c
> index 5783e24..467cea2 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -670,7 +670,6 @@ static void handle(int incoming, struct sockaddr
> *addr, int
> =A0 =A0 =A0 =A0dup2(incoming, 1);
> =A0 =A0 =A0 =A0close(incoming);
>
> - =A0 =A0 =A0 exit(execute(addr));
> =A0}
>
> =A0static void child_handler(int signo)
>
>
> // Martin

Yeah, I already figured that one out, but thanks for making it clearer.=
 :)

So a nice end-result of v7 is that we're good with strict aliasing,
which means that it's not safe(er) to compile git-daemon on GCC with
-O3.
