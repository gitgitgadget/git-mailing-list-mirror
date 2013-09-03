From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/4] t: rev-parse-parents: avoid yoda conditions
Date: Tue, 3 Sep 2013 16:52:19 -0500
Message-ID: <CAMP44s0zRZDGwd6KcVi81JEDQv38THCJctA8zUZiYht-uqY4vA@mail.gmail.com>
References: <1378103439-3225-1-git-send-email-felipe.contreras@gmail.com>
	<1378103439-3225-4-git-send-email-felipe.contreras@gmail.com>
	<20130903071256.GD3608@sigill.intra.peff.net>
	<20130903075107.GA25540@goldbirke>
	<20130903080358.GA30158@sigill.intra.peff.net>
	<CAMP44s112mwgs=8n0XCnTtPM2V-O5RYE2ns+fjCvgkxj+kEY8Q@mail.gmail.com>
	<20130903111006.GJ29840@goldbirke>
	<CAMP44s349-v6xtCvbDzycVj1wBwTdAgLmuGxB0pYn6CmHYkM1Q@mail.gmail.com>
	<xmqq8uzdu817.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 23:52:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGyWQ-0008Kw-HX
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 23:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760504Ab3ICVwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 17:52:22 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:53585 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760223Ab3ICVwV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 17:52:21 -0400
Received: by mail-lb0-f181.google.com with SMTP id u14so5586709lbd.12
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 14:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2CBGqRClDAf7BShJnbckFs58YedUfyiy00TdaU7tSms=;
        b=HBM85qlZ3A1cKHJ7UOUqXit2fcPqIJjmwbjjkFkQRBGhCtq6XMjdGzuoZU46lh2fnc
         XGdFGC+aEKx45/Hnl/bWHAZU5sLlHv/PkuEYA1482/7NDY5iUqi7uGastwpq9lGV5nK/
         xM7owyoLbNu9RPr+gjh5n1fUfiGTVbsRUNwVeytReq/iMA0u4Wv1oi9DquurF2zHFXxa
         1YFS64BnncsHP+JNm95/YVRH87rwSdL+H5K49iQDAAmZqM+hRhhjqIx0JsQhvtXj8xmk
         GDZafl/w75OJ04bKgiC+DzrOi2HectA8wKY5G45HbWGyDUdR7qfoOke0gU5aZCkATvJK
         H9bQ==
X-Received: by 10.112.64.36 with SMTP id l4mr15356002lbs.15.1378245139172;
 Tue, 03 Sep 2013 14:52:19 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Tue, 3 Sep 2013 14:52:19 -0700 (PDT)
In-Reply-To: <xmqq8uzdu817.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233785>

On Tue, Sep 3, 2013 at 12:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> There are two ways to fix an inconsistency, the other way is to fix
>> test_cmp. But that would be a change, and change is not welcome in
>> Git.
>
> If you want to do "test_cmp $actual $expect", you would have to
> first "fix" people's expectation that "diff A B" produces a change
> necessary to bring A to B, which would not likely to happen.  We do
> the 'test_cmp expect actual' for a reason.

No, you just do "diff B A".

-- 
Felipe Contreras
