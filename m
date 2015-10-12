From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Reinstate the helpful message when `git pull
 --rebase` fails
Date: Mon, 12 Oct 2015 11:40:56 +0200
Organization: gmx
Message-ID: <ed70803ecd73415f1bbafb68502fbbda@dscho.org>
References: <cover.1444336120.git.johannes.schindelin@gmx.de>
 <xmqq612grhg7.fsf@gitster.mtv.corp.google.com>
 <CACRoPnSPVMt+FtK6bwfa7Z3jBheTEkBnhU+B7qL8JrAsSmAmkQ@mail.gmail.com>
 <xmqqk2qvq570.fsf@gitster.mtv.corp.google.com>
 <xmqq4mhzq41e.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Paul Tan <pyokagan@gmail.com>,
	Brendan Forster <shiftkey@github.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 11:41:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlZbP-0002xL-OZ
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 11:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbbJLJlD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 05:41:03 -0400
Received: from mout.gmx.net ([212.227.15.19]:51947 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751173AbbJLJlA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 05:41:00 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0McEI3-1a3WWc2sER-00Jbgc; Mon, 12 Oct 2015 11:40:57
 +0200
In-Reply-To: <xmqq4mhzq41e.fsf@gitster.mtv.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:/3A1TbNedpU9TNK5Mo6Y3knw51qN4KXR9k6BKdr/ouGu9Pzv1/8
 NJ83D2SaUNycV0oVSG0SDVE2+/UPrD0LAtF8RqmOaa/YETkhUC8eEhdi5jiDj1x3Grb1Djh
 JxZ97NVq7uWbFHmTDWvsD8GNLC9/Z9bNF9fTtAJTA3WDEL9CdWnBbQQabzIWm6nLPt/0QDp
 mjrb68Vd9py//ZDZPEHpw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9bqfCWIVynk=:DPvyPvCape4qDLsGa4Ye0V
 SyHv3KHDePeops8O/a02SKaikmPLJdeRdOar8+VGh0ZZ4fE2r3TwMzLIvEJnWrJhtNJZQNecH
 kI95Cl1TTSw52ax0/H/kO/lklJ1DVeuTy5aDhx3SGCDL3lIyAEe2xqmufLj6qfrJGkHxwore6
 64lvAi8XryWkdLOS2uf65rA4YbTgDOB+GcqWjYHxgj2rXMwuibVppbnJGsTlyqNgu2uzlig9H
 UxSr7n5tMlC15mrytxKlE7WY7L2W/BA7nCfdYC10jVOYFLz8ixF6/gHDvW1Y8iYRFasHaXqbn
 sjujjqG/AhGiQiDk5h2goZO/HLLgyTav//WhW88fytQdfdW4+SDYddUGHwCg3mzAejuUbLZWH
 KB1npZ4JT1LFpZ1b1rOHoWOY6YRct0j4EekFysZ+yUCw+X/80cGVJZCTGNJraJ7Q0agZuge8T
 SDcQTgNvPmrVru2YhhjGsUqVRPsbmPNuDU+EBbIwoVluP+QgjIPa+VAvovPjoY2DVkad/1xga
 VWe1R3P1bYl35elgx3kZM+TctQhIQ+rvAqPHU6jB7gIgBh+QiW4iwprBhPXNJF1amM2G0xzKM
 awlxtRw93Ao5Z2qfYF+0urR9n+dL2h12NKvKPQxHignjZVJ17T0cqgAc2+dUPg2m4w2ifdHb4
 QfQ5YPYXBSqiBrx2AKiLQSvMtIeTJ935h4PrI9AhpNkzkwOnEin6j7kt1O8YiTYKlEh64qK0g
 KDlHafw4t7XOy9SIFJ7sXZ2fIEwj7HVKdC5Lhb02m2pu47NoE/McpMH9b1UufzuavoZ9waaI 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279369>

Hi Junio,

On 2015-10-09 20:40, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>>> Instead, stepping back a bit, I wonder if we can extend coverage of
>>> the helpful message to all die() calls when running git-am. We could
>>> just install a die routine with set_die_routine() in builtin/am.c.
>>> Then, should die() be called anywhere, the helpful error message will
>>> be printed as well.
>>
>> That could certainly be a valid approach and may give us a better
>> end result.  If it works, it could be a change that is localized
>> with a lot less impact.
> 
> I looked at the codepath involved, and I do not think that is a
> feasible way forward in this case.  It is not about a "helpful
> message" at all.  You would have to do everything that is done in
> the error codepath in your custom die routine, which does not make
> much sense.
> 
> I think the most sensible regression fix as the first step at this
> point is to call it as a separate process, just like the code calls
> "apply" as a separate process for each patch.  Optimization can come
> later when it is shown that it matters---we need to regain
> correctness first.

I fear that you might underestimate the finality of this "first step". If you reintroduce that separate process, not only is it a performance regression, but could we really realistically expect any further steps to happen after that? I do not think so.

Also, please let me clarify why I called reintroducing the separate process "heavy-handed" in an earlier message. As pointed out by Paul, the dying code paths indicate non-recoverable problems, i.e. serious problems that not even a rerere could fix. Modulo bugs, of course, but those bugs need to be fixed and not papered over. The real bug, after all, is that a non-recoverable code path is taken when it should just return with an error code.

Reintroducing the separate process would not help the endeavor to fix those code paths. Indeed, if we still had the separate process, I would never have discovered that bug!

And we should also keep in mind that this whole story demonstrates the rather serious shortcomings of the mindset we display throughout libgit.a where it does not behave like a library at all. Of course, hindsight is 20/20, so it is all too easy, and not exactly fair, to criticise the short-sightedness of writing code that does not clean up after itself "because it is a short-running process anyway". I certainly have contributed to these problems myself! All the more eager am I to help *increase* the number of functions in libgit.a that are reentrant, eventually making libgit.a behave like a true library. And in that light, what you called "the first step" appears like it would be a huge step backwards.

In contrast, introducing the "gentle" flag would be a step in the right direction. It is a much lighter stop-gap solution, too.

For the above reasons, I respectfully remain convinced that reintroducing the separate process would be a mistake.

Ciao,
Dscho
