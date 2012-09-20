From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH] Improve legibility of test_expect_code output
Date: Thu, 20 Sep 2012 01:25:51 +0100
Message-ID: <CAOkDyE-x5NeZX2tpp3C9Kkwb1kPniHptB9ERvtpx2XODufaW=A@mail.gmail.com>
References: <1348094310-11214-1-git-send-email-git@adamspiers.org>
	<7vboh1eew2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 02:26:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEUai-0006TY-Tz
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 02:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276Ab2ITAZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 20:25:53 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45207 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753173Ab2ITAZw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 20:25:52 -0400
Received: by bkwj10 with SMTP id j10so844982bkw.19
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 17:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=xBnpITOI9WnwtHY0YqzW+vs5JqrMn8rfYbmWZAAZ6sc=;
        b=0Igj0edMqpBd9cBxIr33dJPhGJJ/FkBbtsIR84U8lLeQaw9vDE+T881N/v6flCXBRk
         No9WGdFl6oeE+iLvS8ax3E+Kb2vaC2kW2hH/4m+p0bbHzpDpQQnpxCN9WartqXHRLqBX
         59tlhlNZ3QDszPdEch0d9bBtsPNFhN3qW2p1b8jpr+o2P7nPYKLWn4b3kbfFgGLsTwUJ
         1sya9L28DeSMJGxNojwTCZDvc3SSsgObLseHRizCdjaGtm8LauoHQBHmBhi+NvaAcE7T
         06X8hkv39ep2QqoNdLUSqPt6LFvo1kZKawtyelLurcPweSYBjO7TuLwaoJ4CxiKKEkM4
         pRuA==
Received: by 10.204.129.24 with SMTP id m24mr38198bks.134.1348100751099; Wed,
 19 Sep 2012 17:25:51 -0700 (PDT)
Received: by 10.205.81.80 with HTTP; Wed, 19 Sep 2012 17:25:51 -0700 (PDT)
In-Reply-To: <7vboh1eew2.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: KLtnIjoLVnDwLWcTPwdet4I4oR8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206021>

On Thu, Sep 20, 2012 at 1:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Adam Spiers <git@adamspiers.org> writes:
>
>> ---
>
> No explanation why this is a good idea, nor sign-off?

I realised I forgot the sign-off seconds after sending :-(

Isn't it completely self-explanatory? e.g.

    test_expect_code: command exited with 0, we wanted 128 git foo bar

clearly makes more sense than

    test_expect_code: command exited with 0, we wanted 128 from: git foo bar
