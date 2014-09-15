From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git merge --abort deletes unstaged files
Date: Mon, 15 Sep 2014 15:02:24 -0700
Message-ID: <CAPc5daW5XejS7JFmQagOwgqSxS=subdJyCbM3JL2fa=4RmYsEg@mail.gmail.com>
References: <04af01cfd0fb$d077e200$7167a600$@webkr.de> <87k354x0qt.fsf@igel.home>
 <xmqq61go65zu.fsf@gitster.dls.corp.google.com> <87iokolfc9.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?QW5kcsOpIEjDpG5zZWw=?= <andre@webkr.de>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Sep 16 00:02:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTeMF-0005kK-Eo
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 00:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754933AbaIOWCr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Sep 2014 18:02:47 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:50960 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831AbaIOWCq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Sep 2014 18:02:46 -0400
Received: by mail-lb0-f171.google.com with SMTP id 10so5372555lbg.2
        for <git@vger.kernel.org>; Mon, 15 Sep 2014 15:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=tpd2cl7ShPpouZ+PQrBm52AXrDpidkXFeLip2JwEte4=;
        b=O9JQXP1HbkjVKagXy13xMsV2XhmvCkjo+TdjEMsQq5/wtaTqmIo4/u4hQj3vo7pUFa
         yLgOl/yrMHhgdZAq85zjOPb0T+Sqi8MjalfRQCW7ZyIjBKtPOP3kyJsmgY3WafHjG4yk
         5rQ5FLpEgzbSxsmsi60phrbGSVzX/LQWOaDFNIi79Tmb+pPaKM2LgZ5REQd8H32ftV6k
         dlIUtBrGyZ5O/dgzGKfDHxUw9zIxHEOSfRHcIge7dhIsQuY+PAAIZ0ul9fLODlRCkZnF
         S1+wFn9sgj4PVDoVY2198LBao+w3k/Q3Ul3Y26it3NjE8JwYRwiUoDHhUOi18hIO/3de
         3LYA==
X-Received: by 10.112.54.135 with SMTP id j7mr29460035lbp.51.1410818564843;
 Mon, 15 Sep 2014 15:02:44 -0700 (PDT)
Received: by 10.112.97.177 with HTTP; Mon, 15 Sep 2014 15:02:24 -0700 (PDT)
In-Reply-To: <87iokolfc9.fsf@igel.home>
X-Google-Sender-Auth: Y46Bp5QzA10VklB51sdU_KJZlh0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257086>

On Mon, Sep 15, 2014 at 2:54 PM, Andreas Schwab <schwab@linux-m68k.org>=
 wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Andreas Schwab <schwab@linux-m68k.org> writes:
>>
>>> Andr=C3=A9 H=C3=A4nsel <andre@webkr.de> writes:
>>>
>>>> I ran git merge to merge a branch. There were some conflicted file=
s.
>>>> Although they were automatically resolved by git rerere, I still h=
ad to add
>>>> them.
>>>
>>> If you want them to be added automatically, set rerere.autoupdate=3D=
true.
>>
>> I would have to caution against doing so without thinking, though.
>> In other words, it is OK if you are Andreas who knows what he is
>> doing, but it is not a very good advice to give to random newbies.
>
> If you are used to doing "git add ." afterwards it can't be much wors=
e.

The right response to such a user would be to teach "add -u", or better=
 yet
to teach to use "add" on individual files as they are examined, no?
