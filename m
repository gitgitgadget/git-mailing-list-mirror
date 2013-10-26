From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC PATCH] During a shallow fetch, prevent sending over unneeded objects
Date: Sat, 26 Oct 2013 17:49:18 +0700
Message-ID: <CACsJy8DXH2verOjq670wzT+wkhQPZaqf68-rM91JJnVt2G=pBg@mail.gmail.com>
References: <20130711220127.GK10217@login.drsnuggles.stderr.nl>
 <CACsJy8CP6pGRwEn6H=cbKxTMuOjzAF3=Qh8qsLbJaw6feK3NMw@mail.gmail.com>
 <7vfvukbrqh.fsf@alter.siamese.dyndns.org> <CACsJy8BahoGcDcLjSaHA-62_KQE2wD-p5oeJOOA4nk8ZRfXrEA@mail.gmail.com>
 <20130812080203.GK10217@login.drsnuggles.stderr.nl> <CACsJy8CDGgKftp0iBB8MYjMawKhxZ1JQ+xAYb0itpaCOjFHWxg@mail.gmail.com>
 <20131021075139.GA15425@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Matthijs Kooijman <matthijs@stdin.nl>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Kai Hendry - Webconverger <hendry@webconverger.com>
X-From: git-owner@vger.kernel.org Sat Oct 26 12:49:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Va1RK-00042m-Ov
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 12:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467Ab3JZKtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Oct 2013 06:49:50 -0400
Received: from mail-qc0-f182.google.com ([209.85.216.182]:39197 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357Ab3JZKtt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Oct 2013 06:49:49 -0400
Received: by mail-qc0-f182.google.com with SMTP id n7so2857477qcx.27
        for <git@vger.kernel.org>; Sat, 26 Oct 2013 03:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=nQVzQFuVsaRt/be2209leCD461KnEaUH1fwaUHRdzAM=;
        b=zaG/pwr7PgmVgOt6/Vj7RKClKCw7qXQQjpTlsp3hO5fYwwpRrcgDIY05nbd+ujRVlZ
         H2u7NyTqgZmPaFhd7RCzvLCBkDvJhqnMR9Tx/boWlsyZetoP3qwMMjOGRVbjnlfTi6Sy
         3ouIoiAzMedEJjfQQG/mWSjksoJRP6eMJKL9JNCUIH3XMK1EQZSQLoyCBXcReQlqHt6T
         0dIdC2UhjlczF8hptcgJlHJzqXWl1udZ2YJC5IqqYJ+6iYXkBStoHUElHPxmZHITFFvx
         XaaBMsphbAKYS8vNeeRZojoA3thOz/qO3bqfdEhMi2ENkB0AB7P7chHO3t88JfJx/Hbc
         jyOA==
X-Received: by 10.229.47.71 with SMTP id m7mr16460759qcf.25.1382784588679;
 Sat, 26 Oct 2013 03:49:48 -0700 (PDT)
Received: by 10.96.27.202 with HTTP; Sat, 26 Oct 2013 03:49:18 -0700 (PDT)
In-Reply-To: <20131021075139.GA15425@login.drsnuggles.stderr.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236752>

On Mon, Oct 21, 2013 at 2:51 PM, Matthijs Kooijman <matthijs@stdin.nl> wrote:
> Hi Duy,
>
> I saw your patch series got accepted in git master a while back, great!
> Since I hope to be using the fixed behaviour soon, what was the plan for
> including it? Am I correct in thinking that git master will become 1.8.5
> in a while? Would this series perhaps be considered for backporting to
> 1.8.4.x?

I was waiting for Junio to answer this as I rarely run released
versions and do not care much about releases. I think normally master
will be cut for the next release (1.8.5?), maint branches have
backported bug fixes. I consider this an improvement rather than bug
fix. So my guess is it will not be back ported to 1.8.4.x.

>
> Gr.
>
> Matthijs
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
>
> iEYEARECAAYFAlJk3QsACgkQz0nQ5oovr7wVOwCgvQCmB4IJ6X86727/5Kslg83G
> A4UAoI8fBIXGnE1PwtwqFk/Od697dgNM
> =rjMT
> -----END PGP SIGNATURE-----
>



-- 
Duy
