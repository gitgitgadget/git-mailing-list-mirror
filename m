From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Opinion gathering] Git remote whitelist/blacklist
Date: Tue, 24 May 2016 09:20:42 -0700
Message-ID: <CAPc5daUTdesKcddPRtQDwO+L+qxEiE5NFv5_=2wyOH-QQ5uO1Q@mail.gmail.com>
References: <1040142021.5607762.1463753271105.JavaMail.zimbra@ensimag.grenoble-inp.fr>
 <584027154.5608416.1463754104066.JavaMail.zimbra@ensimag.grenoble-inp.fr>
 <001001d1b2a3$06d7bbb0$14873310$@nexbridge.com> <1929221963.5686879.1464007899902.JavaMail.zimbra@ensimag.grenoble-inp.fr>
 <1884904685.12056.1464084750628.JavaMail.zimbra@ensimag.grenoble-inp.fr>
 <84BDC4A4-FBE1-4542-868C-FA77A25469F3@gmail.com> <vpq37p74nu1.fsf@anie.imag.fr>
 <CAPc5daURo8SkbeGf0MEsp0sLzdzFfUOxptgusFr58UG9SKmDAA@mail.gmail.com> <002b01d1b5d7$aefd0a70$0cf71f50$@nexbridge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Lars Schneider <larsxschneider@gmail.com>,
	Francois Beutin <beutinf@ensimag.grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	wiliam duclot <wiliam.duclot@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>
To: "Randall S. Becker" <rsbecker@nexbridge.com>
X-From: git-owner@vger.kernel.org Tue May 24 18:21:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5F4v-0005nU-Qd
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 18:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752967AbcEXQVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 12:21:04 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:34325 "EHLO
	mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038AbcEXQVD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 12:21:03 -0400
Received: by mail-yw0-f170.google.com with SMTP id c127so20939225ywb.1
        for <git@vger.kernel.org>; Tue, 24 May 2016 09:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=MyADEmU+/Dg5vvoBSON3nRmYMbJORI0lutfCZhEkbOE=;
        b=cZMqC/NymlyjnjEnHznEb9cLMVi2Fg8a+znukISxvO91jPrY9Eb9tztluJA8zLHhxa
         N7fwHETQYSgKAYd5sXhvggS1Judq+peZ5XqCnbuKajnf97MrKXZVvyA8AptPAKOYPRbu
         017L30NN1ocaQD+0YTotBlpEj+niICQfTe10RZ6nzGietCLptrW88wfqhH5CNg7Oahji
         gyYjsJ010rWI/APQ8R5HRymapSJk9ZPmifKmiDiQb/KqQIDbVZuviGJnQ27pw59Vl2YT
         e51j3Aa54Si6oCl8F5u0KusLknEbw+RAQBQ8ZmCG6ae6lFewt7FsV+Rtl203PfqwAr9g
         31Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=MyADEmU+/Dg5vvoBSON3nRmYMbJORI0lutfCZhEkbOE=;
        b=QUb2RvKY2TRP/PnM2u98yB25lw6jyTFQ4OTnqERFS15IuFCMeemjzPWXPTO1h62pgo
         tCsMcRIvnf5G5f3dFhPKOc9KKmEkYW/5DVGX2BHojuRqEvjU6MPqYuBim7tit19j8OYW
         AKx9FLKU4zuo1HTAZnVMiua3hx0vLv/iw0xnLqoWesX3asct9t0lLKSezRZ9wcDDo606
         IxeUTQflOT16fUmNKbao6ZUeNM3S4VZ65oItz+6v9Vf12quvrnkTafD+XS3ucseSxmEQ
         iUQe/JS9BZR/jBvlUrA+LuD9XOk0unAwBxgtxl+nBFGLrH1+tW6u/XQ7fQvhn1G385Rk
         RD8w==
X-Gm-Message-State: ALyK8tKFicy7jLKIU03vu2Sach9xtbZ1FtaSkVzGuNcixuOhohcwGbS0iGSi3+F0VNfnQmFBdJJAY0cr63gNKA==
X-Received: by 10.13.215.136 with SMTP id z130mr1933056ywd.278.1464106862067;
 Tue, 24 May 2016 09:21:02 -0700 (PDT)
Received: by 10.13.251.71 with HTTP; Tue, 24 May 2016 09:20:42 -0700 (PDT)
In-Reply-To: <002b01d1b5d7$aefd0a70$0cf71f50$@nexbridge.com>
X-Google-Sender-Auth: zMKg5hFk0kqxQcUxveWRb6If1kw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295500>

On Tue, May 24, 2016 at 9:16 AM, Randall S. Becker
<rsbecker@nexbridge.com> wrote:
> May be missing the point, but isn't the original intent to provide policy-based to control the push

I didn't get the impression that those who are proposing were
interested in a "policy that you have to obey" at all. Isn't this more
about "I often by mistake say 'git push foo' which I want to prevent"?
At least that was the impression I was getting.
