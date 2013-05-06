From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 2/3] fast-export: improve speed by skipping blobs
Date: Mon, 6 May 2013 14:15:52 -0500
Message-ID: <CAMP44s3N53fHswhayqGehTJAP0huJqRup73jxYuiv7sVYUnN_g@mail.gmail.com>
References: <1367793534-8401-1-git-send-email-felipe.contreras@gmail.com>
	<1367793534-8401-3-git-send-email-felipe.contreras@gmail.com>
	<20130506123111.GB3809@sigill.intra.peff.net>
	<CAMP44s2rvu2PaazHEx-OXaZbuBAX7sZb04Oh38ifyAEG6kcxkw@mail.gmail.com>
	<20130506191146.GA3056@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 06 21:16:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZQtD-0006yz-R8
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 21:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755802Ab3EFTPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 15:15:55 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:33062 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755464Ab3EFTPy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 15:15:54 -0400
Received: by mail-la0-f53.google.com with SMTP id eo20so3573640lab.26
        for <git@vger.kernel.org>; Mon, 06 May 2013 12:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=1xa4KMXyLIghSsBfKins04b2bFtfmva0s+6B+Z2iWT8=;
        b=A2u734K0xtk4P4XEt4xxtXgw15+tVhREXsrEwKeJYoh7LezB3bV1Cafrj22I4gjJyW
         t61bX9FSY3BuXPCydaLRfsG8MjNh6eI2B+oht424padYQCdlAxbcJ+x1fBJu39kD5u9+
         MciulHRIQJnG6Ckf5a06p9zRiwiptkN+AmLLxDYTQUyOaRTm8wG6QiQT2lLA770N2srN
         PgOwocpaaAfR4bq3TyCLlV7kCqwF3jATTDgnK/VGTBPS5VaejZQFj4/tEJXZF5nAeuQK
         jbxok2vgbdkpH9AuL7NprKpRHB8FmWCwEEQrr/gWf9anuxjynvhK+YPLK6gcbv2D/nsq
         FR8Q==
X-Received: by 10.112.146.133 with SMTP id tc5mr8505125lbb.88.1367867752876;
 Mon, 06 May 2013 12:15:52 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Mon, 6 May 2013 12:15:52 -0700 (PDT)
In-Reply-To: <20130506191146.GA3056@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223487>

On Mon, May 6, 2013 at 2:11 PM, Jeff King <peff@peff.net> wrote:
> On Mon, May 06, 2013 at 02:02:13PM -0500, Felipe Contreras wrote:
>
>> > I did a double-take on reading this subject line and first paragraph,
>> > thinking "surely fast-export needs to actually output blobs?".
>>
>> If you think that, then you are not familiar with the code.
>>
>> --export-marks=<file>::
>> [...]
>
> My point was that nothing in the subject line nor that first paragraph
> (nor, for that matter, the entire commit message) says that we are
> talking about marks here.

s/$/ while loading marks/. Fixed.

-- 
Felipe Contreras
