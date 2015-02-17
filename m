From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/3] request-pull: do something if $3 is passed
Date: Tue, 17 Feb 2015 12:42:40 -0800
Message-ID: <CA+55aFw_pKtraqwMMsqsYgF=ikShH=6ybtb7+QPr8r=77kmoVQ@mail.gmail.com>
References: <1424110568-29479-1-git-send-email-bonzini@gnu.org>
	<xmqqiof163kk.fsf@gitster.dls.corp.google.com>
	<54E31405.5040502@gnu.org>
	<xmqqvbj01fbz.fsf@gitster.dls.corp.google.com>
	<54E3A5E2.6060806@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 17 21:42:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNoyj-0007II-VU
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 21:42:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbbBQUmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 15:42:42 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:38753 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbbBQUml (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 15:42:41 -0500
Received: by iecrd18 with SMTP id rd18so43855562iec.5
        for <git@vger.kernel.org>; Tue, 17 Feb 2015 12:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=+TkMBZbvJ1haal2KBmh1ebHIZVAJxkKNqv7gtVAT5Ac=;
        b=NZ6nsoiA57b+DePZLnFRbNKW8P6BwXNyS8vWTcwGFiVyaeVnif9lFDSjSjvzrGUUFU
         SAPoXseDOkf4EYma3h22UY7GtTxZZ9sV5lwdphURYHy++wuj+lSBZvHjUAz9eaDGPVHx
         kEG5pPm9LH7PMvBGlYgYU/9E2n65GWCM+ML4eAENxJuYxhO47FgDr4b4gLOQBLcOkkGg
         CIW3Uza9iz1xUcUIHMe68Ud56YmYaO5Zizs05xF7LosMfQLh+aGVWIfULW3tj45QQ+Dl
         6DedzWPIQxF9ybs2XBuSJKaNPhRastoWnYT2CTjNy9K5nfNsptrollI4871s60fhPeIi
         1/Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=+TkMBZbvJ1haal2KBmh1ebHIZVAJxkKNqv7gtVAT5Ac=;
        b=LlQLl8A+2o1bTfXePp3D5fYKFLPGnAoYGimIP6sj3ItjPtFtzvnkXsoepNHq3xj9CH
         4g63/0MRMwDr86uQeDEQ602botFm/AIaCBKJCzKUPwYfca3q+U0s8IcbRDqTxnZYOcFG
         eQIEDD3n11VZbLciRWHyv9feuwKuyO0h7sUj8=
X-Received: by 10.42.222.68 with SMTP id if4mr36889447icb.45.1424205760556;
 Tue, 17 Feb 2015 12:42:40 -0800 (PST)
Received: by 10.36.60.10 with HTTP; Tue, 17 Feb 2015 12:42:40 -0800 (PST)
In-Reply-To: <54E3A5E2.6060806@gnu.org>
X-Google-Sender-Auth: nPPsJZFMAf4m2vz3Dl5x4vSrGNo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263982>

On Tue, Feb 17, 2015 at 12:34 PM, Paolo Bonzini <bonzini@gnu.org> wrote:
>
> I guess only Linus could answer that, since he wrote 024d34cb0 and he
> knows the intent better than anyone else.

I don't even understand your problem.

You said

  "when $3 is not passed git will try to use "HEAD" as the default but
it cannot be resolved to a tag, neither locally (patch 2) nor remotely
(patch 3)"

which makes absolutely no sense.

HEAD is not a tag. Never has been, never will be. If you want me to
pull a tag, then you damn well should say what tag you want, not just
randomly say HEAD.

So what is it you want to do? At no point is "HEAD should resolve as a
tag" sensible.

                      Linus
