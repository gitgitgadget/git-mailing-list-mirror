From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] rebase -p: avoid grep on potentailly non-ASCII data
Date: Thu, 10 Mar 2016 08:42:35 +0100
Message-ID: <56E1256B.9030308@web.de>
References: <alpine.DEB.2.10.1603080255030.2674@buzzword-bingo.mit.edu>
 <56DEC4B4.2000902@web.de> <56DED770.4050603@drmicha.warpmail.net>
 <20160308143556.GA10153@sigill.intra.peff.net>
 <xmqqio0wk151.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.10.1603082127230.2674@buzzword-bingo.mit.edu>
 <xmqqvb4vgzxs.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Anders Kaseorg <andersk@mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 10 08:43:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1advFM-0001vJ-4O
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 08:43:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbcCJHmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 02:42:55 -0500
Received: from mout.web.de ([212.227.15.4]:51849 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752396AbcCJHmy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 02:42:54 -0500
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0Le4PE-1a3kXG1jP2-00pski; Thu, 10 Mar 2016 08:42:42
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
In-Reply-To: <xmqqvb4vgzxs.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:m07/Rf2kqu2bOxBVtLLCXrSlZBdXwXhv0mrcApjIlf7jAzt9zWU
 pOAtBPS6337W/viXg/kRYmz1HoGJPX4DXs/wxNVET/fvOP8tdenrDpbEz7jYTGCaoAAG7bQ
 ScamBIpRQgcQQ04a1//3NbIYGtfPF0nsv90NxpKmrN4s4Yc+VaExP+W6aMuqmRV5suqUU71
 jGmlZR8/F6zolPILV3z+A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:H84OQJ+B0Pk=:OVVCQ2R/fMJ/JWZFqGu7WI
 fBmynUqw/abMhm0iHToZmkG8BoqLcP4atGTsH7pC6QBvxaIIzIIv8mT5uPYIOOBr9VIrP9Boz
 Jh2X9H5vWAEkmogM7PDOR8zlXzAmDdvDpZNQex+P78GzYHtCAVQ/pPxjsiYYmzmPyYH1qYWYr
 Rb99tUzhZXaG+enw/EteJwlvM3wl//He3BO25p95ZgThKEwNJ7iO3w5uAg0f0C8E9iPdbV7Cq
 VDGTpRo9sa9QGWL0Q6p1+7WQlmGbMw/24wEG5i83fc5eD+xA44tB0dbdmHNRYVU+mb/fedDxC
 HYNYGgFMe24AVux9VD9EV2xPbFXsVnhHS8TOccQq2/tl1fwmX0SYiMv8VACwI+FQMJzWbNRMd
 EagzMSQkAjap2ANSaRyWamrJtm/8AwFrm99u47sUsCvYAJKak1vEzDwUTRbKZTry4HTMdbIeB
 nrFjjPX7tNOex5EeL0pUCF8GVEpc4hYHbBesDTi08IY8jby87ZY12L03arVP0MlMWO9o8u9/f
 pu/Z2XGyIUBN+o2xuWYi609yTF+Gpps3IK4kCTvg8qa7WWd9Acr0mtUaQwVq5RtOzTVl3LGvP
 cp9vydlp0zSvoTcGSNm+4+SmvmM0pYxsl9+YfWv/9PjJPUcatGSq6gQKnwBzzAYZvtLlEoslw
 CwWKNgDT0X9wYbvbTTu7D5NDw6YcbhI2+qSnxXlWoy+/9qD5NnBZN0NFFf9um99XcwWwxVsV1
 7vOH5VA/VqR0VQg05EGZmrYpuMpfb0H3kLpgYZ3k3P0pfEyhyZ3S+TRd3f7z8BuglsujoaZM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288599>

On 09.03.16 21:26, Junio C Hamano wrote:
> Anders Kaseorg <andersk@mit.edu> writes:
[]
>  sane_grep () {
> -	GREP_OPTIONS= LC_ALL=C grep "$@"
> +	GREP_OPTIONS= LC_ALL=C grep @@SANE_TEXT_GREP@@ "$@"
>  }
>  
>  sane_egrep () {
> -	GREP_OPTIONS= LC_ALL=C egrep "$@"
> +	GREP_OPTIONS= LC_ALL=C egrep @@SANE_TEXT_GREP@@ "$@"
>  }
>

I always wondered why we do LC_ALL=C.
Isn't that begging for trouble, when we feed UTF-8, ISO-8895-1
or other stuff into a program and say LC_ALL=C at the same time ?

On my Debian Linux system I have
LANG=en_US.UTF-8

and

$ locale -a
C
C.UTF-8
en_US.utf8
POSIX
--------------

Mac OS has LANG unset, and reports
locale -a
en_US
en_US.ISO8859-1
en_US.ISO8859-15
en_US.US-ASCII
en_US.UTF-8
#(and a lot more )
C
POSIX

-----
My Centos has 
LANG=en_US.UTF-8

and reports e.g.
en_US
en_US.iso88591
en_US.iso885915
en_US.utf8
(And many more)

In t0204 we have
    LANGUAGE=is LC_ALL="$is_IS_locale" git init repo >actual &&
which is based on
	# is_IS.UTF-8 on Solaris and FreeBSD, is_IS.utf8 on Debian
	is_IS_locale=$(locale -a 2>/dev/null |
in 
lib-gettext.sh

Is there something we can steal here ?


http://pubs.opengroup.org/onlinepubs/007908799/xbd/envvar.html
