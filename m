From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 19/19] mingw: do not bother to test funny file names
Date: Wed, 27 Jan 2016 09:33:40 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601270859470.2964@virtualbox>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <cover.1453818789.git.johannes.schindelin@gmx.de> <47914e4ceb3ea51636dd5ae308679c9c92fcbef0.1453818790.git.johannes.schindelin@gmx.de>
 <CAPig+cQXVwfyaEzf9fR2tFNon-Jq93iPCMwW9gsB8BnUVv5p3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 09:34:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOLYi-0006kT-3Z
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 09:34:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbcA0Idy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 03:33:54 -0500
Received: from mout.gmx.net ([212.227.17.20]:62765 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751304AbcA0Idw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 03:33:52 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LeNGL-1ZjqrC0es9-00q9ql; Wed, 27 Jan 2016 09:33:43
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAPig+cQXVwfyaEzf9fR2tFNon-Jq93iPCMwW9gsB8BnUVv5p3A@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:EK9qdgPQ9Yndav3JzybTX51jOLK8LTvVJLNZZpgAOCGPVXLzlRv
 K+mIao7GNv6E4KE9Hqr0xol5GQRLsnWbkNNNv+gOcxF2e0irRW1FHORKHVKHduHOqmP+ePg
 1vKK/qVz2ACiMokm9HTq+aHw9qOFbtADm5Kdgb+oQ4BBRK+IN4T+qIymKM8BOQvGAiERnbe
 M2QR/VGsobPMFU2223q0Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ap5QQNcA0H0=:WXohwREibuod8Ii3vH9X1B
 kw5lFi3i1LqXhqOsggetHdhxQLPgpVLp+fbkMCyoThxCZzw5GY4VChR2+OusmS08wUQmGFnNK
 G96LAJ6FOYbCS59sEn0zGQ+xR7ynBRAIlUFfPlRK4M2Och+K6v20gj5eMU37sgs2hZcXDxCMK
 dPID+DhB8J1lBRITbiXLaXobh919WPzM/SLS4zsf1P/MoebDzhFqYDT/FiVm+eYj9GMOnWBHs
 9i1SAzBaQh/xhJfI2CxZOLQplU3ZWdy9P6hBYL2RLMch7Wwa434xyuOu22xNocZzu5T432rqj
 mWAYMbRCAKSvIWvFjVqkREupjKkXq5G5pgpyaXRub93BoSxiBhw7KYhyKuNNt9LJkfzPkRFLW
 JziQwA/CEoQSdOSj8MNTMf0x53Iq/H0aQLWmaW47giI4P/P7LdtU9PnwsDzK9hwsx5xWm71tS
 8ypoShEaUiKZKDvzLsoI4JmVsmUIQpGgYyb0DTnlxtY6D4woy3AtS6QgMC6hYhaWGMkzSqtzs
 cxEzZ/5F3ExKdzMeuo76DAJRod8s+v9rB4Dg6/VNsqsO61xDLlJEtmzc+NLFQ1HhftBv2c9Lu
 CdxeujE4KJB8lWFyJnECnP03noO2BVNScVMQMemKyCNbNxh0JpSTQoFA1IJc4A8uvKXP/cdI/
 /n+BOXpcdBjY8cHXcxJdHWIz1sgMGset+VUlX9G1ySQ8CejajB2UJqUVBhrlQEEXWEsM64ids
 sGNZ3Kwkfypfm9El/ZS569J4FUiZQ6thJ/r5vEbI5GsxdMvu2zF4iX1H8Gq/lA1gx2NyUDi4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284894>

Hi Eric,

On Tue, 26 Jan 2016, Eric Sunshine wrote:

> On Tue, Jan 26, 2016 at 9:35 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > MSYS2 actually allows to create files or directories whose names contain
> > tabs, newlines or colors, even if plain Win32 API cannot access them.
> > As we are using an MSYS2 bash to run the tests, such files or
> > directories are created successfully, but Git itself has no chance to
> > work with them because it is a regular Windows program, hence limited by
> > the Win32 API.
> > [...]
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
> > @@ -14,7 +14,8 @@ test_expect_success \
> > -if touch -- 'tab       embedded' 'newline
> > +
> 
> Is this new blank line intentional?

Absolutely not! ;-) Fixed.

> > +if ! test_have_prereq MINGW && touch -- 'tab   embedded' 'newline
> > [...]
> > +test_have_prereq !MINGW &&
> 
> Where negation is concerned, is there a non-obvious reason that this
> patch sometimes says:
> 
>     ! test_have_prereq MINGW
> 
> and sometimes:
> 
>     test_have_prereq !MINGW
> 
> ? Is one form preferred over the other?

Hysterical raisins. I changed all of them to the latter form, as suggested
by Junio.

Ciao,
Dscho
