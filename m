From: Stefan Beller <sbeller@google.com>
Subject: Re: Where to report security vulnerabilities in git?
Date: Fri, 21 Aug 2015 17:02:53 -0700
Message-ID: <CAGZ79kZdkcZQKxZ+M8WoXDZ6J=nk7C1E-JTBEcYYwTB_kORNjQ@mail.gmail.com>
References: <CAO5O-EKaarYDBd-cpVvKVXTWfKm10ttqd3A6wNe2cXGriGux1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Guido Vranken <guidovranken@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 22 02:03:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSwGx-00008C-09
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 02:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759AbbHVACy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 20:02:54 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:34116 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbbHVACy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 20:02:54 -0400
Received: by ykdt205 with SMTP id t205so86749879ykd.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 17:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Z+ObYlLkPXDg6Szu9xV8TVzoLGZpYqLqQB39QNsA5ok=;
        b=N9NY7I83xb6tX0FAzMp9ghVkaIyYtkL5mlKEskrOpEdSYQ7eFAAFKxEAdoaggvHH/T
         SWUny9GEuLojmiNGNCsXwOOjc/YWxLqPh7A3VH6SlC8PTZspiwQaatC4oBb+I9M/cjxF
         dR0SguwOgPR1l1ejKcPvhR6zIePMogaijCxNBLy+pkDIHpjDztDBITU5uvubDVE5GSBA
         J3dbRDux+O5zlswE9yePpRQbIkR007762ed66SFJPYnrjJUkfq+7A+RSvGg71Kps0ugm
         vn4gm21AGo/0HidfB9ioVfYg2QOdv71skweUD9FuiTGRPY2sjrd9QFuOBdtngauSt7OJ
         OKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Z+ObYlLkPXDg6Szu9xV8TVzoLGZpYqLqQB39QNsA5ok=;
        b=DAWRKUqXEYRsVxX07l2iKczOi5YFHGtHIEOino1MLY6e251j7GyCZU9D5WW/pGmJOD
         1bWmtLgwxA+DSQDRpMesMkkoJY/DjJg9R/gQX/L0aUbbmBpGme4yyeI2gdKAoSLxiKqz
         6Z8m0uQotZTKOKOI6C/uAxOtcWW/hD0Lk26dCqGZjKSRn3a7byEgBrZWEeHhDnif9/6/
         oi9QqjB3kXuyMI5cMlrA3zH1KKL9NcZaVjwvNr1yGeCWsU7kG5+oeTinArqtTbuTgXL/
         +xOcwP4SLoJE9b5LzQtmF9KGdICdzBKk+r3Gh7mvFHCNGQhQoCo9XayVzGU60L0JO4D4
         SmPg==
X-Gm-Message-State: ALoCoQmxz1QFSvSPvHpFt6hdCCT3Vb12wrhxCbqgBcHE/jKwRKBOxiHRQDImlMnv3MUVMjUX25pP
X-Received: by 10.170.56.8 with SMTP id 8mr15717060yky.115.1440201773212; Fri,
 21 Aug 2015 17:02:53 -0700 (PDT)
Received: by 10.37.21.132 with HTTP; Fri, 21 Aug 2015 17:02:53 -0700 (PDT)
In-Reply-To: <CAO5O-EKaarYDBd-cpVvKVXTWfKm10ttqd3A6wNe2cXGriGux1A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276343>

The addresses are still valid. (I think there was a plan to introduce
a git-security@...
but I am not sure if that happened.)

> Current practice is to contact Junio C Hamano <gitster <at> pobox.com>.
> Cc-ing Jeff King <peff <at> peff.net> isn't a bad idea while at it.

Just go for that.


On Fri, Aug 21, 2015 at 3:55 PM, Guido Vranken <guidovranken@gmail.com> wrote:
> List,
>
> I would like to report security vulnerabilities in git. Due to the
> sensitive nature of security-impacting bugs I would like to know if
> there's a dedicated e-mail address for this, so that the issues at
> play can be patched prior to a coordinated public disclosure of the
> germane exploitation details. I did find an older thread in the
> archive addressing this question (
> http://thread.gmane.org/gmane.comp.version-control.git/260328/ ), but
> because I'm unsure if those e-mail addresses are still relevant, I'm
> asking again.
>
> Thanks.
>
> Guido
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
