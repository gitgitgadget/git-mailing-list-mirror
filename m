From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] clone: add `--seed` shorthand
Date: Thu, 21 May 2015 18:05:31 +0200
Organization: gmx
Message-ID: <8895881cd3f324d2b8a827e311296a48@www.dscho.org>
References: <20150521041435.GA18978@peff.net>
 <20150521041619.GC5196@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 21 18:06:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvSzF-0007xp-4L
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 18:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757195AbbEUQGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 12:06:16 -0400
Received: from mout.gmx.net ([212.227.17.20]:49852 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757148AbbEUQFn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 12:05:43 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MYcJi-1Yhpqp2BYQ-00VT3s; Thu, 21 May 2015 18:05:33
 +0200
In-Reply-To: <20150521041619.GC5196@peff.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:IoI5bRz6cJLGDp9YxblsQdXCn4xUbAJ711S7YPop6vrOAGQksey
 grLFj3joWsJG/TnFmNkU8yAyNWVce6rgBvG2tsYOEuTJdZ+R2vk/VV9iR1IADEWSs07d3hQ
 zBiROfClTpxEM/jK/BDyHroBb5lPzeMej/JxAqavg4i88WLmmuF1yAL/lhT41UtChhd3cHG
 l9QhvDI9R/1U/T1Hisk1g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269602>

Hi Peff,

On 2015-05-21 06:16, Jeff King wrote:

> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index f1f2a3f..ffeb03b 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -107,6 +107,9 @@ objects from the source repository into a pack in
> the cloned repository.
>  	transfer and stop borrowing from them after a clone is made
>  	by making necessary local copies of borrowed objects.
>  
> +--seed <repository>::
> +	A convenient shorthand for `--dissociate --reference=<repository>`.
> +

Since you want to advertise this as an easier way than `--dissociate --reference=<repository>`, it might make sense to avoid sending the reader that way, too.

Maybe something like

--seed <repository>::
    Fetch objects from <repository> instead of the clone URL when possible. This is useful when a (possibly partial) clone already exists locally, to avoid transferring the same objects again.

Ciao,
Dscho
