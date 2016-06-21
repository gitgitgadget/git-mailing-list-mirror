Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C6081F744
	for <e@80x24.org>; Tue, 21 Jun 2016 11:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154AbcFUL45 (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 07:56:57 -0400
Received: from mout.gmx.net ([212.227.17.20]:53541 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537AbcFUL4H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 07:56:07 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LorB9-1br8rG34F1-00gsGm; Tue, 21 Jun 2016 13:55:01
 +0200
Date:	Tue, 21 Jun 2016 13:55:00 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Lars Schneider <larsxschneider@gmail.com>
cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] perf: accommodate for MacOSX
In-Reply-To: <F67587B5-0EA8-4F2F-AADB-4343B4FEEA21@gmail.com>
Message-ID: <alpine.DEB.2.20.1606211350470.22630@virtualbox>
References: <ae429d2481111f7ad1927ef22e3a691d4c99ebd7.1466254995.git.johannes.schindelin@gmx.de> <9A11C3D1-3DAC-489F-BDF9-F4D409E8D3F7@gmail.com> <alpine.DEB.2.20.1606200840350.22630@virtualbox> <xmqqa8iftzex.fsf@gitster.mtv.corp.google.com>
 <F67587B5-0EA8-4F2F-AADB-4343B4FEEA21@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:p//CPgTpfgV5JpjbHKyXNPok1Q90qB21u1fzWwiIKEUabhy1KC7
 XNyX7Nks2AO5N8rjvfyWG17/H/32YYWJ6+hh2OI5kFK6xY4LXUoUElyT8mSMpWWScd5cP8D
 k1wYl4Trf6Zm9BIjMzxx+q7NsovN/jV/1Ig1Z+/F22Q0Ma0SRQBllUwBJBHRI1hkzbGwWRE
 8hRn/JkVjLwuZ0r7LayAw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:M96XdbJ+x7I=:cBIk4etTSHeKaFs1eAOF0s
 25h/H4EoceYMF4Y7CP1fh8SawM26tfO3tmz7b2k3xa6bqB9pe1q/7FXfyr5+PDCeDchMBal5m
 jveWKhJzonQmV3xbBdvFHIJvl4Whrp+5iu76A06UyhABmu8KquiO0CBvHK4OeKL7zlUTdd5or
 jie3vp/kp4CPiy00TpOSsf2cuv5BtbVG+O1RDzukyleZMny0Gv6IQuDYIjzgoryeYD/MsHb0j
 PBh9njOhKDZDVG6QPofzZS3bbntHSxQhzuIq7Hu0LTXWAzYfhpHtMhRqKbVi3WBkvfHjPHKy9
 PrPzg2xqy4Us+vfVBxiHp6/lTY7U3RbrAQTkbt3l10vc5qIy75mGK8WHTDt/PtxS1Ff0VWum4
 abi37fQLWNDVm1ckFCZOhlX0pP15kCjfYj2bvBjrkqt8fo0NRNAQS65xBzyJ+7InNUjVFVSiJ
 tTaJfDEqQ2wm4h4rYDGTC7mMOWosAi4yH/yB3z0jlycSkno1hfq+B8PglwGNhdvWXB5S7ttxx
 22fv+OLOGdmAmxG7UuYxyDJWhI/4/RSIwKTA5wSSOu6GWQEEe0zW4+elossh9jlW4t5U4mQaF
 FQTRZnCbeV6JKAl0ieQ0E2bJ/O0ofkSrlCDel02JLbXkaPbOvR1gNt1FZlSV+eMgs+lvqxYu1
 YHG0VJqpc7SAVz+Q8J1y0oe3CBZF8DzzOjrDACyNxzx6418+5Ku+lQcg0WneF20FOxCKLJOTR
 pbBpO+8l3swJRqqMiCbnfqfctMz2p7VI9rMkYEi74yavBkZZiOOWOCyC54HPLfmJ2QA/5eXUm
 WLh5jRO
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Lars,

On Tue, 21 Jun 2016, Lars Schneider wrote:

> > On 20 Jun 2016, at 21:48, Junio C Hamano <gitster@pobox.com> wrote:
> > 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> >> On Sun, 19 Jun 2016, Lars Schneider wrote:
> >> 
> >>>> On 18 Jun 2016, at 15:03, Johannes Schindelin
> >>>> <johannes.schindelin@gmx.de> wrote:
> >>>> 
> >>>> As this developer has no access to MacOSX developer setups anymore,
> >>>> Travis becomes the best bet to run performance tests on that OS.
> >>> 
> >>> We don't run the performance tests on Travis CI right now.
> >>> Maybe we should? With your patch below it should work, right?
> >> ...
> >> 
> >> Yeah, well, I should have been clearer in my commit message: this patch
> >> allows the perf tests to *run*, not to *pass*... ;-)
> > 
> > OK, Lars, do we still want to take this patch?  I am leaning towards
> > taking it, if only to motivate interested others with OS X to look
> > into making the perf tests to actually run.
> 
> I think we definitively should take the "perf-lib.sh" part of the patch
> as this makes the perf test run on OSX and therefore is a strict
> improvement.

Yes, it was meant as the starting point to get more things to run on
MacOSX.

> If we don't run any perf tests by default on Travis CI then I wouldn't
> take the ".travis.yml" part of the patch just to keep our Travis CI
> setup as lean as possible.

Maybe commented-out, so that people like me have a chance to use Travis
for MacOSX perf testing?

> Running perf tests on Travis CI is probably bogus anyways because we
> never know on what hardware our jobs run and what other jobs run in
> parallel on that hardware.

While I agree that the absolute timings cannot be trusted, I have to point
out that the relative timings on Linux at least are consistent with what I
could test locally.

Could you let me know whether a commented-out

	# Uncomment this if you want to run perf tests:
	# brew install gnu-time

would be acceptable? I will reroll the patch accordingly.

Ciao,
Dscho
