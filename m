From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Avoid declaration after statement
Date: Fri, 25 Sep 2009 15:34:50 +0200
Message-ID: <40aa078e0909250634w5f633946kb60ace76c7dce657@mail.gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com> <213f3c7799721c3f42ffa689498175f0495048eb.1253088099.git.mstormo@gmail.com> <05f2bea5-0f74-4c89-9a84-d908a80bea20@h30g2000vbr.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>, Marius Storm-Olsen <mstormo@gmail.com>, git@vger.kernel.org,  Johannes.Schindelin@gmx.de, gitster@pobox.com, j6t@kdbg.org, lznuaa@gmail.com,  raa.lkml@gmail.com, snaury@gmail.com
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Fri Sep 25 15:35:02 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f162.google.com ([209.85.211.162])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrAwv-0002FO-VK
	for gcvm-msysgit@m.gmane.org; Fri, 25 Sep 2009 15:35:02 +0200
Received: by ywh34 with SMTP id 34so2860808ywh.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 25 Sep 2009 06:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=/VjsR7cxlHN20TnVV4/eFge5n0+cpzVr3CkehEa+xvo=;
        b=H7SGIfwTGknAAlbNdcrbx1IiIXjfhAQ6LEcDudWY7+Sq9Vy+TZRxAjRz42ccE/ZMck
         vju3jsYtXzQTdxzCqkTjJmqD6De2N59XlAkX/2tc/e80fXQA7w7FU0XHdl0INa8dh6IS
         09qpyxxMzWWaO+icfkzRB02lP0z34r10xqGxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=Mu+SpLS3jsZQBrtXeFTNqlJ43wNWVnQQNAIa6X5B7JKaMB/9Bcbyp487oN+/SvCvC2
         zou9zDvnLNbiGvKA+KYdWiD1+qtKwONYzk/XNC0EIRBqHqDpJUGa0jVjsEir+FuFiGFN
         uQRFXZXoPrZ8zKErexa2xek4hTF9DF/rQoIe8=
Received: by 10.100.83.6 with SMTP id g6mr23947anb.19.1253885694732;
        Fri, 25 Sep 2009 06:34:54 -0700 (PDT)
Received: by 10.177.108.35 with SMTP id k35gr7164yqm.0;
	Fri, 25 Sep 2009 06:34:54 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.223.144.85 with SMTP id y21mr3370fau.26.1253885692174; Fri, 25 Sep 2009 06:34:52 -0700 (PDT)
Received: by 10.223.144.85 with SMTP id y21mr3369fau.26.1253885692156; Fri, 25 Sep 2009 06:34:52 -0700 (PDT)
Received: from mail-fx0-f221.google.com (mail-fx0-f221.google.com [209.85.220.221]) by gmr-mx.google.com with ESMTP id 5si209969fge.8.2009.09.25.06.34.51; Fri, 25 Sep 2009 06:34:51 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.220.221 as permitted sender) client-ip=209.85.220.221;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 209.85.220.221 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by mail-fx0-f221.google.com with SMTP id 21so2377487fxm.9 for <msysgit@googlegroups.com>; Fri, 25 Sep 2009 06:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:mime-version:received:in-reply-to:references :date:message-id:subject:from:to:cc:content-type; bh=/UUjUtqMYvypVOGQsQoxanA5wFrzcV+8LpJm6E2SkSQ=; b=Hv17smC6etWW8IVIb3JAjC/ye3bp1eieJCDQhjZBGaB0f9/wX1rKEjE8D9ne2Hiv/6 +7FsCHDigQ0AdWqWvTQTD9CmOJTBnxqc01scsaFM7SOWGIQgw8CDz2vGLLPufXfirc/7 mGYvgEttpktDwk0iVtnXtNl3gAxg7LSKISTtU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=mime-version:in-reply-to:references:date:message-id:subject:from:to :cc:content-type; b=SLTssMFmsSnniIxJxA3iH8oGh9LYHc+dcj7hwIfjrpI2qrv70zFgkciEtAGvmTmyFK EUcEkXkcBgJgM3ZA3C28e2jRCyWnqy6mM0B6dNLzAUWoV/MyY5csEkfs7xfvm70YkxRs 7XbD7cHNkydhoWQ5KAW8z3wzBZ9SSriavAABM=
Received: by 10.204.7.92 with SMTP id c28mr115647bkc.170.1253885690937; Fri,  25 Sep 2009 06:34:50 -0700 (PDT)
In-Reply-To: <05f2bea5-0f74-4c89-9a84-d908a80bea20@h30g2000vbr.googlegroups.com>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129081>


On Wed, Sep 23, 2009 at 11:44 AM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
>
>> From: Frank Li <lznuaa@gmail.com>
>>
>> MSVC does not understand this C99 style
>>
>> Signed-off-by: Frank Li <lznuaa@gmail.com>
>> Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
>
> Indeed, even in recent Visual Studio versions the C compiler only
> understands C90, not C99. Would it make sense to just force MSVC to
> compile *.c files with the C++ compiler to fix this, rather than
> patching files (which might be necessary for future files, too)?

I don't think so. There's many other compilers out there that doesn't
support C99 features, and most of the git source code does not depend
on them. IMO, it is better to fix these  issues for all those
compilers once and for all, instead of having to find ways of working
around them whenever someone changes compiler.

Besides, C++ isn't a strict superset of C. There might be warnings or
errors introduced by compiling the code as C++. Implicit conversions
from void* springs to mind. Quick tests reveals that MSVC doesn't seem
to warn or error about them, but there might be some other differences
where we do get into issues.

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
