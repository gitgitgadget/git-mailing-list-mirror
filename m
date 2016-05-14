From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: What's cooking in git.git (May 2016, #05; Fri, 13)
Date: Sat, 14 May 2016 18:16:23 +0530
Message-ID: <CAFZEwPPWt=6ZJzvXxS9MuiSHbSadvSkhYEv9_7MehjN-NfmhGg@mail.gmail.com>
References: <xmqqk2ix8v6w.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 14 14:46:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1Yxh-00007S-Ug
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 14:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115AbcENMqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2016 08:46:25 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:36501 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbcENMqY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2016 08:46:24 -0400
Received: by mail-yw0-f175.google.com with SMTP id o66so141967360ywc.3
        for <git@vger.kernel.org>; Sat, 14 May 2016 05:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=tVB/h56sqs6RYFbdANhId8q2PzyOAeBTuNnae5U2pyE=;
        b=l2Un6WeM8IW4MxxdabggZAcSQcS0P/qoLPW2uLFoSUBnPlYG8GxupkjHh5FCDxhrRb
         ZtLyUV8SRq3lOAy0JHL2SAaoEOUq2Gj+v7YgCDEuw2QVpC5LW5p8iWFOL8cLMM3BOn54
         lqqhhGfaL+Cn3anZtibY8y6YQjO1ye+BXoXY8f3rwwfKEoZIxuZ3PWxES44JqtarMXfi
         vItIdFiV6ACknQjKHcaTfvhk/dZUZy8fAKM/Db4cbAya3v05oNKvfYq27bCmEZWojrez
         d/gE72MEfH24AAQNIS+bthzvjDO64e7wUArS0fuHKTc3eV5gBj1W8vAc+RBis2K6vrHF
         6zmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=tVB/h56sqs6RYFbdANhId8q2PzyOAeBTuNnae5U2pyE=;
        b=A+kjSAfOodWk+jN/HaM2RTuZHsKaTEwcKXCrPIbbTxPu9iZTQ7hBobALqlCsf+jZ1F
         Ds9K3whpf9bEFnopViHKqX/yyusxuDGBI1gjEQpRnRKVgDrjzo+wXuSZZKcLlL00a7Xl
         G8+Nt5uKOz585VdvaAjed8+u9urqsomaf4ERw3YyG3VoMDxONuBbH6ZoBeZPxVCsmW/p
         661Jt5zvXMb+PoDphkkDvuex3UOIrnpVfu/Rbon86M2/K5Dz4ehYeur6Wx+yCkuPC15W
         06b7sOo8Ca6F24d04ARglJH0yA3CUyfo1i0+WrfnB0nkfBJ46Cc/EYgrqQPmwI/0TRcV
         n8NQ==
X-Gm-Message-State: AOPr4FXi+a7SMYi2/vJ9t1MynGtScNCEQ3Svr6pi+mOHouck3vLlsuph8i2zPlJzxrXpm+O7mI8wHIDKB2i95g==
X-Received: by 10.13.235.143 with SMTP id u137mr10636026ywe.20.1463229983881;
 Sat, 14 May 2016 05:46:23 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Sat, 14 May 2016 05:46:23 -0700 (PDT)
In-Reply-To: <xmqqk2ix8v6w.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294610>

On Sat, May 14, 2016 at 3:41 AM, Junio C Hamano <gitster@pobox.com> wrote:

> * pb/bisect (2016-05-13) 4 commits
>  - t6030: explicitly test for bisection cleanup

This one can be considered as independent of the entire series.

>  - bisect--helper: `write_terms` shell function in C
>  - bisect: rewrite `check_term_format` shell function in C
>  - bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
>
>  Beginning of GSoC "git bisect" project.

Regards,
Pranit Bauva
