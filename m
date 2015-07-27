From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Indenting lines starting with "die" in shell after "||"
Date: Mon, 27 Jul 2015 12:25:35 +0200
Organization: gmx
Message-ID: <847c822062707efaf2171b5568e00e45@www.dscho.org>
References: <CAP8UFD3UmrmREa8hN=jGNM8FMc3XHOyX9hGjfRDej_qMrNsaXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 12:25:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJfbK-0001hW-26
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 12:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258AbbG0KZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 06:25:38 -0400
Received: from mout.gmx.net ([212.227.15.18]:58439 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071AbbG0KZh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 06:25:37 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MNIAz-1ZHlmY2c6T-006tBt; Mon, 27 Jul 2015 12:25:35
 +0200
In-Reply-To: <CAP8UFD3UmrmREa8hN=jGNM8FMc3XHOyX9hGjfRDej_qMrNsaXw@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:88w1zCWkLOvK86hQcxQ+vKepHph827cUiEhdJ5klrE3fB9aYa6+
 Uh5Na+OIcJhR/HMmcvqhLMs8rDk1khuyQc+gqrZfQg1bOmH16Nsc/1xaVa8Z0Bi1tEf6tze
 pcB0U8PeUoXV7SrHzbBvpdOKHzZAwi+I6M+4c9qbPC/Bjvos25UxBKsRzXPEzF2GUECO3Pf
 roJ7q/uyjUH8eMWY8Ty3g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NMKltmgweZA=:cYYJQxKdQXqs/B5eKrrF0b
 2TOXtwJzxedhxriKqOODt/pGDP/xDuhvolLKPHYfNIX8pgZ/nfxBDsbHuwxjbjn65C24Wjdxu
 SY+ZfpDiMHiNqGZX+oZQQmXp8Y7pLNeqeupyVZdB4EnD2ziLWfa3L99ebj9G5DR+VuY6d6SYP
 o9ptrB7XaUvOiI9giV5DBm+wwkChJR+OWLay/Tm0XoW7BGMPEnW9+ncguHVbK7vuFnHIn7MwB
 2qPTr6gNSYhzy1bd88rXu0T27S/GIqyolRDWCkUzQFZEjd5WwZRGzCVXVO4kuvrC7jC9VGvVG
 6SUwhCjL2XBlS+8fPPlvN3xqvPrxsVgAPIp1XFZQCKQOkOaLmm8MWAzDKOYqFZ/l51szwbvUz
 zmX/+rHRcih8ONFEctx1Xk/EONN0gQLYZI3uNA30R7XxX8+OQOWj1tj+PtcfAn+6RfGe7eK9N
 gf+3tn0xUnWoPpXlxY5jW/qf+8o7M2H2Bj3we1bqWvtlZS5Fs94nC5bzoII9ymvJU+RKplTdi
 BV7aa/ClfbHE5NkJnp8Wv6roDks5G8wmmDZeHURRAWV2E40KDOKkeY/jwMdPfc7gwezgIS+Sc
 nUugk2Bm4Re2JeObagnHjgfFuO3oalVqsOZg6QGbopPihhJmgCUaKI8DJiicj239G8Drl0d7w
 GeuarEujA8fScado8Oja1lwzLHsBSMfgoABp41kHp/fE/9laOzcx5+4BIIDcix9r0jjQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274667>

Hi Christian,

On 2015-07-27 11:20, Christian Couder wrote:

> It looks like we are very inconsistent in shell scripts about
> indenting lines starting with "die" after a line that ends with "||",
> like:
> 
> quite long command ||
> die "command failed"
> 
> For example in git-rebase--interactive.sh, there is often, but not
> always, an extra tab before the die.

That is most likely my fault: I used to add that extra tab. It appears to me as if the convention in Git (and in my current coding style) is not to add an extra tab.

Ciao,
Dscho
