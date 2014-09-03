From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v3 2/2] MinGW: Update tests to handle a native eol of
 crlf
Date: Wed, 03 Sep 2014 20:19:19 +0200
Message-ID: <54075BA7.2090101@web.de>
References: <5402447B.3080700@web.de>	<xmqq1trt25zt.fsf@gitster.dls.corp.google.com>	<54062052.3070106@web.de> <xmqqk35lzr0u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1?= =?UTF-8?B?c2Vu?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Sep 03 20:20:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPF9i-00043L-Cp
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 20:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbaICST2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Sep 2014 14:19:28 -0400
Received: from mout.web.de ([212.227.17.11]:61620 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751432AbaICST1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 14:19:27 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MD87M-1XdYUH2Grs-00Gc8R; Wed, 03 Sep 2014 20:19:21
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <xmqqk35lzr0u.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:NB/HoN/LLf9UlOmGsDZ9Gxu7bHjUxHTVrZtmmoHJCzri+5th7XK
 wItEtx2+hlFY19pBvUhLYFdLU82OIgYnSPDc2YrP0vE1609pjy3pSE9lhhkvp1WQhfYQVZy
 pVj4gLYt453HSdfG+KdIeTnNrWd8Fmy1hCpDkiI5mlH9yszye/YtEmlP8P/IDT8vsgVCv7P
 8dKcY+j/nHBrCLKiIQHlw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256399>

On 2014-09-02 22.49, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>>> Should this be marked with "From: Brice Lambson <bricelam@live.com>=
"?
>>>
>>> Thanks.
>> Yes. If possible please squeeze.
>=20
> OK, thanks.  Please double check the result on 'pu' in several
> hours.
Excellent

t0027 and t0026 passed under Cygwin, MysGit and Mac OS.
(after reverting "use timer_settime() for new platforms", but that is a=
 different story)

Many thanks for helping me out and bringing this forward.
