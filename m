From: "Denis Bueno" <dbueno@gmail.com>
Subject: Re: git-instaweb portability issue (maybe?)
Date: Fri, 13 Jun 2008 09:38:18 -0400
Message-ID: <6dbd4d000806130638k4461a41eo8ce6fe803505fa88@mail.gmail.com>
References: <6dbd4d000806130626pfdb06f2qbfea6f1909710b7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 13 15:39:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K79Uu-00031R-4v
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 15:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755661AbYFMNiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 09:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755216AbYFMNiW
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 09:38:22 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:57924 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755183AbYFMNiV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 09:38:21 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2762154fgg.17
        for <git@vger.kernel.org>; Fri, 13 Jun 2008 06:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=aUHw63dzx8NhHMlFfTv4T6jIFCmVIgrCd0RuRCTjSfk=;
        b=LxmU48GETb+KfHTmTJ4dpaWRSnJMhdIH66dd6c+i1ZbAEl+sVylKftcxENrRaAKWZM
         4RnfLI7TTmIqd8kKIjHIUM1/yiH2Zsv3ZchNrAz5nYdWPHlO2KOdbTV/2pfDUhf4lxeR
         j71Lhtckmn8JAB0SWRMbYH4ZhsR5IhlRFBgg0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=YA0/umVy3sFXGdZ0qatGtqlePtYe8XW9iAhLnW2+RUbwBu4an9IKDctNE3cVkJqhxq
         SZ2sRyssi3x0y1tY+Rk22pX+XUwY1BLUZfv08iweriDeb08Jrfn7kdJ3UVZpRTnCvLZG
         rBG8uqK+X850RBTnilthPyef6/dLsMoHO213k=
Received: by 10.86.25.17 with SMTP id 17mr3984266fgy.50.1213364298126;
        Fri, 13 Jun 2008 06:38:18 -0700 (PDT)
Received: by 10.86.59.7 with HTTP; Fri, 13 Jun 2008 06:38:18 -0700 (PDT)
In-Reply-To: <6dbd4d000806130626pfdb06f2qbfea6f1909710b7b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84874>

On Fri, Jun 13, 2008 at 09:26, Denis Bueno <dbueno@gmail.com> wrote:
> That line simply calls perl by the $PERL variable, which is set at the
> top of the script, like so:
>
>    PERL='/usr/bin/env perl'
>
> If I change this line to point to my perl directly, it works.  On a
> hunch, I changed it to:
>
>    PERL="/usr/bin/env perl"  # note the double-quotes

[snip lies]

Apparently I didn't test this thoroughly enough, and I was wrong.
Changing the quotes has no effect.

So git-instaweb only works for me if I manually specify my perl path.
Can anyone think of why this might be?

-- 
 Denis
