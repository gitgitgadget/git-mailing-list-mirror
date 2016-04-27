From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Move test-* to t/helper/ subdirectory
Date: Wed, 27 Apr 2016 07:52:41 +0700
Message-ID: <CACsJy8A8vbp4-LrxoNX510Nme97EKfu0hBBs-LDRap1Z5=v3rA@mail.gmail.com>
References: <1460553762-12419-1-git-send-email-pclouds@gmail.com> <xmqqwpnkc9ca.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 02:53:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avDjC-00043Q-4v
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 02:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520AbcD0AxN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2016 20:53:13 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:34318 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310AbcD0AxN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2016 20:53:13 -0400
Received: by mail-lf0-f43.google.com with SMTP id j11so38412870lfb.1
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 17:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RNnTOd4+p1+ydLlv/gnFGvNomB8RyRpKpuG32W/OBfk=;
        b=GW9UEhTlpAic9pIIHdT2ZAbGXKfXqGm0AtbWNTbkxPCFZ8NzCY1w4vTxaNg06QvfjZ
         qm2BZKFnbJhEjZTtKMavBQ74rUkkzbXgieV0TxmtWhvZCqZSgoGpN9OwibkTd2PNQDyS
         FKZCEFyN7LoExj6dXi6ijCDPObe+3zdtqHpBp0ez9ZvaRjCyDLKEu2D5BU63eADLjHiy
         4k+I40ln22UXGs5kRvF/LLDOwo8bw7EpEyqJ3OwUZJmC9EahrTO7v3d9S81wG0wm4hGF
         lmDQP9G6kv9KjRqPXx78uQiytsBe7UxxczdEHwr75NKPotDLEXh1blL5og+rYIVOtIge
         FXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RNnTOd4+p1+ydLlv/gnFGvNomB8RyRpKpuG32W/OBfk=;
        b=mSOD5NuyPTv+vl2+kesd/tpfMcE1QZiFvv367kFD/6uDEnKlL+5H1aevzG36/Zpg2r
         dlbLjgp40mbNqfgL7VxSJEQlKQ9xHXBT0d3tPAd9FV1rBemTL1BcuENDX0YaQtf38e6z
         2PeJD6LxIZL1fbTzu8mq3QvX/dww1JafPRKW0b6oLYu4kbD0YXXfQihwJVV+9BpxOiNS
         QWx/gx5p5ORWtwEwEuSNxJonNvQV2q8Y2SdoIZLCsrZ4FRVgUOH7V0fwdx7Tpi8R+dAG
         djtVaMRyctnJIHUdi1m4v7eHR1BLBgDPfW2sWnkke/otIAgAXe72D1Sfb/UlHJiqAXV5
         vSxg==
X-Gm-Message-State: AOPr4FXNAYrAkV+HXvQrof8OYY/O/csImTVkva2Up2x2jLnQUQZtPK+OwZEEl//fh1JPg2qugeRzZ27jO1curg==
X-Received: by 10.25.17.99 with SMTP id g96mr2587037lfi.112.1461718391187;
 Tue, 26 Apr 2016 17:53:11 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Tue, 26 Apr 2016 17:52:41 -0700 (PDT)
In-Reply-To: <xmqqwpnkc9ca.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292699>

On Wed, Apr 27, 2016 at 5:07 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> This keeps top dir a bit less crowded. And because these programs ar=
e
>> for testing purposes, it makes sense that they stay somewhere in t/
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  This patch will break any patches that add new test programs.
>>  Luckily, none in 'next' or 'pu' does that. I know lmdb backend adds
>>  test-lmdb-backend, so a manual move and some .gitignore fixup is
>>  required there.
>
> Can you (or somebody else) double check that the resulting Makefile
> gets the build dependencies and exec path right?
>
> I am seeing occasional failure from t0040 when checking out between
> master and pu, and between the branches test-parse-options do change
> behaviour which explains the breakage.

I looked at "make -p" and saw nothing wrong with build rules. A bit
concerned about fa8fe28 (Makefile: do not allow gnu make to remove
test-*.o files - 2007-08-30) because make info pages say it could
leave probably broken .o files when make is interrupted. But that's
probably not it.

There is a problem moving between master and next/pu though.
bin-wrappers is not regenerated after the move so it could point to
the old binaries (in the other place). Not sure how to fix that
cleanly, will think of something, maybe, in about 8 hours.
--=20
Duy
