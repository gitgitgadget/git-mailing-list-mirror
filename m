From: Armin Kunaschik <megabreit@googlemail.com>
Subject: Re: [PATCH] t0008: 4 tests fail with ksh88
Date: Fri, 20 May 2016 18:11:45 +0200
Message-ID: <CALR6jEj=Nd6K8poP=G+n_5dZfAGaZLqmnOV0EuSJ9aE5LNniEQ@mail.gmail.com>
References: <CALR6jEhviK9KZxR6R6xzkZ5EAO-RjWj3xYah_DOSDXhEjYsT-A@mail.gmail.com>
	<xmqq37pchi90.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 20 18:11:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3n1l-0003FO-Kl
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 18:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754231AbcETQLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 12:11:47 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:34285 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769AbcETQLq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 12:11:46 -0400
Received: by mail-yw0-f173.google.com with SMTP id j74so113745646ywg.1
        for <git@vger.kernel.org>; Fri, 20 May 2016 09:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=bLEuFc2ttylazFQwcMF9u4PBDQJ9CJubHyPnQcvo8iQ=;
        b=vAIcnRh7iOJoz+fRwcgWXYcQ7dbdKsamjDboAH4fTwLDkNI8Rflrudp/biOpdHF3Gz
         NznmEa3/IaVo7j7M+IR9E2raa4d6eJJCvZdPheL3WToEhJF4wfhZLcZAJHyQLMv4RE3K
         xnQxuP+yWDZR8cexOB3mZQ2FiJ2k3xBSUvBEZAtAqUc5GlaOzv1zA7GyHjKT2NBWDv28
         HRmGjz8V1syaUSW50xcixYFBMw9Fqg5/mI6z9p/6sIgSp1+oP57WZ9YQO1gCtmOOUmvQ
         NVRAd4deyGXD1VGoO0/dzbHTQe7oIo25ILSwp7ftLjoE+nnYVzVtLwdPlvLykrqzII6N
         xvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=bLEuFc2ttylazFQwcMF9u4PBDQJ9CJubHyPnQcvo8iQ=;
        b=nEaYmu1R1O7pG/nQ5Tuy0SACREzNdA1PhXUuAt/eX7o3US8pYhU/RV+kqg+vzsCMCa
         mnSdNoeOohEUcWTPMnZMaFfXEgKa7VOMD/Brz+NB+XSw9aC9g7v0CLy22cx4guInhFll
         E9OdglHueWNvY4CQg2n9OeYSYP/AafXD8U9ASLBk93eipvqJIrhlLC8lJpS2/UH2bVVA
         b/WKiqUsUMOaNhILod4+2MT9HtAI5VIDXu0FRas0qIzmoNz6Foi0lNt29yCFA+pS4gRR
         lC/LF9KGmMrHNoKR769t7st1kz31QJP6mcVYZy4gHkjAegQ+ApAX20MPmoneC16mQI5x
         D4mA==
X-Gm-Message-State: AOPr4FUdW1aEYXVq6yjcZNTwhJJDOPMKjKvNEMiCE6AGj4e7DEPlwv3GQXLo7xhHjfIW69ciFx8I/X9pLyBA5w==
X-Received: by 10.37.122.69 with SMTP id v66mr2438640ybc.68.1463760705895;
 Fri, 20 May 2016 09:11:45 -0700 (PDT)
Received: by 10.129.45.132 with HTTP; Fri, 20 May 2016 09:11:45 -0700 (PDT)
In-Reply-To: <xmqq37pchi90.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295180>

On Fri, May 20, 2016 at 5:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Armin Kunaschik <megabreit@googlemail.com> writes:
>
>> From: Armin Kunaschik <megabreit@googlemail.com>
>>
>> \" in the test t0008 is not treated the same way in bash and in ksh.
>
> Could you refrain from singling out "bash"?  We don't write for
> "bash" specifically (and the test I ran are with "dash" before I
> push things out).
I can name it "other shells" if this is more comfortable. But I tested
this only with bash and ksh88 on AIX.

> Ideally, if you can try ksh93 and if you find out that ksh93 works,
> then the above can be made in line with your "Subject" to mark ksh88
> as broken (as opposed to other POSIX shells)?  That would help us by
> reminding that running test fine with ksh93 is not a sufficient
> check to make sure we didn't break ksh88 users.
>
>> In ksh the \ disappears and generates false expect data to
>> compare with.
>> Using \\" works portable, the same way in bash and in ksh and
>> is less ambigous.
>
> All of the above would need s/ksh/&88/g; I'd think.  I just tried
>
>         make SHELL_PATH=/bin/ksh93
>         cd t && /bin/ksh93 t0008-*.sh
>
> and this patch is not necessary for ksh93.
Yes, the patch is not necessary with ksh93 on AIX, but it works :-)
The patch is targeting "ksh" on AIX (which actually is a ksh88).

In the discussion Jeff took a look into the POSIX specification
and described the behavior like this:

<snip>
I think either is reasonable (there is no need to backslash-escape a
double-quote inside a here-doc, but one assumes that backslash would
generally have its usual behavior). I'm not quite sure how to interpret
POSIX here (see below), but it seems clear that spelling it with two
backslashes as you suggest is the best bet.
<snip>

I'd not declare ksh88 on AIX broken just because of this ambiguity
since it is not 100% clear in the POSIX description.

Armin
