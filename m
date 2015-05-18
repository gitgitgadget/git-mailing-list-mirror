From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH] daemon: unbreak NO_IPV6 build regression
Date: Tue, 19 May 2015 00:29:40 +0200
Message-ID: <555A67D4.9040204@web.de>
References: <CAK4aQQJ9yT8+Q9jPQ78cauhyPj3j5WmpgrQJ5=cA-ECjaWn8BQ@mail.gmail.com>	<xmqqioc6ewnw.fsf@gitster.dls.corp.google.com> <xmqqd22eew4v.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eduardo Espejo <eduardo.espejo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 19 00:30:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuTY4-0005sB-Lg
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 00:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754570AbbERWaH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 May 2015 18:30:07 -0400
Received: from mout.web.de ([212.227.17.12]:51140 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754465AbbERWaG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 18:30:06 -0400
Received: from [192.168.178.27] ([79.253.146.148]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LlniO-1ZToIU49hI-00ZOEC; Tue, 19 May 2015 00:30:03
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <xmqqd22eew4v.fsf_-_@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:/0376HILZlIS0vxAqP5gWlfYj/Gzuxd5pTydCBG8bsEcFw2aE1U
 RGvFfcsWpv5KbBrPuEGRixtqiftW2Rq9rnzwKOR4AkIER5mEWldF5zFLbZlD9UoBSHJfkQY
 o+28NNU+tUCKniFnmkB/MkXqCA772922Wjd50Dph/fApUbPWivOo/AKVV26H2Y2DSDsbglK
 sQyQblQmNg2gKBs4N5PnQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269328>

Am 05.05.2015 um 20:07 schrieb Junio C Hamano:
> When 01cec54e (daemon: deglobalize hostname information, 2015-03-07)
> wrapped the global variables such as hostname inside a struct, it
> forgot to convert one location that spelled "hostname" that needs to
> be updated to "hi->hostname".
>
> This was inside NO_IPV6 block, and was not caught by anybody.

Sorry for that, and thank you for cleaning up after me. :-/

@Eduardo: Out of interest, on which platform (CPU, operating system,=20
compiler) did you notice the bug?

Thanks,
Ren=E9
