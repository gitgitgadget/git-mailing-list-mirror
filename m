From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] send-email: more meaningful Message-ID
Date: Wed, 6 Apr 2016 15:08:14 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604061505010.3371@virtualbox>
References: <20160405193952.5849-1-normalperson@yhbt.net> <xmqqinzv224x.fsf@gitster.mtv.corp.google.com> <20160405213607.GA15023@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Apr 06 15:08:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1annCS-0007k1-A7
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 15:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755361AbcDFNIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 09:08:34 -0400
Received: from mout.gmx.net ([212.227.17.21]:58142 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755349AbcDFNId (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 09:08:33 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M2Glc-1bdhSO1oKi-00s7rT; Wed, 06 Apr 2016 15:08:16
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160405213607.GA15023@dcvr.yhbt.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:tA/qN2p4XCsjrcyJpjePRwVO+Xc0lecrY65Tdbf4vNNdGdATiMI
 r8ysJusHVoHIzmPgggfe6ycahBR8C2n/R2wRdm2Gwlry0cSq5LuCVR7veT1oaCGlZuSigsz
 3toIBtekqKe6HlhV6VNm2f3ay4+1nNENhG8Bd1/KriUPcEYNUpwlzb00KYgGpH0iGfgB5Z/
 3v+dxx0egNJqiToVSOArg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sObnxbj+nBA=:G5XCh3/9a5uB/Jkvwt21oe
 64xWyrrCtHIUzf7cQ7mJwCQ3BVmRpa75ZBHRm77w5bVynLSNU/WpDc3yEN5egFZcUo7X31zBb
 eIpVkI8GlVO3xVP79QSUMwR+gRP55e/ADcaFy+6kml+zA9/14V5+ayYvYoM7vEhQJtptmWj4M
 AcAT3MfB8BA2IA2UUN8EVqTygPY4upPiyU6IxlZCSw7PcO20b01HIf8cw9aoWbc6ga+8WCfBe
 XViUQVt7l6rTAdPv+3Q9alMCupKaJBxhKgGFM2Y3faNlCDEzMWGttFVlyP+I9KMh0T+RrbyW9
 MxvsJd6T/0S29KwzUEG2j6bAs8h69E8Cp6altAQQsUukpnbZQnBdLmPP7JfQKkCU+stZudC2e
 30QjfFK3LflBi+pXAn0U8IQ/wXFsUj9KpU8brcMQFWNpo6WShpZppgg0t3MZ1EEtBa7c3UUy7
 Bb+uKGG8qbzSimZ5GZRYBZpFwihX9rx439HnYw0g1hUhDIJX2RZmNQO34BIia82AC0r6Uiy4T
 Fsfy8pHme/vEvUNpHsNVQEYMKnfEruL4/4FPiEf65Uk/tqKsfyBj8u7mnM/lMfN1hMMmboIzQ
 NE3co61L6zzJQEU9NTF0vqg6vEhcaEoZ8jikh5dEchbQppHnGPihEtrSBp8Un4JXMhygcV4VO
 h+9CSnCS1IJk6oJK0NNKjv02ev1qI5e3As7WDzVvWo1XfRcNmFE06I6FsNQ1A1t+TnUsiXvyF
 wEqw7cUQYgnRe4xsHOiKFMb6pDQa3paVTLEsuf9HhkhjpfiV3ix4XrCaRqMb+X26hPUowWTx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290839>

Hi,

On Tue, 5 Apr 2016, Eric Wong wrote:

> Junio C Hamano <gitster@pobox.com> wrote:
> > Eric Wong <normalperson@yhbt.net> writes:
> > 
> > > Using a YYYYmmddHHMMSS date representation is more meaningful to
> > > humans, especially when used for lookups on NNTP servers or linking
> > > to archive sites via Message-ID (e.g. mid.gmane.org or
> > > mid.mail-archive.com).  This timestamp format more easily gives a
> > > reader of the URL itself a rough date of a linked message compared
> > > to having them calculate the seconds since the Unix epoch.
> > >
> > > Furthermore, having the MUA name in the Message-ID seems to be a
> > > rare oddity I haven't noticed outside of git-send-email.  We
> > > already have an optional X-Mailer header field to advertise for
> > > us, so extending the Message-ID by 15 characters can make for
> > > unpleasant Message-ID-based URLs to archive sites.
> > >
> > > Signed-off-by: Eric Wong <normalperson@yhbt.net>
> > > ---
> > 
> > Sounds like a sensible goal.  Just a few comments.
> > 
> >  - Is it safe to assume that we always can use POSIX::strftime(), or
> >    do we need some fallback?  I am guessing that this is safe, as
> >    POSIX has been part of the core modules for a long time, and the
> >    script does "use 5.008" upfront.
> 
> I'm hoping so :)  And none of the format specifiers used here
> should be subject to locale-dependent weirdness, at least.
> 
> +Cc both Johannes for Windows knowledge.

Thanks.

send-email is implemented as a Perl script, and Git for Windows uses a
Perl interpreter for such scripts which uses MSYS2's POSIX emulation
layer, i.e. POSIX calls are fine.

Short answer: no problem there, not even on Windows.

Of course, Git for Windows users are much more likely to use a Pull
Request based workflow than a mail-based one, so it is even less of a
problem for us.

Ciao,
Dscho
