From: Josh Boyer <jwboyer@fedoraproject.org>
Subject: Re: git history in a file
Date: Fri, 24 Jul 2015 09:02:26 -0400
Message-ID: <CA+5PVA70T5NpmYPBrSY7_2C2_-nSMT898kboa8_Xnv+6Borgsw@mail.gmail.com>
References: <CA+5PVA6S69ZU5Q432PK3DiPGkT=00tAtgSzJaYHyXLkHkg9FHw@mail.gmail.com>
	<87wpxp4tae.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Jul 24 15:02:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIccS-0007Tc-4h
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 15:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754272AbbGXNC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 09:02:28 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:33170 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754262AbbGXNC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 09:02:27 -0400
Received: by ietj16 with SMTP id j16so17917558iet.0
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 06:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=rvp440XOHxIScjVxYI4HTAyK3XfRRbFzFz6mL38ksmU=;
        b=MGgQZT36m117/rucAHZHO52uvx+srI9AvN4guotstH+Vo4ggb6dBJQZXxuMXUJeQfd
         RJ0L3rpjAFZeJ2TZz1ub23o7hSH5VeIRp6DJarm2EpmFOiJZOcXWt6zrzWJ/8V83suxg
         a6cZr9weDsOYVhYwUxC/5zI4isCvVvexw6ZXkSZ/d9BTycx7YhswhK+SExOlUKTlccW6
         majuX/IKsHHLP2dhuJnHbjM0110Bt8VaRwIE/b0xa4gyfaNOO5t8CgcQvwrM5qWyn929
         MAAYdagE6XLWgUqObXc8yTGfqEzg4madin07tux6FLC2bIDaoD0Nr7e5vm6lcJYzUUol
         vVcg==
X-Received: by 10.107.18.28 with SMTP id a28mr24101511ioj.106.1437742946654;
 Fri, 24 Jul 2015 06:02:26 -0700 (PDT)
Received: by 10.64.211.162 with HTTP; Fri, 24 Jul 2015 06:02:26 -0700 (PDT)
In-Reply-To: <87wpxp4tae.fsf@igel.home>
X-Google-Sender-Auth: XfXksTgPwjfQE8xx1_nGkivKuuA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274567>

On Fri, Jul 24, 2015 at 8:46 AM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Josh Boyer <jwboyer@fedoraproject.org> writes:
>
>> I'm trying to figure out how to generate a file that contains the git
>> history and changes from one revision to another, such that when the
>> file is applied to a different tree starting at the same ancestor, the
>> resulting tree is identical.
>
> See git-bundle(1).

Thanks.  That does indeed seem like what I'm looking for.

josh
