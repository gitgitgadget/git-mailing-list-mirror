From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Mon, 9 Sep 2013 04:41:24 +0530
Message-ID: <CALkWK0m3ZQLkHU4sJntkeJ1Lrogjd_-Z8Q2KzpAPP28Ghf6SMQ@mail.gmail.com>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
 <xmqqd2opu8hr.fsf@gitster.dls.corp.google.com> <CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
 <xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com> <20130904081047.GB2582@serenity.lan>
 <xmqqa9jso69u.fsf@gitster.dls.corp.google.com> <7DC052455C7C4B50A4EAFC1EF63D006C@PhilipOakley>
 <xmqqr4d4jird.fsf@gitster.dls.corp.google.com> <CAMP44s0kMbXvcJbWvJDu=8A5iOeH4fsMGUdT-ehXKNXiV1FQ1Q@mail.gmail.com>
 <522C168B.7050300@bbn.com> <xmqqa9jn6v6q.fsf@gitster.dls.corp.google.com> <CAMP44s01wK3Cf1ChOx=J7YKv0VgjYQB+NvyTt4-Mahsu4qG4iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	John Keeping <john@keeping.me.uk>,
	Git List <git@vger.kernel.org>, Andreas Krey <a.krey@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 01:12:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIo9Z-0007Aw-98
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 01:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210Ab3IHXMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 19:12:06 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:63708 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098Ab3IHXMF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 19:12:05 -0400
Received: by mail-ie0-f179.google.com with SMTP id m16so9180970ieq.38
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 16:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=C8vBUNRAIw0exf4h89F8R0R4IoUGMLqwdP6sCpbO+Ik=;
        b=RWxONHacIu/WBP9YPXwpdctPTgjegzn9qLlP4KMN+vYpXaTHS068tmuxqP7mTGUFMO
         24ELXx9PydlmbOuEuzI7kv26uzofKxnZ/83A/El93MgLw3ZtqqGC6knMQN3LItuKbMME
         yKT5VZ2DW6vsPyZWnaIrRME3RFaXwJeiQTVL+IER7JH3yonYpjUbDaFdGdS86+sK868m
         Wb92OmlmHp4kEE7IKPFt1X2p/BZKhDmX8TxaU1wq4rYrXNVzhRKW8Zkh38EdOLiCfuwX
         tD9GDUgHhbV3Av79UIBKc3zSE6PNbgkmEEFeoR7wkl5X0A9AkA5jXFhO60sLU2Z9CGSD
         zmbA==
X-Received: by 10.50.23.16 with SMTP id i16mr5974622igf.50.1378681924797; Sun,
 08 Sep 2013 16:12:04 -0700 (PDT)
Received: by 10.64.73.5 with HTTP; Sun, 8 Sep 2013 16:11:24 -0700 (PDT)
In-Reply-To: <CAMP44s01wK3Cf1ChOx=J7YKv0VgjYQB+NvyTt4-Mahsu4qG4iw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234280>

Felipe Contreras wrote:
> On Sun, Sep 8, 2013 at 1:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>>     pull.<someoption> = rebase | merge [| always-fail]
>>
>> makes that choice in a clear way, I think.

The core issue is that users rarely want to merge locally: that's the
maintainer's job. Users simply want to rebase, and develop on
different branches that they will rebase onto origin. I like Felipe's
idea for using a pull.mode.
