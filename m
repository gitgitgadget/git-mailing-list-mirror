From: Stefan Beller <sbeller@google.com>
Subject: Re: 0 bot for Git
Date: Mon, 11 Apr 2016 21:29:59 -0700
Message-ID: <CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Greg KH <gregkh@linuxfoundation.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 12 06:30:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1appxv-0002uw-5i
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 06:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbcDLEaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 00:30:07 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:34782 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795AbcDLEaG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 00:30:06 -0400
Received: by mail-io0-f182.google.com with SMTP id 2so13473701ioy.1
        for <git@vger.kernel.org>; Mon, 11 Apr 2016 21:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to;
        bh=KwJz81iWalp0+s1SGMphDhEbrI8hI5M0QiUBkBD6Bo4=;
        b=UaepVqaoNwZZN0F+kWt9I85NvFaytHTz2BRA0PTiK65G3pcWTM0xnjku7AwmMPKNyX
         4qWiJBPRepMADMOaGZ9B7JMwAEH6yJ0ilh+1ybk7wLfmwrmIwg+EfRgJ37fNphcwbtE5
         tyMNike58cgex8dcbJ5qs+xF32Sadbktt2fDU0qWEB0V4Ujt161DF0rWOkytZbYx7w6A
         Q4c2TokXaKlWzVLm0GE/N1wUuBTg5cnPJsrFBzlw3oPggR6JRXtkDcCGFUTLqftOhVZH
         XAJHZtBly4PKWUvnpo2WwPfsuIjVeSv/EfzaaTZIcUVKqyXMHzwJJ1BjDlBeJU/IWZzK
         Ex4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to;
        bh=KwJz81iWalp0+s1SGMphDhEbrI8hI5M0QiUBkBD6Bo4=;
        b=lkydlpyvWIwsWa9MsXoO3tfTYgncm1LQn8d6lof410vevz26p0BihEIP2hPyEtsr6L
         TQssj4WpRoMH3/RBM4xHTKCXkdsSgnbvyCIOGYKCxf1vvDO4/9cMKCL9HId8gzys5O/k
         OL10zNxf93Uo2GndqYWV/cWVazDQoVnQcFvF9H0bo/KeOzUt59gVWxrdPIb//KZwDsOB
         HkV78v/0tyXoJHVcWZypemfb6+6uunPROnhEBukaK2nVgF3EkpTW/gHAcXjloo1raeTZ
         dsK2UlnEao1O9MWP0JPAGdEbc9v6C+gVGTKKfNj6dOD5EAS6AEE+gQ4olIdGJcMLT54r
         +TNA==
X-Gm-Message-State: AOPr4FWSJLlgf3FgN0bzDRMltKPe72By4eDPx1SxWmgfdiDPzbGolxgmniD+3nQG1UGYRox3qVlcN7q9npIeQqEt
X-Received: by 10.107.18.227 with SMTP id 96mr1486522ios.174.1460435399598;
 Mon, 11 Apr 2016 21:29:59 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Mon, 11 Apr 2016 21:29:59 -0700 (PDT)
In-Reply-To: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291242>

Resending as plain text. (I need to tame my mobile)

On Mon, Apr 11, 2016 at 7:51 AM, Stefan Beller <sbeller@google.com> wrote:
> Hi Greg,
>
> Thanks for your talk at the Git Merge 2016!
> The Git community uses the same workflow as the kernel. So we may be
> interested in the 0 bot which could compile and test each patch on the list.
> Could you put us in touch with the authors/maintainers of said tool?
>
> Unlike the kernel we would not need hardware testing and we're low traffic
> compared to the kernel, which would make it easier to set it up.
>
> A healthier Git would help the kernel long term as well.
>
> Thanks,
> Stefan
