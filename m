From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Another use of "@"?
Date: Fri, 3 May 2013 16:51:21 +1000
Message-ID: <CACsJy8Btz6=4ZUjW3OR2v-LDaDcDaiK=7ucf8rO8MsG9cXt++g@mail.gmail.com>
References: <CACsJy8AcWV8hmbhG27dw+GdnZf8NnQEctYmowqd3sSzOOHf+xg@mail.gmail.com>
 <7vr4hozie1.fsf@alter.siamese.dyndns.org> <7vfvy4zhy5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 03 08:52:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UY9qW-0000Nt-Ir
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 08:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762526Ab3ECGvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 02:51:52 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:49588 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760176Ab3ECGvw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 02:51:52 -0400
Received: by mail-ob0-f170.google.com with SMTP id ef5so1186513obb.1
        for <git@vger.kernel.org>; Thu, 02 May 2013 23:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=D4XllBCkkC0Y3mJd3hrI54UcLjI01uGhUJdSlyE4CIc=;
        b=i1sxNgE5529PMv9DoIVc2BZty/PdeHyjm+6Oyifxams+RvGgsOkUDM+C2Aptsl+vq1
         qG1DvNzW5mRfwbVKYhbioXjj6Yyq+nB1Es17c1nwwTfGMvPYFGQITI6+3dWFNiQt3xRo
         4gSJctdn5KrRD85aaj3s3y2wx84bJ4sGzRn9p/z1ebE7qXoHw1o57fc0jPLbqAj3dONn
         BdhEGpwuGou/4Q8qtSvzchmvD8b4hu9P+C9bR8j3CrNq4qu9lgUNWqF5g+mm4MrDycU8
         QRKMS2nbCHCakWJ8Zo+ueBqlYVACFkBJP6NhSWzcrBOOn4+Ik0cedBEGkTDeaBkFyD7R
         rv0w==
X-Received: by 10.182.156.20 with SMTP id wa20mr2657623obb.59.1367563911427;
 Thu, 02 May 2013 23:51:51 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Thu, 2 May 2013 23:51:21 -0700 (PDT)
In-Reply-To: <7vfvy4zhy5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223290>

On Fri, May 3, 2013 at 4:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>> My setup is a bit peculiar where I do git development on three
>>> different machines. Say I updated branch long-branch-name on machine
>>> A. Then I continue my work on machine B. I would want to hard reset
>>> that long-branch-name on machine B before resuming my work. What I
>>> usually do is
>>>
>>> git co long-branch-name
>>> git diff A/long-branch-name
>>> git reset --hard A/long-branch-name
>>
>> Perhaps
>>
>>     git checkout long-bra<TAB>
>>     git diff A/!$
>>     git reset --hard !$

"diff" does not have to follow "checkout".

>> In any case, not a Git question, I would have to say.
>
> As a Git question, probably the answers are
>
>         git co long-bra<TAB>
>         git diff @{u}
>         git reset --hard @{u}
>
> with an appropriate setting of the upstream, perhaps?

and @{u} can't be used because I might want to resume from machine C
instead of A. I don't have a single upstream.
--
Duy
