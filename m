From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t9100: fix breakage when SHELL_PATH is not /bin/sh
Date: Tue, 9 Feb 2016 11:07:40 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602091101250.2964@virtualbox>
References: <982f6f499c988e1063275e2951c9856d622a83f3.1454872161.git.git@drmicha.warpmail.net> <20160208135013.GA27054@sigill.intra.peff.net> <CAA19uiRSu_6Os3b498obSNec7b2uiYv20SZ=y93CkjsWqhqHzA@mail.gmail.com> <20160208163700.GA22929@sigill.intra.peff.net>
 <alpine.DEB.2.20.1602082027550.2964@virtualbox> <20160208193509.GA30554@sigill.intra.peff.net> <alpine.DEB.2.20.1602082056410.2964@virtualbox> <xmqqd1s77yhg.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 11:08:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aT5DN-0006ap-EC
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 11:08:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756139AbcBIKH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 05:07:58 -0500
Received: from mout.gmx.net ([212.227.17.21]:57235 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755905AbcBIKHz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 05:07:55 -0500
Received: from virtualbox ([89.204.153.48]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LzbXq-1ZyiF01B7S-014nEc; Tue, 09 Feb 2016 11:07:44
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqd1s77yhg.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:TCvRjY/wTMN4gnmvLpWEKLJGFxtsVKzVY0Zn5feAOdzA1zEK4vN
 yk/+LhlY0/9Ta9MCt+I304cyE2E8SyMkPrzPD1p9k+ou0XIsThAJTrKkGojpmgkrlsq/fl5
 tLyNxuxPPRt8sX+wYHHuX6CmH2Jl45i9OE+J8U6vSig6Q5mHbR83rrNzIpkXCNbtq1mBvf3
 fjc08HijKU0tjasb1EZMg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5DqLbNkZDsI=:T0XCfPigvyhONcZFGtpQ3L
 cUNwCWRZiraehaaAI21l++qnu8Zz+LnAxvutBCTcCV9ukznHXGEmbxAzpM26L/pFSloaBq19P
 wLM7M3kl0Hx+O6IirP4+Arg9r5suRPzBbp5RmFMXZvJ5dI0ZNpgdGGzCkj/oGJ6bYKO3WIYDd
 A0jeeyEF+SyXuv4JJ1uI+v5193z6QfgnUW5A10dT9fgWeXZ8OPEwiOLLG/c8EQa/KBeyVq2A4
 oZnwUARB0+ifl3garxzWvIjMYHjd/E/sAhUr3Qw0cGmCwz7dKkCzfJTxpyfoNoOyb+aqABexx
 2UaRvub1GgItBolS9GqzAzsxaVai/yg8GQnDWNz3t9bYnmmKOVfzwUxRP5v9w145afMDuwYi3
 BgQlTd71e+/HMe3Hnnkto2W34bp5903V6UDd01SlLCIKQxibmBh/kt2/YHzBtlMMoeYzg+Hww
 BNJafqr9v9VN8UxzY386zxTScpcQma1h2dsr8dI3KsM7ebD1597vKPxRCCn7Q7J/aRAcxiHlr
 rnt0Ss4Vj1fTSCugt9r3MdfjlbS7GhYmRx6B6MuwNvd1jR60BI03b2I3C9vJ8mTI+pZVa4uF5
 EDVMfp/tZqG8XBcwytCuYapmbnToO5XdOUQV/ACMwCQnv5zqQOFEEmBZBMCUM49FWIcOzZbWz
 n2kKCETYt470zuFhaFojwfTp0yCPulcj7aNcclvfmYxBmyAq3VBjKYV95g/QTrF1HnW18WV/s
 9w4aC0423h5xkSJlqY9Va+clV8ns65Gnfc7Vn1ESR+6fbgmZ5y7+v9YZWq7bPrZ16ht/UbfG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285835>

Hi Junio,

On Mon, 8 Feb 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > write_script is a semantically unambiguous way to specify what we *want*.
> > And it would allow us to handle chmod specifically for Windows *in one
> > place only*.
> 
> Correct.  write_script, for the intended target of the helper, is a
> way to write a script that can later be invoked by the test with the
> name "$1".

And whose executable bit is set, contingent on the POSIXPERM prereq.

> It is conceivable for write_script on UNIX to be writing
> into "$1" while Windows version to be writing into "$1.bat"

Oy vey. Good thing you did not see my first reaction.

Shell scripts and batch scripts have *very* different semantics. Therefore
it would be a major nightmare (for me, not for you) to support writing
them *using the same write_script invocation*.

Let's just not go there.

> But the way the test uses this exec.sh script is not consistent with
> that.  exec.sh for this test is merely a data, whose content must
> exactly match what later tests expect, i.e. it wants it to begin with
> "#!/bin/sh" and its execute bit on, even though the test does not have
> no intention to run it as a script.

The important part, of course, is "and its execute bit on" which makes it
a moot point to ask whether we intend to execute the script or not. A
script is what we want, and a script is what we write. Therefore,
write_script is what we call. With the $2 fix-up to keep DrMicha happy.

Ciao,
Dscho
