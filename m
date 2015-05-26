From: Stefan Beller <sbeller@google.com>
Subject: Re: What's cooking in git.git (May 2015, #07; Tue, 26)
Date: Tue, 26 May 2015 15:06:11 -0700
Message-ID: <CAGZ79ka-Ad3Vi8=AhLMCiY-7yJ1xpMhF+58fCO3NhQA9QbQo6Q@mail.gmail.com>
References: <xmqqegm3j9jo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 27 00:06:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxMzJ-00043x-Qa
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 00:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbbEZWGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 18:06:13 -0400
Received: from mail-qc0-f182.google.com ([209.85.216.182]:34237 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939AbbEZWGM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 18:06:12 -0400
Received: by qcbhb1 with SMTP id hb1so9279qcb.1
        for <git@vger.kernel.org>; Tue, 26 May 2015 15:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iV4pGYjImv3ax0EXRFxsS7Pfu/uhcsgnusjiALLgEtc=;
        b=EYkpdj7BEfQm2pggRHVDHKKsq/UODOdJVKzhy34xS7qSqMN7wiL+A7fQU1UjulEAKh
         sfJfAppcs/C/urB7bK463fhOG2UaxCG8VY/022/0dIJBgM4gkg4v6a5h0wxb/ZhLe6UK
         dmONBdh4/lEnKXfOB5rF2BMrseQZxNC0ZxQdVqd6GVMi8EIRrGkbbAGdHui4yzCN1dqV
         mmud8t1RkA5idLDQPkOG8vXyZRcxH7B+M9mHgSCAJ64k6OAdYZB39mE38bzw14qVMCgz
         +Lpp0KEibNXhIYHjMc+jaPPaJo1PIG4pMs+vfPoKX4lGimGAOD4iIFZzhiEYp6DwpOcx
         MtqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=iV4pGYjImv3ax0EXRFxsS7Pfu/uhcsgnusjiALLgEtc=;
        b=c9qCGK7RaiJADgtEZ2FKA3Qcv1iH1UaBK86EW0z5GiSH8y3KiFbouhbciUGfTEKne0
         /0an8JBGx2/jt3SfH54U5wm20pXr/iYrS1eTr0Pt5T2oynJbyoyP4ytxCFiqWuRfPPGI
         230VVIqCuBOzXRqXanzbK0Eeks6hS5NanK8Pe72cV71XgNX1yweYhhgTbyjqxu7TExGE
         fjQ3HwYlPhQMvDVXzHKokwBKGx4nnbkeKUmsokbEUuxCmPd/P2ZtTRYou3Ga7sgmB7+m
         Fpn45V8KuAT5SRofP/jXT/wJIL0qnl8ZJjA6g5ZdwCZHuphh0sGCxAHq0XAdl0vG9jIE
         pCWw==
X-Gm-Message-State: ALoCoQm0ySp7if1ad7MY88tb2XdoSYxbXuKmeyNIPOpeHcqjNl5x7L1QLpnA64WZ0b/zdYUDIM6g
X-Received: by 10.140.132.17 with SMTP id 17mr18807890qhe.36.1432677971758;
 Tue, 26 May 2015 15:06:11 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Tue, 26 May 2015 15:06:11 -0700 (PDT)
In-Reply-To: <xmqqegm3j9jo.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269998>

> * sb/submodule-doc-intro (2015-05-22) 1 commit
>  - submodule documentation: reorder introductory paragraphs
>
> What's the doneness of this one???

I'll try again without a "This command will do ..." introduction,
I just did not look into it yet. That said, I was expecting more
bike shedding than usual as it's a documentation only change,
where it's harder to come up with clean and readable text as
compared to code.
