From: =?windows-1252?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 2/2] use REALLOC_ARRAY for changing the allocation size
 of arrays
Date: Wed, 24 Sep 2014 21:27:25 +0200
Message-ID: <54231B1D.7070807@web.de>
References: <5415C89C.4090509@web.de> <CAPc5daXuYVXG=b3Mjn=8oE71FqE_PRZ=XHXW_0F5uHawWwy4HQ@mail.gmail.com> <541886D5.8060202@web.de> <541887F9.3000100@web.de> <20140924184740.GK1175@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 24 21:28:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWsEl-0001q5-17
	for gcvg-git-2@plane.gmane.org; Wed, 24 Sep 2014 21:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278AbaIXT2O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Sep 2014 15:28:14 -0400
Received: from mout.web.de ([212.227.15.3]:49714 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754252AbaIXT2M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2014 15:28:12 -0400
Received: from [192.168.178.27] ([79.250.174.80]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MEEMy-1XUgM81yoq-00FVkH; Wed, 24 Sep 2014 21:27:56
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <20140924184740.GK1175@google.com>
X-Provags-ID: V03:K0:Zf7Id2kfoizLgesVOiXyGlPivXKQZY0g+lChtIyfR1yepj9qF8Q
 Ec97D4cR0LNFIITfXzuI2SyJ/QZahrh4ILbKve4vD+d/ZFoIgplieqMkic3zM1iDXWu/Y+E
 8Kk0FxfE7pVT52Wo7SX1JTOCMi3dqGxDvVx+m1Fd4DNwfsy2TOHL71kseXThoONMZjlzNfI
 qv/2wajqyzDpMNqlFo/hg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257466>

Am 24.09.2014 um 20:47 schrieb Jonathan Nieder:
> Ren=E9 Scharfe wrote:
>
>> --- a/khash.h
>> +++ b/khash.h
>
> (not really about this patch) Where did this file come from?  Do we
> want to be able to sync with upstream to get later bugfixes (e.g.,
> https://github.com/attractivechaos/klib/commit/000f0890)?  If so, it
> might make sense to avoid unnecessary changes to the file so it's
> easier to see when it's safe to replace the file wholesale with a new
> version.

True.  For this patch we're safe, I think, because it already called=20
xrealloc before I touched it (and has been doing that since it was=20
imported into git).

Ren=E9
