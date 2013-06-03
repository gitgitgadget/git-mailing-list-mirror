From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: t4015 broken on pu
Date: Mon, 3 Jun 2013 21:07:48 +0200
Message-ID: <CALWbr2zVtECm0sZWPHXy005fuhnyvey3Nnqk1Ph73s1koczQOA@mail.gmail.com>
References: <51ACE819.3010704@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 03 21:07:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uja6k-000129-5X
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 21:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758078Ab3FCTHu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Jun 2013 15:07:50 -0400
Received: from mail-qe0-f53.google.com ([209.85.128.53]:63068 "EHLO
	mail-qe0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758097Ab3FCTHt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jun 2013 15:07:49 -0400
Received: by mail-qe0-f53.google.com with SMTP id 1so1177691qee.12
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 12:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=l2NXs6xbFRl6nmUG+5Os2mEU2U8D02DB0x0J85xwdMQ=;
        b=FTipP8dwiX7OBhScc9Mqcf3d4dX3nWVFffP2ep1rMCkNwvnXwJ3vDl79ILXENviYjR
         XA2nCR9BEuyyQ/AHm9tHBk8MBNqbj3e0QQ/2L7lhPeuFJ6s9lK7dlm2YX24PQBzNWp6B
         gDnGvqmUu86IZ1n/jVhyqqm2LdAEyClm27nx4ykf35S5tIe1anlD29wBDck/SF3D6zGj
         M83mZYbQsLS5ECJIe+FCOF74wOkjDjSflVnPL39tk2Ek9oMtciN8JkKZNETYQSRtmi3s
         UIsGQSEFVGLx8VzYhPg5GO40SP4qHKemT8E1jGgx8JzK6IwlfqG+aSdci04D15zjoPyc
         +YZw==
X-Received: by 10.49.128.7 with SMTP id nk7mr22957832qeb.35.1370286468918;
 Mon, 03 Jun 2013 12:07:48 -0700 (PDT)
Received: by 10.49.14.40 with HTTP; Mon, 3 Jun 2013 12:07:48 -0700 (PDT)
In-Reply-To: <51ACE819.3010704@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226268>

On Mon, Jun 3, 2013 at 9:01 PM, Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
> The new 4015 does not pass under Mac OS:
>
> a) The seq command, does not exits (we can use printf)

I was planning to reroll with test_seq instead of seq, as advised by
Johannes Sixt.

> b) One sed expression is not understood, sed exporst needed ;-)

Thanks, I will fix sed also in next reroll !
