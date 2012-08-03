From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH] tests: Introduce test_seq
Date: Fri, 3 Aug 2012 22:12:03 +0200
Message-ID: <20120803221203.37e854d1@gmail.com>
References: <20120803160229.GA13094@sigill.intra.peff.net>
	<1344024290-9197-1-git-send-email-michal.kiedrowicz@gmail.com>
	<20120803200718.GA10648@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 03 22:12:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxOEK-0002vs-Gg
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 22:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753799Ab2HCUML convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Aug 2012 16:12:11 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35349 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753604Ab2HCUMK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Aug 2012 16:12:10 -0400
Received: by wibhr14 with SMTP id hr14so998765wib.1
        for <git@vger.kernel.org>; Fri, 03 Aug 2012 13:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=697rycmj5iGtPnFQHAB2bcRffYeDnAspva2p0lsrgDE=;
        b=BDEvKJ9xbKTcKOO1fSfQ3k9YNWE/WhXFWS4Q02OsitZwJImTE4PIAqY9ps/YeQYqh4
         FoA6YhvMS+5OrWy8F1zNpT988eA8151ciC08jKcxw8HYreSV5mPZ0F3EGy3dva1YZy/4
         82lAJqYj1/HPr/zPIG0+qBXiz4Cc61uZTzmzaqBhFiypmbDgeEh65HXxFBekAwz9lBL4
         wESp9jO07Mg3U0YnzYXX1b4yIs7ofOIYjmhI+GbJ2yluYJHZ+dbT4+QB2/kV9L0s0xLT
         2bnSQsPzSi0UTqj/gRxOccjsP/+UudNjTOPHHzSyU0HVqfqUBl88QK5YaNOn1ec8BW0B
         E05Q==
Received: by 10.216.116.70 with SMTP id f48mr1397261weh.162.1344024729578;
        Fri, 03 Aug 2012 13:12:09 -0700 (PDT)
Received: from localhost (94-178-78-94.net.stream.pl. [94.78.178.94])
        by mx.google.com with ESMTPS id w7sm41374973wiz.0.2012.08.03.13.12.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Aug 2012 13:12:08 -0700 (PDT)
In-Reply-To: <20120803200718.GA10648@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202858>

Jeff King <peff@peff.net> wrote:

> On Fri, Aug 03, 2012 at 10:04:50PM +0200, Micha=C5=82 Kiedrowicz wrot=
e:
>=20
> > Previous patch didn't support `test_seq 1 50` (I removed it acciden=
tally).
>=20
> Our emails just crossed paths. :)

Yeah :)

>=20
> > +# test_seq is a portable replacement for seq(1).
> > +# It may be used like:
> > +#
> > +#	for i in `test_seq 100`; do
> > +#		echo $i
> > +#	done
>=20
> This should probably note that it is a subset of seq's behavior. You
> talked about it in the commit message, but the in-code comment is a m=
uch
> more likely thing for a potential user to read.
>=20
> -Peff

OK, I'll quote parameters and add a note.
