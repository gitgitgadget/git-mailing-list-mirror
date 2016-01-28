From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 1/2] merge-file: let conflict markers match end-of-line
 style of the context
Date: Thu, 28 Jan 2016 08:55:21 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601280851470.2964@virtualbox>
References: <cover.1453709205.git.johannes.schindelin@gmx.de> <cover.1453819314.git.johannes.schindelin@gmx.de> <13379804ad901b53d78d741156677664924fc50d.1453819314.git.johannes.schindelin@gmx.de> <xmqqoac8ci8o.fsf@gitster.mtv.corp.google.com>
 <xmqqsi1kavr2.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1601270856150.2964@virtualbox> <xmqqio2e996c.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1601272011570.2964@virtualbox> <xmqq8u3a95st.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 08:56:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOhRA-0008I6-24
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 08:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934326AbcA1Hzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 02:55:51 -0500
Received: from mout.gmx.net ([212.227.15.19]:49370 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934300AbcA1Hzt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 02:55:49 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MgcTf-1am1hi2SCF-00Nzqp; Thu, 28 Jan 2016 08:55:25
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqq8u3a95st.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:yQgPoqF1gdUK9Dq7oapAn/TqIFxjtcptlqVDiL9LIRnhB6tOZ9g
 i+sKSawPu683RW018W9KMY8GIHumw0k2O+Pnsg1zNJHCBk0BP8YEt7g5A4IWf2iwUxoao6Y
 +QDvwjugZT/LTFSBFfrl0foLsH7xr3aDIJB1mhbePkIEicvy7e0AX9NxzBJ7LkKDyjEXHVu
 33hnFLwW2ugEl6QA9llbA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Sisoes95+Yw=:K0GZuJGq0/kVoRJaKvjiQF
 AIzGj7ZPv/MyEwMTduDuDr0BtRJFP9ckKZLoJXEVpwUHFLl3DEKwKVyj5UVR+CZh3lO2CWcBh
 iNTE3zAUXwO3IH2gJl4x8Z8sJZb29hMu9YhzJ/+Ko9CQjpkSAkDbcCRCK0p9RC2svZLKGjSmd
 b40r6MhpsaHx4+Fncd0s+70I++SFo/W8pW60b1WDOcxAEak0rBSNotAqyjMv4xDoaL2oey+/9
 PoFPPvEMByp7d72lAtwMBhkoJaaHkSPX+SnLcgRjt0l9ZEfNovy/8R+awUyAnudgFm1bJ/3yz
 IYLREnbRl5yMMH0sZl/t2PeQZUzpYT1+GopK9ViLkmNZLQfZ2O/P3CrAGtOc3hQ9olhRvzHMS
 QjEnWc1hIYfFrxFPXzGAPdKpkWeCteZjNvC2OG/E+pSbpR1l4RyyyshQBre74FH+Ua3hrqXe2
 SI64OMS8KdjnCHOmcb18xANJsRNshKe10hZG3LlfE4ewIeEci9gicGLn1Al71vMYGNX91C0Sj
 9NCpz8u/pr4Fd8vuZUkUjCmp6zMpuYgjfIXkJDxXyW5JVQ0kE3uiI50daJr9rDt3tlPkaL2t2
 tL4WxHwzFBysEQUl/bBVLqexnZpZI2l0rUHj2db6xz/7wMfKT3TtV+uoF+lQAE6EU9A+uOJVw
 KwAisA3jr5ue56qCrd5Kw21bPaNkoMg6pEafreF1K/p6RWNinPTLEvPdPy6Wg9QaxXkd8QSHJ
 hIBi3JvWA32FtmQN2tyet/QaTe1i46tG12cfc8Zq25PhXqrrg9ZxOr6AaJZ6dr5tMx7jSGjm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284982>

Hi Junio,

On Wed, 27 Jan 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> [administrivia: I finally managed to correct e-mail address of peff@,
> which has been giving me bounces for all the previous messages in
> the thread]

Oops! I got those bounces myself, but wrote them off to Eric's account
without checking (because I consistently had problems sending emails to
him in the past). Sorry about that.

> > Your response is also an indicator to me that future myself will find the
> > same code just as confusing as you did, though.
> >
> > Maybe need_cr -> eol_is_crlf?
> 
> The crucial question is how well the variable conveys its meaning
> when it has -1 as its value.  "need_cr? -- I don't know yet" is as
> clear as "eol_is_crlf? -- I don't know yet", if not clearer.  I
> personally do not think "eol_is_crlf" is an improvement.

Okay, then. Let's keep the "needs_cr" name.

Ciao,
Dscho
> it unclear _whose_ eol the variable is talking about.  It can be
> misread as talking about one or more of the files that are being
> merged and mistaken as a statement of a fact (i.e. "we inspected
> and know the input file's eol is CRLF").
> 
> Compared to that, it is clear that "need_cr" is talking about what
> the EOL convention the resulting file should be.
> 
> I briefly wondered if the if/if (need_cr)/... cascade that inspects
> (conditionally up to) three variants might become cleaner if the
> polarity of that variable is flipped (we are allowed to use CRLF
> only when we know that among all of the three variants that we can
> determine the line termination convention used, all of them use
> CRLF), but I didn't think it through seriously.
> 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
