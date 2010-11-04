From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v6 00/16] daemon-win32
Date: Thu, 4 Nov 2010 01:06:17 +0100
Message-ID: <AANLkTin6_RLBJZKDaDViZ2_v7_LKpyoyvofowArx9sas@mail.gmail.com>
References: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
 <877hgunmdc.fsf@fox.patthoyts.tk> <AANLkTin2BCxDoKhDCSgSRG1eVUGVeQh6Bq_=FfAe0M_M@mail.gmail.com>
 <AANLkTim4_5dgPGcw5B3U-3UH63REL4QWsWPV=mDSJJ6D@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Nov 04 01:07:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDnME-0000zh-H3
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 01:07:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472Ab0KDAGl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Nov 2010 20:06:41 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36076 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079Ab0KDAGj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Nov 2010 20:06:39 -0400
Received: by fxm16 with SMTP id 16so1014483fxm.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 17:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=wazWw8mwWsTztXQpvjdSnS1MfvBmDlbQMsYGfXvnHkQ=;
        b=gyho0KaAq3gYANPDXP1AK3qr/i/k4ukNQkO76Gdzerj5e+0q9YqxelxQlR18J+G12h
         6G+j31nwqKBr87RbFZFtHTR4HOyErzOf24MsXbkEgHX45PteQGhVvRE3kQvgXh42T9h6
         S2L+MPMe4SMg+vhHYWyyNjIWEuKuKncQYXI4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=lwQfjpJ1iYbZPlIT+iAyir559uNdi3SJ90D9+YucLTB7XB40wA80qOaIBu3gdItE9a
         GdYmgg1cgz/9l/alGkS1fw9QSqRW59DU1NseUm3HurgRYpzWIfGR7sUf0REDp15hnnfA
         QoNqwCOGKqqi+W5Q5S6BeMVGsUdIfeefk0SQU=
Received: by 10.223.110.148 with SMTP id n20mr6761081fap.48.1288829197434;
 Wed, 03 Nov 2010 17:06:37 -0700 (PDT)
Received: by 10.223.108.73 with HTTP; Wed, 3 Nov 2010 17:06:17 -0700 (PDT)
In-Reply-To: <AANLkTim4_5dgPGcw5B3U-3UH63REL4QWsWPV=mDSJJ6D@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160649>

On Wed, Nov 3, 2010 at 11:58 PM, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
> On Wed, Nov 3, 2010 at 11:18 PM, Erik Faye-Lund <kusmabite@gmail.com>=
 wrote:
>> On Wed, Nov 3, 2010 at 10:11 PM, Pat Thoyts
>> <patthoyts@users.sourceforge.net> wrote:
>>> Erik Faye-Lund <kusmabite@gmail.com> writes:
>>>
>>>>Here's hopefully the last iteration of this series. The previous ve=
rsion
>>>>only got a single complain about a typo in the subject of patch 14/=
15, so
>>>>it seems like most controversies have been settled.
>>>
>>> I pulled this win32-daemon branch into my msysgit build tree and bu=
ilt
>>> it. I get the following warnings:
>>>
>>> =A0 =A0CC daemon.o
>>> daemon.c: In function 'service_loop':
>>> daemon.c:674: warning: dereferencing pointer 'ss.124' does break st=
rict-aliasing rules
>>> daemon.c:676: warning: dereferencing pointer 'ss.124' does break st=
rict-aliasing rules
>>> daemon.c:681: warning: dereferencing pointer 'ss.124' does break st=
rict-aliasing rules
>>> daemon.c:919: note: initialized from here
>>> daemon.c:679: warning: dereferencing pointer 'sin_addr' does break =
strict-aliasing rules
>>> daemon.c:675: note: initialized from here
>>> daemon.c:691: warning: dereferencing pointer 'sin6_addr' does break=
 strict-aliasing rules
>>> daemon.c:682: note: initialized from here
>>>
>>
>> Yeah, I'm aware of these. I thought those warnings were already
>> present in the Linux build, but checking again I see that that's not
>> the case. Need to investigate.
>>
>
> OK, it's the patch "daemon: use run-command api for async serving"
> that introduce the warning. But looking closer at the patch it doesn'=
t
> seem the patch actually introduce the strict-aliasing violation, it's
> there already. The patch only seems to change the code enough for GCC
> to start realize there's a problem. Unless I'm misunderstanding
> something vital, that is.
>
> Anyway, here's a patch that makes it go away, I guess I'll squash it
> into the next round.
>

I also of course need to update "daemon: get remote host address from
root-process" as well, as it introduces a new such code-path (which is
actually the one complained about here). And I guess I should use
sockaddr_in instead of sockaddr.

But my luck stops there. The resulting git-daemon.exe leaves me with a
very bizarre error:

error: unable to make a socket file descriptor: Bad file descriptor
fatal: accept returned: Bad file descriptor

This is triggered by the call to accept() in mingw_accept returning -1.

What is even stranger is that if I change the code at the error-point l=
ike this
-				struct sockaddr_in sa;
+				struct sockaddr_in sa[2];
 				socklen_t salen =3D sizeof(sa);
-				int incoming =3D accept(pfd[i].fd, (struct sockaddr *)&sa, &salen)=
;
+				int incoming =3D accept(pfd[i].fd, (struct sockaddr *)sa, &salen);

the error goes away. Similarly, if I change mingw_accept's call to
Winsock's accept(), like this:
-	SOCKET s2 =3D accept(s1, sa, sz);
+	SOCKET s2 =3D accept(s1, sa, NULL);

So it seems accept() somehow reacts to the value of the variable
pointed at by sz, which is 16. Strange, huh?

Perhaps it isn't -- the sockaddr_storage change seems to have been
introduced for IPv6 reasons. I'm trying to connect over IPv6, and IPv6
has a new sockaddr_in6 struct. So yeah.

Stuffing all of sockaddr, sockaddr_in and sockaddr_in6 (when built
with IPv6 support) in a union and passing that around instead does
seem to fix the issue completely. I don't find it very elegant, but
some google-searches on the issue seems to reveal that this is the
only way of getting rid of this. Any other suggestions, people?
