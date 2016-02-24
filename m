From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/5] README: use markdown syntax
Date: Wed, 24 Feb 2016 08:08:52 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602240801550.3152@virtualbox>
References: <1456249229-30454-1-git-send-email-Matthieu.Moy@imag.fr> <1456249229-30454-2-git-send-email-Matthieu.Moy@imag.fr> <xmqqoab71c09.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	emma.westby@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 08:09:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYTZL-0007DY-7M
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 08:09:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbcBXHJC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 02:09:02 -0500
Received: from mout.gmx.net ([212.227.15.15]:57632 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757183AbcBXHJB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 02:09:01 -0500
Received: from virtualbox ([37.24.143.82]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LxxKu-1ZtrRy0XlE-015LHv; Wed, 24 Feb 2016 08:08:54
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqoab71c09.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:lUweals+/yWe9ru4OC1LRpZWtHdVdF6flyZoOkJKP+4exQv+FRV
 ajq8NXIcPmemlfNmPq+0/IuByKtGEDLhuknSH7ScCgEuX8c0+V/h3/iQx3dq6OvN7t72Sbh
 zDMFlYIoxiAJvvc2HZLvX3j2UAOjzpolV5lUgC+T76+YAnDkiTchEKqHVKIlg12XTcUr2GD
 DjFlG4FB1f+bjfQZdcwnA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:F0syAyDO9Xo=:Ajg+hDA309PZ7sd1U7J/VC
 bbltdi8VgAroX96nC5txm0hj9w8zI843yMViPMB7GnmyfMtdV1ilnUkkwSeK6TigelH7xDBP7
 srjTFwLNZ5p3unDqxI6wu1sNjYLZawbvvfIQqi0rSnNGItiDExSXrXgNGWnbZwSeU/3GkkXBp
 6oHbQ5ZADEtPHsx007Ee1T7afO159nkcNC5SbVyOkq1b2r4kWs5Y+47B+qM67ZX3OL6G1SMaZ
 NYwJMyzKP8kjA0mML+/quQKsNiCroENNoc0R9TAVg85dqM0UJ9PzmMNPuoSQNOvBCVP++E/kW
 ATdHckXwnird0WkNAHFqP3XXQDWnGVGf1D+UWad+CFrMeUvLjN8YCOL5eqs+vd3KTTZWbcS4P
 AgwLVtimwEq8NpSOzZvxZcjsTXp1tQi4/FITt35/hEWeVtbfrpbtChOqyrfQY7je7Lq2NtHbj
 CEgVIpvdJH2AM5XE6l+kXIBen7qpXizA9FEdqTaTx9PuGmPOUHm30zs3Em0D5SqCTDfQDzUI8
 mF/PNCvrJMy8tYACe/yYQjGeOQeyAczwLkF3hkzaJXCvyO/BTc/cvg8/xcPH5yoX1dwo3Si/p
 zznyVLNabYpMkCWQQp+yyIrRAmdHc0mZHen7tCrhDEnKSI1jUGoFrGY+FNWJ114pj2a79iron
 sxZkF57ZWyJ8hm/M4tLxTeDtL+TaynbJerF4o49DBuo8bS+57tEE/qAZb5x1Q9Y8VwJA9GcSw
 n8Mjr1AQb8RqvcL401AHAZ7O+HYlTPz3V49HmgUold81J+sgT3zdcvNwHOd91VFVpoL2+LmV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287174>

Hi Junio,

On Tue, 23 Feb 2016, Junio C Hamano wrote:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
> 
> > This allows repository browsers like GitHub to display the content of
> > the file nicely formatted.
> >
> > Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> > ---
> 
> To be honest, I have the most problem with this step in the whole
> series.
> 
> Markdown when rendered may be easier to read, but plain text is even
> easier, and it somehow feels backward to cater to those who browse
> at GitHub sacrificing those who use "less" in the source tree.

That assumes that the primary audience of the README file is the
developers who already decided to clone the repository, as opposed to
people browsing the README file in the browser to determine whether they
found the correct project, or to read up on the background of the project
without downloading the entire source code.

I'd wager real money (without scientific evidence. just going on common
sense) that your 'less' people are in the vast minority.

Since I am convinced that markdown'ed READMEs enhance the user experience
dramatically, Git for Windows has one already for a long time.

Hence *my* main objection: this patch series would conflict with patches
we carry in Git for Windows.

;-)

Ciao,
Dscho

P.S.: If it was not clear, my objection was meant as a joke. I am very
much in favor of enhancing the user experience via Matthieu's patches.
