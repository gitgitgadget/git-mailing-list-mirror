From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/2] Support marking .git/ (or all files) as hidden
 on Windows
Date: Wed, 11 May 2016 10:34:06 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605111032510.4092@virtualbox>
References: <17d30bb680a0452efd7b3c4f42e2f94478a86273.1462372716.git.johannes.schindelin@gmx.de> <cover.1462603453.git.johannes.schindelin@gmx.de> <xmqqposvw4fs.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1605101036460.4092@virtualbox>
 <xmqqh9e5rfoz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 11 10:36:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0Pcd-0007Wo-9i
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 10:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbcEKIfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 04:35:52 -0400
Received: from mout.gmx.net ([212.227.15.15]:53758 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751594AbcEKIfu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 04:35:50 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MLeoF-1b08Ui2alX-000rdd; Wed, 11 May 2016 10:35:15
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqh9e5rfoz.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Uxi1L/hJZXOPVnf9ELzZM73hxjFCb6HvjYpfSG2MOyifuA4Nv2m
 FpF55ZCLrLSiHUZxTipHwMgPL5yKvspYQZ3WcnnAvbESH485fq8jerSooS1fUsp8jnOEISW
 Qh5pV3VpB9UDxkAMPdQ6mDJJAM/bfFkJ0EClxoUlFK8J53az7bSLgKbtZtfWpuMZm5apzzN
 GoafJK6D1N+ZwrCQUg9Rg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jbsSEfJLbzU=:3JP4naz0IUOwXXEj0XCSo1
 0l7fLyZc5Hx8o76Ttejd1H4PrxkttEuFq9a4t0GB+tzWO27Gm3YAe5qXGx0UMmZsrPjrD5h+x
 u6G7QVF22wqA8g63PZ4wnTkpVAE0lgcApOi7H8sb0xpG0sb97+S06WYRIaKlT52MEKU2fS9qV
 2S3UcELr46ggLQ1Wzik6vhhkV0ph7xm4ERYl7yNShCwjKAzmKxp3Zbj8bmWvKY7FJ68mQRPPP
 QQdOqaifjMt0buYmOScIL/IHNS9J1MpRLFdTNsIii+S0zUaIB+67cFWu1fduZAHfBfBhwypn/
 7UTnDgbF7wGyRoQtVkL39fWH7O9g9LA1NoRqcgbZTeT4kmo//LV6JdyA+IqdmuLcFsFYtdRqz
 FmWxmqUQiXh8yzZt3XbTcOm7W9sSoN9d131irqV9KqFENQrqqDWtG42HwDnVmrhH7pyFFDTJC
 qUTsdKo0V/3Ja6oJC5l6cfRPZwAbg1bWB4fZMOaqrbqS5Jn0C0KtGHQgyK9Ck4CycWFDLGHj3
 yxRflbPwv+Zjfurf2nNueWR7LkJXGMaWp4uaFLlqR4k6FfRyvKlpBWt5QrnxXSlkzPsdFuk71
 UJNBgvgb1SKswJCtPB2MiDNh7m08cPXhrw7bXAcQB9emMXBk6eDlt6sOR9WNFFwdbmnyDCaLx
 5ny8ZdNHBWRMdVY+SF7ZcsXe5CjZ2Pq+vDkSk1Y11vV/wo680CzjvHQfsD3UrSTGalMiHV59X
 tVhYHX6qMUOQbEyZYbSeXEwYT2gbici94qnI1iAwTEX8PtaqUbjxK0oy30VCNwTYxUxVDGFG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294238>

Hi Junio,

On Tue, 10 May 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Mon, 9 May 2016, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> >> 
> >> > This is a heavily version of patches we carried in Git for Windows for
> >
> > s/patches/patched/
> >
> > I wish I had a penny for each time I wrote this particular typo.
> 
>     This is a heavily version of patched we carried...
> 
> does not sound all that grammatical.

Aargh. What I meant to say is: "This is a modified version of patches we
carried in..."

Sorry for the noise.

Ciao,
Dscho
