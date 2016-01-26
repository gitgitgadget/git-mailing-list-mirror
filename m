From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/1] merge-file: let conflict markers match end-of-line
 style of the context
Date: Tue, 26 Jan 2016 17:49:26 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601261745340.2964@virtualbox>
References: <cover.1453482052.git.johannes.schindelin@gmx.de> <cover.1453632296.git.johannes.schindelin@gmx.de> <d71c7abddd4cba85b967f9fe1d33c7c843176ca2.1453632296.git.johannes.schindelin@gmx.de> <56A4FB64.4010609@web.de> <alpine.DEB.2.20.1601250749580.2964@virtualbox>
 <56A67B6F.60300@ramsayjones.plus.com> <alpine.DEB.2.20.1601260951030.2964@virtualbox> <56A7A240.7000102@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Beat Bolli <dev+git@drbeat.li>, Jeff King <peff@peff.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 17:49:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO6oM-0003B1-7S
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 17:49:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966704AbcAZQtm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 11:49:42 -0500
Received: from mout.gmx.net ([212.227.15.18]:64436 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965442AbcAZQtl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 11:49:41 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LfjlS-1Zm0pu3iXa-00pKWO; Tue, 26 Jan 2016 17:49:29
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <56A7A240.7000102@ramsayjones.plus.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:lWaGnS8TFU4nBvIPuxReXGzeCTs+uBr1bkJXeaTncLefVD94lly
 /0XKeW8atTY/9+dvcLmf1shIX2FkgP1wRiN+Zsh48Zre486pc/KSCrPQ0677xLHos9wwQWD
 H5XC3qu4Fvd1bdaGAjLPtVaGBEJGF9mNMSGMjYXDnUeqgvcEouM3/v7SHD6gUgdGWH2/V9T
 i/sYe0ocRtspOqAKwBw4g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KR2TsnewqeU=:E+GSI3VT95tdCblIRPPxJC
 Wfosn5S5ZZHtxTR4E8EpN68lzlEBz3kQubQPAFljbzH+eLRIiFQbfCOC4PqvIbGIwDzxiABz+
 EBX8YXlI5GclqrnpUo0bKxzY4ChK+t5NquHNVMm4ROYWDmANaQznmXi1Maks5Rc1WbBEb1+Cg
 mZDEzRIfcNkx+3cCmIcrmNrNL0cC9iYAZpKzt3lOkxNsSbIxRO2JbIK5ZUCf7HIfReughSXsI
 WcQwGUC9VVVU/18OWCqh64Q4N/M+rAlw483H7uSioF6BZKVn/3KfjfFJ+u89SeUa4VTE9pV0q
 gFjFYXzpFZkhUj5m8HP6xU3pqOZJE95niDAd+86dAT6BS2gMLukX4qB8YatTC0ULv2ofJ/9EV
 12B1ztuIMEvku2IGEPiAqWT3cpuBLNoy0+B89sXb0fG3hKPMuXEmVoyJJvxQQN0eO3CD/M7+6
 In0WpluvwS3U/6hkMaD78eqmp7ZKkkz8HtVb80wwW4T6FUI11I5qDxQtXvkLGGb8Equ604NoM
 7ji/38tAOVkYX2GokI8esiU/RJE+NcdQWc2KzR4HHWFEZloGrLzvrTGzBWkroWm3DWd7FDAZR
 MvVF9kLzLcepMi0KHLr+FP/xfdQGSg/ic+mD+2ef+7dqPoeMnGzOD6XG5uPRTQE2Le85cO2CP
 d1tYDl0IxFNoqVql5sYFoyc81oXzWZvox6fIHq/XTA0PmYKKRe8ZRbcU83nYIn91yQv2QI1IW
 SlcLUBhIPRAeYJq2M6poNXe0ITEBY/9szxW+HRv35ro0h33Q7Y4FIFkIdwoJd4L9xJrVYa6S 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284842>

Hi Ramsay,

On Tue, 26 Jan 2016, Ramsay Jones wrote:

> On 26/01/16 08:54, Johannes Schindelin wrote:
> > Hi Ramsay,
> [snip]
> 
> >>
> >> But you are only testing 3/4 conflict markers end in CR/LF. :-D
> > 
> > The fact that ||| markers are present is the fault of previous test cases.
> > I tried to make a point of *not* relying on such a side effect (so as to
> > debug failures quicker by commenting out all previous test cases).
> > 
> > So the fact that I am testing only 3 of the 4 conflict markers is very
> > much by design.
> 
> I'm sorry, but I don't understand what you are trying to say here. :(

Typically, there are only 3 conflict markers:

<<<
diff 1
===
diff 2
>>>

However, you can tell merge-file to show also the original hunk, in this
case it was done by calling `git config merge.conflictstyle diff3` in an
earlier test, and this implementation detail seeps through to the current
test case.

Guess what, if you really only quickly want to run this last test (and
comment-out the previous ones), the conflict style is *not* diff3, and you
end up with the three conflict markers again.

> >>> Read: I am uncertain that I want to spend the additional lines on
> >>> testing more than actually necessary.
> >>
> >> If the here doc is too verbose for you, how about something like this
> >> (totally untested):
> >>
> >>     test $(tr "\015" Q <crlf.txt | grep "^[<=>|].*Q$" | wc -l) -eq 4
> >>
> >> instead?
> > 
> > Hmm. I do not see the benefit over grepping for `txtQ$` it's essentially
> > the same.
> 
> Well, as I said 'totally untested', but it _should_ be different. ;-)
> 
> The output from the 'tr "\015" Q <crlf.txt' subcommand should look
> something like:
> 
>     1Q
>     2Q
>     <<<<<<< crlf-diff1.txtQ
>     4Q
>     ||||||| crlf-orig.txtQ
>     3Q
>     =======Q
>     5Q
>     >>>>>>> crlf-diff2.txtQ
> 
> so that your 'grep "\\.txtQ$"' should select these lines:
> 
>     <<<<<<< crlf-diff1.txtQ
>     ||||||| crlf-orig.txtQ
>     >>>>>>> crlf-diff2.txtQ
> 
> whereas my 'grep "^[<=>|].*Q$"' should select these lines:
> 
>     <<<<<<< crlf-diff1.txtQ
>     ||||||| crlf-orig.txtQ
>     =======Q
>     >>>>>>> crlf-diff2.txtQ
> 
> (ie. select all 4 conflict markers).

True, I overlooked that the middle txtQ comes from the ||| line that I
actually did *not* want to test for (see above).

Will fix.

Ciao,
Dscho
