From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Turn git-rebase--*.sh to external helpers
Date: Wed, 17 Feb 2016 15:22:55 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602171513140.6516@virtualbox>
References: <vpqio1nsk0q.fsf@anie.imag.fr> <1455716201-29784-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-106061232-1455718976=:6516"
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	sbeller@google.com, peff@peff.net, christian.couder@gmail.com
To: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 15:23:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW30Y-0003Ix-81
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 15:23:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbcBQOXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 09:23:06 -0500
Received: from mout.gmx.net ([212.227.17.22]:55737 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030267AbcBQOXD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 09:23:03 -0500
Received: from virtualbox ([37.24.143.97]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Mhej1-1aJl3L3tVD-00MtPS; Wed, 17 Feb 2016 15:22:57
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1455716201-29784-1-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:CfDgsGD3kgNCrvog6B6AWCm9lYpVevxGie8sGyuFgzHZnEGkGIY
 6iuWREGqmdNf8nrp9ErCLoHYhGHhov2VPn8Myk8K+JfGI16UuLqudXtBckg+x4/KVo5W1id
 sDIRf+bQ/lhK6lGeS7CG6pPiVmNVN+jQBqvQIUpHwJ5O+mkvlBKV46SW9ZVG6pP8Iao6DBR
 P0x42desam3Zwaxi5/tkg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:p4BaJpg1xVc=:Fx6TDpkG2E9i9AaO87cVZF
 qWf9xtsXTf5uI9WG9wHJwiTyLqyleBblSSaKKMRpTPiIIE+MhaxPHgfasJyBUUkOf8v1oZjKR
 beLwuNdZ/ghXaODM1FC6kIRtdLr81JFRIbpT77dPEvCz0Nygh99MhmdKX6S+pQjcNQoLB/Dpd
 dGSPXrVxQa07PlzkGXMJJbZ2DENJXNt62ydiXmTlas7uKHK+7I7tB4GdqLyOr4nQ1y8as8gIW
 Ut0/7JWw6/awncJAskkMZTy7JdSDvtwHfIf16oRSZHaqO6Sv9zonkEbmoHGnTT2ysPqEF2aCs
 DMC+mhWmMF0oYjg4GMp0jyoDizPNrxFp9KZme/tOxFQe3Wya1QiXu7T6t6ArF5eg+GUC9hBx/
 m/KxTnoddpdMTtKNWTARC8VlDNnOv1xudVf+aWUs4l1FYmj81RTBegvhnVrL/vxpi/9JxuK3h
 QqEH/jCJUlQFw2ESfrMmryeMEJXz/A2F0SO0r9TMh9YVmdtLjWZLF37KYy1ispNMyDLD9EbhV
 JDTyFt4lKxgz7wzosTBN9Z19gEwtwxqWoT5Ux0v+KjnRH3Y55p5Q35DcsG3uKAnBNdP2Jcyju
 tXKR/md4tFXvnbTcuyc/bpgCvi2+7vV1qrDCsJL/o+HuCfJpwk7pgX3h9cljlQF+xAhmcjLVL
 NFfxQ9R9olDu6L4vM7DiQsKuoKgtTyOBczYRvY9XiUPNWT+96SbS8rthmaLNiMekQL8fhD499
 bOuA2Yk/RW4qriIPYbeQVFcJLXU4NbGZuqPl6yE7Cqj+S/C45TWUFWFh4TVURU6IDrzKkI4y 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286505>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-106061232-1455718976=:6516
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Wed, 17 Feb 2016, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> We do want to turn all these scripts to C in the end, regardless if the
> conversion is part of any GSoC. So I dug up my code and prepared this.
> Now we need people to convert any git-rebase*.sh to C :)

While I would love to see all these scripts to be converted to builtins, I
think that the proposed path would be too painful.

I already started a different route locally (nothing to show yet, mostly
because I have to write emails and try to triage the bug tracker instead
of doing real work *grmbl*): add a rebase--helper and off-load heavy-duty
work from the scripts to that helper.

There are major benefits to do it that way:

- we can focus on the really rewarding parts first, i.e. the parts that
  make the interactive rebase so painfully slow,

- it allows for a painlessly incremental conversion,

- if multiple people are interested in working on the conversion, it can
  happen in parallel.

And probably a few other upsides.

Will keep you posted when I have something to show,
Dscho
--8323329-106061232-1455718976=:6516--
