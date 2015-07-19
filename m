From: =?iso-8859-1?Q?Zo=EB_Blade?= <zoe@bytenoise.co.uk>
Subject: Re: [PATCH] userdiff: add support for Fountain documents
Date: Sun, 19 Jul 2015 13:30:28 +0100
Message-ID: <562D4AFF-BFC1-4234-8362-656D1F54DFD0@bytenoise.co.uk>
References: <1437142912-25380-1-git-send-email-zoe@bytenoise.co.uk> <xmqq1tg63dzv.fsf@gitster.dls.corp.google.com> <xmqq380m1k3g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 19 14:30:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGnk0-0007LC-7X
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 14:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865AbbGSMai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 08:30:38 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:61624 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417AbbGSMah convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jul 2015 08:30:37 -0400
Received: from [192.168.0.26] ([82.69.105.163]) by mrelayeu.kundenserver.de
 (mreue101) with ESMTPSA (Nemesis) id 0MAdid-1Z50QF3xox-00BsFI; Sun, 19 Jul
 2015 14:30:33 +0200
In-Reply-To: <xmqq380m1k3g.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
X-Provags-ID: V03:K0:ZN4lfZXP5Mb40vHEiB3hv8VdfRWukvi91Oecb3KnMR0cE7GH/gP
 Wq8zmpE4hHhykeP7KqBim8ZYH69UVnKdXsbGjrcJkzLRDZGECTRw4dwInR7BEubVUJveJRD
 BK3XXl0EivIFVkRxFw9u5/POPlL8vLuxnepeAHdh0Inj8MCfv+R3d07Smv2jXynKlAok2tw
 sz9qrqRueIKSeY9sJJOMQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AEgixYhLJHI=:9iNnm/Ni3b5lr+DfcSYRsL
 l3IQoTAO3zmcv41YntIWitaVoudJ4R7KEHkajdc6H778B0y76WprsHDD823Ffxl9nesNb6fiD
 Oi+nhdP4Tsyq5QGoRUNDRxWVJnSSloS8gmXaFMBkoSDLziqFRoZgX4WE8sed2JE5fYVZWuxDS
 +M0cIS8jS/XPiI+18dKBsMHMqRLFfJyyA1xegNSmOYAZppLUDFcWKT6MwNog7cYhA+Z39lgKd
 5NePZLC8ArLrBmLNKnARVKKYC1wMmjoeUzuLj0GAGYk4Rj/E+gLV/IVu3qycl+hM5fgsgy9Jh
 MD0t81YTMvJVSQadrQRWbCGGMsFTxjc78cFARuJ4P1wO7i1PzgINfwWk6JlEzcVZj+WF7sCY6
 zEywS/baZTPYtYTLcjipcy7gcg2oXWJcDW2cvrWpf+qGJxwCDMOfok6Yp6cfcb4ZEvuaXO7bI
 LrkxlfdplQf1YLon91Mgl+vHu7VH4tOkVzhO04Cv0pqwqUFfjhfaKJaJjhkIFRXDEyjtdc6Rn
 4S1yztsY5gd09NVqjTQQQJVsqLUjwMV45zmjmD9CdHF2bO4b0ormlfeR6w2oUO1vAa0GMrq7s
 cHyIkjf32KXLiEUuqnLTgmBbAnuwFZnQH08jpPR+FJ6khUUHDRSEgWPmOSgUsWnHok+2oPEMW
 Wz4ElDxOVnrauj8vF9BZ1TpDnQvL2KSLwFeVKPWwiI5odCQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274210>

On 17 Jul 2015, at 23:43, Junio C Hamano <gitster@pobox.com> wrote:

> * Although uppercase is recommended for Scene Headings to increase
>   readability, it is not required.
> 
> * A line beginning with any of the following, followed by either a
>   dot or a space, is considered a Scene Heading (unless the line is
>   preceded by an exclamation point !). Case insensitive.
> 
>      INT
>      EXT
>      EST
>      INT./EXT
>      INT/EXT
>      I/E
> 
> * You can "force" a Scene Heading by starting the line with a
>   single period.
> 
> * Scene Headings can optionally be appended with Scene
>   Numbers. Scene numbers are any alphanumerics (plus dashes and
>   periods), wrapped in #.
> 
> So, it appears wrong to insist on capital letters in the patterns.
> The pattern in the patch does not even accept punctuations on the
> line other than apostrophe.  I won't judge if it is OK to limit to
> US-ASCII ;-)
> 
> IPATTERNS("fountain",
>    "^([.][^.]|(INT|EXT|EST|INT./EXT|INT/EXT|I/E)[. ]",
>    "[^ \t-]+"),
> 
> or something like this, perhaps?

Good points, thanks!

This regex should be a bit sturdier:

$ cat scenes.txt 
int. yes - day
INT. YES - DAY #1A#
EXT. YES - DAY
.YES TOO
!EXT. NO
INT/EXT YES - DAY
INT./EXT YES - DAY
I/E YES - DAY
no
NO
NO.
!.NO.
int yes - day
est yes - day
!EXT. NO - DAY

$ grep -E "^((\.|(([Ii][Nn][Tt]|[Ee][Ss][Tt]|[Ee][Xx][Tt])?\\.?|[Ii]([Nn][Tt])?\.?/[Ee]([Xx][Tt])?\.?) ).+)$" scenes.txt 
int. yes - day
INT. YES - DAY #1A#
EXT. YES - DAY
.YES TOO
INT/EXT YES - DAY
INT./EXT YES - DAY
I/E YES - DAY
int yes - day
est yes - day

Revised version of patch incoming...