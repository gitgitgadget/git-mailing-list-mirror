From: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH v2 4/8] gitweb: Use print_diff_chunk() for both
 side-by-side and inline diffs
Date: Fri, 30 Mar 2012 15:37:10 +0200
Message-ID: <20120330153710.3a165beb@mkiedrowicz.ivo.pl>
References: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com>
	<201203281756.42653.jnareb@gmail.com>
	<20120329193152.3d0f27e2@gmail.com>
	<201203301534.35484.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 15:37:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDc1C-0000o9-5u
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 15:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933740Ab2C3Nh0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Mar 2012 09:37:26 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44286 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933689Ab2C3NhZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Mar 2012 09:37:25 -0400
Received: by bkcik5 with SMTP id ik5so571441bkc.19
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 06:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=Eq1X+pfPt+UbnkOIpMLKodNXpUNyjDRvd4ak3iEUvXc=;
        b=qtqBexfLbwkGfzAI6AbFUOtY969iUg9MAs4EPcRo3m0tOXP4aMKBYN08RVyt10SWSI
         CDJcJUNNrM7NMaEhcxv4ij1/epK81/trIzq9mXdQ3pnyy6fIf0Ligfz4mRSqPy3oDmJd
         JjUCGMXIzjRirIdTkpEcNNSht3R3+mgWaxtTvpn8ALitZ2b3vFofD6dAaOxO/a2k2zZA
         P1+s6FZS1iK74cVTqNydWLizLTBKKhiw2OUzTGnjgBcMdlhT7Q16TFCxX8BmO0UQGz6f
         4jlfPY37oH7SNOVQtIq7/zc+Lrs9w5ArN0Tty1wjQOH2EEuxow80ufCN6BIVqaRYukDl
         6pmA==
Received: by 10.204.153.215 with SMTP id l23mr1013147bkw.11.1333114644090;
        Fri, 30 Mar 2012 06:37:24 -0700 (PDT)
Received: from mkiedrowicz.ivo.pl (pc10.ivo.park.gdynia.pl. [153.19.128.10])
        by mx.google.com with ESMTPS id t17sm20812607bke.6.2012.03.30.06.37.22
        (version=SSLv3 cipher=OTHER);
        Fri, 30 Mar 2012 06:37:23 -0700 (PDT)
In-Reply-To: <201203301534.35484.jnareb@gmail.com>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> wrote:

> On Thu, 29 Mar 2012, Micha=C5=82 Kiedrowicz wrote:
> > Jakub Narebski <jnareb@gmail.com> wrote:
>=20
> > > BTW. I was wondering about binary files, but this commit wouldn't
> > > make it worse anyway as we parse diff output assuming
> > > unified-like diff for diff syntax highlighting... and binary
> > > diffs are shown as
> > >=20
> > >   "Binary files a/foo.png and b/foo.png differ"
> > >=20
> > > in extended diff header.
> >=20
> > Yeah, this is what I wrote in the cover letter:
> >=20
> > 	* Ensured that binary patches are not supported in HTML
> > format, thus this series canot break it :) (answering Jakub's
> > questions)
> >=20
> > but maybe I wasn't clear enough.
>=20
> Eh, sorry, this was more of reminder to myself, rather than
> questioning you if you really checked that.  Sorry for that.=20
>=20

OK, no problem.  Thanks for your very thorough review.
