From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v6 00/16] daemon-win32
Date: Thu, 4 Nov 2010 01:28:48 +0100
Message-ID: <AANLkTinS2PLD3qwHpf491J3bDjXO8PxF96KdF=fz9a8o@mail.gmail.com>
References: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
 <877hgunmdc.fsf@fox.patthoyts.tk> <AANLkTin2BCxDoKhDCSgSRG1eVUGVeQh6Bq_=FfAe0M_M@mail.gmail.com>
 <AANLkTim4_5dgPGcw5B3U-3UH63REL4QWsWPV=mDSJJ6D@mail.gmail.com> <AANLkTin6_RLBJZKDaDViZ2_v7_LKpyoyvofowArx9sas@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Nov 04 01:29:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDnhb-0003Y1-Qd
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 01:29:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753769Ab0KDA3K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Nov 2010 20:29:10 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47953 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917Ab0KDA3J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Nov 2010 20:29:09 -0400
Received: by fxm16 with SMTP id 16so1025270fxm.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 17:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=FNQ2KKDnLYwViSKut0vD+ogSaaXEIM6h3/KN95bw6bs=;
        b=eMfZkWanAurIyDnQ5c6i0M18n0/9D8YXkXonoXyxWMYuhnzfhgXQXqIvrYJfWKAEwJ
         WOenwB4ecCHwttRHidJCA4C3pf/GdajGtxQuVWUQKn+10RD23Mm5tM8ePMCEds9au8pi
         3YvoUcwjIp0loVXTpt8yyv1GfVTVofN+7C9bA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=QFshupzwwJP3LxdOQbbSD616kLfh4KipS++y6NKFBnYMR3Z46PRV1uCnC9e2tSyeOm
         AIIHfRoEDy51o94hP1P2tr0syBYiSXkGoEIKqxcFK4va2FkyRjD9hc9LCMmAr1cdQ6D3
         nWk7G8cq0JY1vkhpCtpeBIhPu5oaXvN6RfSX0=
Received: by 10.223.116.9 with SMTP id k9mr6464095faq.124.1288830548133; Wed,
 03 Nov 2010 17:29:08 -0700 (PDT)
Received: by 10.223.108.73 with HTTP; Wed, 3 Nov 2010 17:28:48 -0700 (PDT)
In-Reply-To: <AANLkTin6_RLBJZKDaDViZ2_v7_LKpyoyvofowArx9sas@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160653>

On Thu, Nov 4, 2010 at 1:06 AM, Erik Faye-Lund <kusmabite@gmail.com> wr=
ote:
> On Wed, Nov 3, 2010 at 11:58 PM, Erik Faye-Lund <kusmabite@gmail.com>=
 wrote:
>> On Wed, Nov 3, 2010 at 11:18 PM, Erik Faye-Lund <kusmabite@gmail.com=
> wrote:
>>> On Wed, Nov 3, 2010 at 10:11 PM, Pat Thoyts
>>> <patthoyts@users.sourceforge.net> wrote:
>>>> Erik Faye-Lund <kusmabite@gmail.com> writes:
>>>>
>>>>>Here's hopefully the last iteration of this series. The previous v=
ersion
>>>>>only got a single complain about a typo in the subject of patch 14=
/15, so
>>>>>it seems like most controversies have been settled.
>>>>
>>>> I pulled this win32-daemon branch into my msysgit build tree and b=
uilt
>>>> it. I get the following warnings:
>>>>
>>>> =A0 =A0CC daemon.o
>>>> daemon.c: In function 'service_loop':
>>>> daemon.c:674: warning: dereferencing pointer 'ss.124' does break s=
trict-aliasing rules
>>>> daemon.c:676: warning: dereferencing pointer 'ss.124' does break s=
trict-aliasing rules
>>>> daemon.c:681: warning: dereferencing pointer 'ss.124' does break s=
trict-aliasing rules
>>>> daemon.c:919: note: initialized from here
>>>> daemon.c:679: warning: dereferencing pointer 'sin_addr' does break=
 strict-aliasing rules
>>>> daemon.c:675: note: initialized from here
>>>> daemon.c:691: warning: dereferencing pointer 'sin6_addr' does brea=
k strict-aliasing rules
>>>> daemon.c:682: note: initialized from here
>>>>
>>>
>>> Yeah, I'm aware of these. I thought those warnings were already
>>> present in the Linux build, but checking again I see that that's no=
t
>>> the case. Need to investigate.
>>>
>>
>> OK, it's the patch "daemon: use run-command api for async serving"
>> that introduce the warning. But looking closer at the patch it doesn=
't
>> seem the patch actually introduce the strict-aliasing violation, it'=
s
>> there already. The patch only seems to change the code enough for GC=
C
>> to start realize there's a problem. Unless I'm misunderstanding
>> something vital, that is.
>>
>> Anyway, here's a patch that makes it go away, I guess I'll squash it
>> into the next round.
>>
>
> Stuffing all of sockaddr, sockaddr_in and sockaddr_in6 (when built
> with IPv6 support) in a union and passing that around instead does
> seem to fix the issue completely. I don't find it very elegant, but
> some google-searches on the issue seems to reveal that this is the
> only way of getting rid of this. Any other suggestions, people?
>

Just for reference, this is the patch that fixes it. What do you think?

diff --git a/daemon.c b/daemon.c
index 941c095..8162f10 100644
--- a/daemon.c
+++ b/daemon.c
@@ -902,9 +903,15 @@ static int service_loop(struct socketlist *socklis=
t)

 		for (i =3D 0; i < socklist->nr; i++) {
 			if (pfd[i].revents & POLLIN) {
-				struct sockaddr_storage ss;
+				union {
+					struct sockaddr sa;
+					struct sockaddr_in sai;
+#ifndef NO_IPV6
+					struct sockaddr_in6 sai6;
+#endif
+				} ss;
 				unsigned int sslen =3D sizeof(ss);
-				int incoming =3D accept(pfd[i].fd, (struct sockaddr *)&ss, &sslen)=
;
+				int incoming =3D accept(pfd[i].fd, &ss.sa, &sslen);
 				if (incoming < 0) {
 					switch (errno) {
 					case EAGAIN:
@@ -915,7 +922,7 @@ static int service_loop(struct socketlist *socklist=
)
 						die_errno("accept returned");
 					}
 				}
-				handle(incoming, (struct sockaddr *)&ss, sslen);
+				handle(incoming, &ss.sa, sslen);
 			}
 		}
 	}
