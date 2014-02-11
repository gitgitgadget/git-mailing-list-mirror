From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] fast-import.c: always honor the filename case
Date: Tue, 11 Feb 2014 18:29:19 +0100
Message-ID: <52FA5DEF.30407@web.de>
References: <1391346784-11891-1-git-send-email-reubenhwk@gmail.com>	<52EEA5D3.9000502@web.de>	<CAD_8n+RZACW0380co75gWSwVmCJdcH4COsySTF3BFCyKEumXNA@mail.gmail.com>	<52EFFA36.8090305@web.de>	<CAD_8n+RuwQEXJRCOr+B_PqA7z6LkFdbcRZkiiVJsEhJ=+YjRDg@mail.gmail.com>	<52F2AAFA.1090507@web.de>	<CAD_8n+Thn3tNTYxLK49mDOGdLpWRCFUCJo9b76UbAjnCdqXsRQ@mail.gmail.com>	<52F7E652.4030102@web.de> <CAD_8n+ToUDbXrVuru7GV7toYKHXuQb8vL3B_-sfzQdXZFqzD2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Dmitry Potapov <dpotapov@gmail.com>
To: Reuben Hawkins <reubenhwk@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaA==?= =?UTF-8?B?YXVzZW4=?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 11 18:29:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDH9H-00018A-Dg
	for gcvg-git-2@plane.gmane.org; Tue, 11 Feb 2014 18:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbaBKR30 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Feb 2014 12:29:26 -0500
Received: from mout.web.de ([212.227.15.14]:60079 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285AbaBKR30 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Feb 2014 12:29:26 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MRlIL-1VkuM919gX-00SvsS for <git@vger.kernel.org>;
 Tue, 11 Feb 2014 18:29:24 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <CAD_8n+ToUDbXrVuru7GV7toYKHXuQb8vL3B_-sfzQdXZFqzD2A@mail.gmail.com>
X-Provags-ID: V03:K0:M8MDjFfX92XRBNLog8D4fzXiBkK1+MlC+KsEjwnA13mXoAvKe6k
 u0SVk21234hTsx9OtgkgO+zROk84zp/P58UlRRKLxvo5y7/lEBU7TnvJsB8oHJiiKJYXYZY
 dQOVA7La8Qu2g8OyUZX5qkVMAJWdZRUmgYX9gfmTcZTXBep1wXz82lrjR3SOiGfaOR1ZsJa
 3xuN8zFgo0sKdK9HOsP4Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241949>

On 2014-02-10 15.24, Reuben Hawkins wrote:
>
>
>
> On Sun, Feb 9, 2014 at 2:34 PM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede <mailto:tboegi@web.de>> wrote:
>
>     On 2014-02-06 12 <tel:2014-02-06%2012>.24, Reuben Hawkins wrote:
>     [snipped away minor interesting stuff]
>
>         Reading the answers from Peff and Junio, I am convinced that =
the fast-import should
>         not look at core.ignorecase at all.
>
>
>     Agreed, but my patch 0001-fast-import.c-ignorecase-iff-... is wor=
king very well (for me anyway), and the ignore-case option may be usefu=
l to the git-p4 importer (which I guess is something that should be det=
ermined for sure).
>
>     If you want, you can turn this into a real patch and send it to t=
he list.
>     I think  Pete Wyckoff <pw@padd.com <mailto:pw@padd.com>> is one o=
f the experts about p4.
>
>
> hehe. I thought it was a real patch....so I guess I'm not sure what y=
ou mean.  What do I need to do to make the patch more real (pardon my i=
gnorance)?
> /Reuben
I have found a patch which was send as an attachment,
and that's why it got the file name 0001-fast-import.c-ignorecase-iff..=
=2E. here
So yes, it was a real patch. Please re-send it inline, not as an attach=
ment, as you did in
"[PATCH] fast-import.c: always honor the filename case"
>
>
>     And the same is for fast-export fixes you have made: If you have =
the time,
>     convert it into a patch and send it to the list.
>
>     =20
>
>
> Do you mean the fast-export fixes where I pushed all the delete opera=
tions to the front of the list?
Yes
/Torsten
