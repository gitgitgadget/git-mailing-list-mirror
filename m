From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH 1/2] add macro REALLOC_ARRAY
Date: Wed, 24 Sep 2014 21:27:02 +0200
Message-ID: <54231B06.10700@web.de>
References: <5415C89C.4090509@web.de> <CAPc5daXuYVXG=b3Mjn=8oE71FqE_PRZ=XHXW_0F5uHawWwy4HQ@mail.gmail.com> <541886D5.8060202@web.de> <541887F0.1050007@web.de> <54227379.5010708@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 24 21:27:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWsE2-000131-Dx
	for gcvg-git-2@plane.gmane.org; Wed, 24 Sep 2014 21:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869AbaIXT1i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Sep 2014 15:27:38 -0400
Received: from mout.web.de ([212.227.15.4]:55358 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753858AbaIXT1g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2014 15:27:36 -0400
Received: from [192.168.178.27] ([79.250.174.80]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0LkyHN-1Y72O03l7l-00aie8; Wed, 24 Sep 2014 21:27:33
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <54227379.5010708@alum.mit.edu>
X-Provags-ID: V03:K0:4xNdc89SVlQFT5PeB2GGjXIeNPWCMa0KAbySDGQjGDLn3PNzVaz
 v/E4z5Gh19pd6B00Z/8KNBEEm1eDNGtO6gbO0EkA+uFvMVX2+3BMAaJJ6MGjWdGFI9xi6NA
 MhwgD4AJecUfaLcDR3U38pFAszKO0bEeWmMP9gaCdFV0uW4khY4ysxGPH+F+gTzltq9TrcF
 orESV/lMxRqZM6rh+QpEw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257465>

Am 24.09.2014 um 09:32 schrieb Michael Haggerty:
> Is there a reason that ALLOC_GROW and REALLOC_ARRAY are defined in tw=
o
> separate header files (cache.h and git-compat-util.h, respectively)? =
It
> seems to me that they are close siblings and therefore I find it
> surprising that they are not defined right next to each other.

REALLOC_ARRAY is more like xrealloc and it's used in places that only=20
#include git-compat-util.h and not cache.h, so the first header was the=
=20
right place.

ALLOC_GROW could be moved there in a separate patch, but I'm not sure=20
it's worth it.

Ren=C3=A9
