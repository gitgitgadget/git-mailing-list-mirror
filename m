From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 00/83] libify apply and use lib in am
Date: Mon, 25 Apr 2016 17:09:51 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604251708370.2896@virtualbox>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org> <571CE4D5.8010403@ramsayjones.plus.com> <CAP8UFD0dEYPSku8w=7ehJFFgtNFO8EbUc4RDn+KRdrYG3-=Rxg@mail.gmail.com> <CAP8UFD0rKNAoZgCPQkfo_qd7b_V4rOtLqBvQ-XQoeT6OnZidGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 17:10:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aui9W-0001ni-AV
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 17:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754827AbcDYPKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 11:10:15 -0400
Received: from mout.gmx.net ([212.227.15.18]:56203 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751750AbcDYPKN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 11:10:13 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LoE4f-1bNiFE46NF-00gELN; Mon, 25 Apr 2016 17:09:54
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAP8UFD0rKNAoZgCPQkfo_qd7b_V4rOtLqBvQ-XQoeT6OnZidGw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:gJA/eyx9BAuA0iYqMclEG5M1Iy2xIlONc8yd3hdbtPvblTfb1Nm
 RwPcgg4tU3c9hax+kHDwnqgcpOdieiL8OLoyILtUT+J5/2ZmNpBZkOvI6TIUPHYKwb5kLWV
 dJd+ITKrexBRLUQs5Dkme1rJkEaiVGedg7DXBcY4meW6jDIyYP8QQkKyO0h7OHdLOHp0VoC
 407anmNNXkgL3TF/Q3Duw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gCBTGdlGvOw=:PVuUaoSFF70QuFR3pNcsQT
 sA29nem+xZocUlW2b1u90KJB/76EjUL57pZaO5ShxYcF9uktN+InLA12XH3PoqmcHz9m7tlO5
 2MLJKxo/rwK6qvRn37pU4uB8x12m1phNYWlAqCfE2j4faqNRYO6ykuA15hfSJdQ+viCP2zHFD
 xqvEdyHt96YsSmqh9qFZyc0bdakSRQP8ug1KAGCqeM8QUksmczv4MkIS2yfmOM1JxWtT9Vevb
 RzYvrZFDhbpBZieD62uovJBRMnaAZDEMqnkRbgDaOUK5+UqIIu+b7JbX8RrX7ug2tb0ET9RBA
 5pnyKzJcQG81lopmfVjadcnhrZ367dCYH+6n3J1RCGWXAUnebMQBxXEJqEp/ZduSHJunYUWqK
 5YmBqgIYBLEjV/ZD8JOzVMTP4tGPvqvoMgD1UCUTvkeYQY8uIztY5fs7RGT328OgIw9zGhklg
 WtuQQ5mzHNTkDdt9Vuw/RDKqD+C42lWsxqIpQTsRvdZeKfy58h/6U7ofo6Z5lx/2Y1gEfwsZl
 REyeyNo2atoMOFPPqdwx5LHDx6Oy1zt0GsokIrVkVIyWMLZEWcPX7OkRexPvx3J8EuoXFC0+U
 zZVcSxzvdLbDhsBxX8Kwzhd6rDJHOqV9f3ahJjWEyHQAkNbr0OS+xU9aNg9x/LBsKZ/8kG6s6
 ELMJ259EoQl1N8kyw2twc1RUhbuMGVweXCAAHVE4QPIDwKcZNH7ymMr2SBJO+YnV8X+lcJfI4
 B1+8SicHlFE8vbzuiRnS+oWv7ip7YfR/XYk0/QRpmH8P755Wh35fYBnCNfZ9RPFPEd9d8ijn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292489>

Hi Chris,

On Sun, 24 Apr 2016, Christian Couder wrote:

> On Sun, Apr 24, 2016 at 6:27 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
> > On Sun, Apr 24, 2016 at 5:23 PM, Ramsay Jones
> > <ramsay@ramsayjones.plus.com> wrote:
> >>
> >>
> >> On 24/04/16 14:33, Christian Couder wrote:
> >>> This is a patch series about libifying `git apply` functionality, and
> >>> using this libified functionality in `git am`, so that no 'git apply'
> >>> process is spawn anymore. This makes `git am` significantly faster, so
> >>> `git rebase`, when it uses the am backend, is also significantly
> >>> faster.
> >>
> >> I just tried to git-am these patches, but patch #78 did not make it
> >> to the list.
> >
> > That's strange because gmail tells me it has been sent, and it made it
> > to chriscool@tuxfamily.org.
> 
> Instead of waiting for the patch to appear on the list, you might want
> to use branch libify-apply-use-in-am25 in my GitHub repo:
> 
> https://github.com/chriscool/git/commits/libify-apply-use-in-am25

Thanks for this. In particular with longer patch series, I find mail-based
patch submissions *really* cumbersome, not only on the submitter's side
but also on the consumers' side.

I wonder, however, why you use numbers in the branch name to version
things? I thought Git allowed for more advanced versioning than that...

:-)

Ciao,
Dscho
