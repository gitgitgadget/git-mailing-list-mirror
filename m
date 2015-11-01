From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH v4] checkout: add --progress option
Date: Sun, 1 Nov 2015 14:26:58 -0600
Message-ID: <CAOc6etauvMjzjYxA2C7TVaHMnygYa3VNCeLzyPiesZH5CcqgcA@mail.gmail.com>
References: <1446400076-9983-1-git-send-email-eantoranz@gmail.com>
	<CAPig+cSLC_xkpXEznzPQdA=FE6GV5VSuwSrFy62Nzybv7jQf1g@mail.gmail.com>
	<20151101191902.GA19594@sigill.intra.peff.net>
	<CAPig+cQvsXMqAzV_59sZdqDEh_SRfOMh+BY3XLmzSPdfWwugdg@mail.gmail.com>
	<CAOc6etb24owGX1KD9b-eYt5TtTKzEzinvnJ-81ev5QK_tKgLPQ@mail.gmail.com>
	<CAPig+cT-Mbf0cs+5OpPv+za=yrjiqycG5EtZONSrZwy8xL5pSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 21:27:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZszDT-0001Am-8u
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 21:27:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970AbbKAU07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 15:26:59 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33344 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824AbbKAU06 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 15:26:58 -0500
Received: by pabfh17 with SMTP id fh17so1507680pab.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 12:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pWWNVhFN9nsSlGcijkaxds3gqz8IZaKQdwXkPAsHONM=;
        b=pwRwJ474ZoXp1sEMdvjVSB2vqIafzxpCjIhI70+Nh5Ynmg681KS8dUGWxYt3RgfV0h
         SVQUKrc5+NPRugMD78PSOE32siIsNUl6ZsVxEWgZguVxawalOv2IXT6RRXvxuJ16/pbV
         LrB1ImafIAsfn5s6pqHfk2b/Jg4fimbAfcPE09X6YK2DJPTthRQ2Ed+JEwVdBUpZFtcf
         sukMNrKKu7TUZ5K0R+lg70IAoWJvPO/4PA+y2PsLXybxLT57Ls0pSSZjFoiaHqMO1GTW
         E16dRvqVyhiegerw77nDmEe8TyCm/BQduhWxgdSzcd8OP7/lKb6IF+XimSTOX3zx6s81
         9lbw==
X-Received: by 10.68.88.165 with SMTP id bh5mr22859881pbb.160.1446409618332;
 Sun, 01 Nov 2015 12:26:58 -0800 (PST)
Received: by 10.66.97.70 with HTTP; Sun, 1 Nov 2015 12:26:58 -0800 (PST)
In-Reply-To: <CAPig+cT-Mbf0cs+5OpPv+za=yrjiqycG5EtZONSrZwy8xL5pSA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280665>

On Sun, Nov 1, 2015 at 2:15 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
>     Progress status is reported on the standard error stream by
>     default when it is attached to a terminal, unless `--quiet` is
>     specified. This flag enables progress reporting even if not
>     attached to a terminal, regardless of `--quiet`.

Sounds good to me.

Sending another full patch.
