From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] git-p4: add test case for "Translation of file content failed" error
Date: Tue, 22 Sep 2015 09:02:58 -0700
Message-ID: <xmqq4mim5tn1.fsf@gitster.mtv.corp.google.com>
References: <1442829701-2347-1-git-send-email-larsxschneider@gmail.com>
	<1442829701-2347-2-git-send-email-larsxschneider@gmail.com>
	<xmqqio73abl0.fsf@gitster.mtv.corp.google.com>
	<E47DE9F0-6017-4E96-AC29-E6C60C4D85CB@gmail.com>
	<CAPig+cRV-RCdcmAHG+bRL6_yYYNCRqQPQ+v3KCXwC81StGKibg@mail.gmail.com>
	<FAA838A1-CBD8-4716-ADDE-6CC912C19BE6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 18:03:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeQ27-0000ru-HT
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 18:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758568AbbIVQDB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Sep 2015 12:03:01 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34867 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352AbbIVQDA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 12:03:00 -0400
Received: by pacfv12 with SMTP id fv12so13101675pac.2
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 09:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=1Yy2Zb3RxAK2yDU8kcaciM04X1+V316/xnMZp29unRo=;
        b=0J9ylz9AIFhQwuDkZpBRCvxnISOGU8vmaogXv8XLufFRA825AfOkAvVwwFGpJ56jjg
         9IVDRC+0NHgZq3HmWMFXlKOZm3xSOJK0889bN1u2NAeK7c3VguR3MZzRdS7SXhBetONA
         LFnePyPwZZczXgOVQAWWKVjWHbo5HuCoiGDaRoKkd7ljOJorMWE9NwQlMEUx73O4kldw
         21I+Jyqp2cVYtrerZH1uJ3cnbbK/RuAiZoYk6QhekKqW7m+kDlNqJrZSs1E9IDr5/iAp
         VPhGHibHOp12JtUVi9p3al2yb5RJZUezNJUkQuItY9lKQOGSUIYtejaSWdKTILAlOfoZ
         Pb9g==
X-Received: by 10.66.146.4 with SMTP id sy4mr31387929pab.79.1442937780078;
        Tue, 22 Sep 2015 09:03:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:fd7e:7071:2eda:9c63])
        by smtp.gmail.com with ESMTPSA id rs8sm3129892pbb.14.2015.09.22.09.02.59
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 22 Sep 2015 09:02:59 -0700 (PDT)
In-Reply-To: <FAA838A1-CBD8-4716-ADDE-6CC912C19BE6@gmail.com> (Lars
	Schneider's message of "Tue, 22 Sep 2015 12:12:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278400>

Lars Schneider <larsxschneider@gmail.com> writes:

> If it is no extra work for you, you can remove the quotes around
> =E2=80=9Cdb=E2=80=9D. I can also create a new patch roll including th=
e sed change
> and the quote change if it is easier for you.

Now you've tested the SQUASH??? for me, I can just squash that into
your original without resend.

Thanks.
