From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mingw: introduce the 'core.hideDotFiles' setting
Date: Sat, 7 May 2016 08:01:43 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605070800060.2963@virtualbox>
References: <17d30bb680a0452efd7b3c4f42e2f94478a86273.1462372716.git.johannes.schindelin@gmx.de> <xmqqr3dhhcd7.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1605061658580.2963@virtualbox> <xmqqh9eb5eo0.fsf@gitster.mtv.corp.google.com>
 <xmqqwpn73y3v.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 07 08:02:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayvJj-0000Qq-8Y
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 08:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbcEGGCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2016 02:02:04 -0400
Received: from mout.gmx.net ([212.227.15.19]:56810 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738AbcEGGCD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2016 02:02:03 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0ML72n-1ayeKF18nB-000I0P; Sat, 07 May 2016 08:01:42
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqwpn73y3v.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:ZCcSCkACGWVP+h5zlTx9GT7zIqCi3AvdBtFDb7BnzVJygRXPUZO
 Cl4NPKHetSlnb5wA9PejMYJpTMfDl7kgz5MwomVt25wXfuYUj+TMpyX/ZN9Xr72cVg78vzc
 RuK37X6I2vjcWnS9niCNoqWzanRvCdBXVPK9oufVTlxwF/AEVt/kN9J7dVusINCxpKYV8CI
 /0H6UIhTALOmmsoanlPzw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PmJJH07/h0I=:TpmA3Ht3eCjfQRtiRWQz90
 xgBRKKzGyn9GIbIm6EesFGPJ7lh60qB9OyZg60A5LTJeZMjXNb4mlcCBs9wfqTnW+bvzFBgT4
 fx7ivArZpZ7e8T+AsNivZg7GTsV56UxiuI2f0+CmcsQMKZg5J0OUbRkOdsnu6TeQicfjZI96i
 Avhr1P4ZJCZiwycB8MLgg/ELTfKUZhThe0+k68YAGB8/kThWTA1MekFxPYL2iO9Us8/Uq0XIK
 cm6ipGxeni6xwcxyfhhmRo7GySdJdiaBzOiFtiHClChX2vBc7bmQ7q+POwf44khCHhO4R3d2T
 8ODFpbWt3AFff4sV1RYn9vNDRWj5KaYfMQGYWNqmaYOv9wzRk6IzRvIACfkk5AfWoFSNLUfg0
 dgTkCR2KFwYnsSX4nPw72d+nVza4HQ4TtW2/mj1LMn0+1trRmZHQsVCXtVHWSCk5dtUzfGpzP
 hhrGIiIhfLZjCxIuAw7UtvKVo/oe7UR1/+wBmSCWTME5cVa6CZVz8g1KcvfEljtAFNBqw11ZP
 AuB2fjq6nYmoHzusqqPoe13fUlyDvk8ibNLCnbm/Opdltkm/TcBFEQ+9Y1H+yn/Tdb3Mg2ek+
 xxru5pob5HnkMDcU+wL0GdJso97nKL2lmhLNiHNm7IcsmfiUoa/1vM5/ZLSHLFn8UWoHsZKI8
 ZAb2u3WIlsZKlk1uBSZwRK8Z+8th8nrl2umPSYmsPZFit6g5YOFhRe4fWcPnI9lKkkYmeca0V
 BM9cJE+VfxtNJEM/7UHdGRvJMua/DN9eduoy7BpbSJLz0Kat7/rTyMliEbgGLvafPHl82iQJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293874>

Hi Junio,

On Fri, 6 May 2016, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > If you are sure we do not need that, that is one less reason we
> > would be better off without mark_as_git_dir().
> 
> Oops.  To many rounds of rewriting followed by a rather careless
> final round of reading.  I couldn't decide between "That is one less
> reason why we need it" and "That is one more reason why we are
> better off without it".

Heh. For the record, I did understand what you meant the first time round.

Ciao,
Dscho
