From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Submodules as first class citizens (was Re: Moving to subtrees
 for plugins?)
Date: Tue, 09 Jun 2015 20:40:14 +0200
Message-ID: <5577330E.3060803@web.de>
References: <CABURp0og9i9S3_ZWf5Ce9LT785QJo4H-TVtFaKUTXr2N7FB+ew@mail.gmail.com> <D2BB8369-E552-4AC3-967E-8F963206E03C@gmail.com> <5573E40A.3020502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Repo Discussion <repo-discuss@googlegroups.com>,
	Git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>
To: Stefan Beller <stefanbeller@gmail.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 20:40:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2ORn-00010A-H1
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 20:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753948AbbFISkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 14:40:23 -0400
Received: from mout.web.de ([212.227.15.14]:53703 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753997AbbFISkV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 14:40:21 -0400
Received: from [192.168.178.41] ([79.211.107.75]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MAMY6-1YvDS43RO6-00BgOq; Tue, 09 Jun 2015 20:40:18
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <5573E40A.3020502@gmail.com>
X-Provags-ID: V03:K0:fIQFZVX36G71kDZ3h/r1ozNUm0HkaiV3rsL6ng8SGu9+BU4Ho+s
 PpIH6HjZyPlZdzDxm3Q2A9AttfXZ6Svz0C+OwdsBz2YBDSz2nism2nJkicT2yNJLDEPZlrR
 wBjAG5OQXA0/T87md28yxpjaj0DFMH6vsL7hMle8ZBgSM4+TQUHPQ86uPoB0X1++PGp7uL3
 PvOFwDIMVfUAvfgk/r2mw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tuyTBXOzjhs=:YSsOUA8wg2pxaLhie4MbFc
 QCaTjKlv0taZi6kE6TZc4Z0lKl7JhPzIV3Rg25y0Ld99Y3oZ6KH7X4J3pJ2S2xBzTBLEOyUUs
 xp57q1kpa39yik1TxDJnA9/X3FWOgoFYwSMqblD6CH+rYf6eWi+o4U0avUtFcMEBZ8xo2dyF/
 qdUH60mhz9UOfnkwLYmkNamg8o5yky3F+LkO3ZOOrWOOfuaTrEX5mvO4YV3hQbUkf05RObM/5
 GMoLduPklPQ1aph862vGZQlj7B/ZcTZgtHmB7A/4P+0B+2vhXxMey4Pp2Gl0t6i5Qjrkg3ofH
 fiSAoNZlGzxXCegizSxgAYACT5Opr74nK94sC2ogPDEC1Zt7hcOgKM/9D05fCg+PyWrKsQ26I
 w/0RvUkL4sKE37b1QPyggc/pwEOQgEuVer+KK03CKkgk6XOJ5NdFyIMjTSr5uABo/Phcrbmvb
 IRqMpaKcmsqfR6ttnOD632IdW/S0wD5X8eOB080O3fbXseLY0xtnBUVWaAlg70YUyVI3nTcv7
 2BZBhjGvsQGjvI8F+opiGGPHM++3RhIkDey7OfRMI+0gDv/BxUIA03WSVxyeqQdJ13teCkI9+
 sRZvlEFQRm+fOnbPjxHERKOcFLvJnzBR3uFZrGU2NHCR+jWLiK8dpCnvBIDyJhLheECqdG6IO
 tLw9SGsd1F+Vt7qDa0Q2qOw84bJv4KVRrURANWOHMDlc4sz6C+PjoimJxorSDGFzqSp4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271222>

Am 07.06.2015 um 08:26 schrieb Stefan Beller:
> On 06.06.2015 12:53, Luca Milanesio wrote:
>>> On 6 Jun 2015, at 18:49, Phil Hord <phil.hord@gmail.com> wrote:
>>> On Fri, Jun 5, 2015, 2:58 AM lucamilanesio <luca.milanesio@gmail.com> wrote:
>>>> Ideally, as a "git clone --recursive" already exists, I would like to
>>>> see a "git diff --recursive" that goes through the submodules as well :-)
>>>>
>>>> Something possibly to propose to the Git mailing list?

Such an option makes lots of sense to me (though "--recurse-submodules"
should be its name for consistency reasons). This could be an alias for
"--submodule=full", as the "--submodule" option controls the format of
submodule diffs.

>>> I've worked on git diff --recursive a bit myself, along with some
>>> simpler use cases (git ls-tree --recursive) as POCs. I think some of
>>> the needs there begin to have ui implications which could be
>>> high-friction. I really want to finish it someday, but I've been too
>>> busy lately at $job, and now my experiments are all rather stale.
>>>
>>> It would be a good discussion to have over at the git list (copied).
>>> Heiko and Jens have laid some new groundwork in this area and it may
>>> be a good time to revisit it.  Or maybe they've even moved deeper than
>>> that; I have been distracted for well over a year now.
>>>
>
> Glad you're working (or planning to) working on submodulues. This is
> also on my todo list for the next months as well.

More hands are always welcome!

> I'd review stuff in that area if you're looking for reviewers.

I'll be happy help too.
