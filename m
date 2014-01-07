From: Francesco Pretto <ceztko@gmail.com>
Subject: Re: [PATCH] git-submodule.sh: Support 'checkout' as a valid update command
Date: Tue, 7 Jan 2014 01:05:04 +0100
Message-ID: <CALas-ijrD1VnyUcr2yQw_1Je4K3eEdXtxqDNDKdGPZE=1=Nm3A@mail.gmail.com>
References: <1389034726-8744-1-git-send-email-ceztko@gmail.com> <xmqqtxdgfz8a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 01:05:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0KAr-0000B4-UF
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 01:05:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758215AbaAGAFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 19:05:31 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:52073 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756842AbaAGAF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 19:05:27 -0500
Received: by mail-oa0-f46.google.com with SMTP id l6so896439oag.19
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 16:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZtK/NPWkt1sfPXEdFSDXuNQlHo0MroOfS9h4TxbxGPw=;
        b=BoVHQQZCL3zUwORFnvWNQUHr2Ze6o5UjLJdBJBhkJNZjBYs9q/a2uKXu6+KJNDFflq
         7ej/Tc7YucTDUIvSm6dms1xW0Wc+dpbM+JehgT0NY8VCG1u43i0I/1IwiiXilMMDvCiL
         qOWO2LARmkh1h/GgWOlBlkSSxJ5CNyHy+US65tUEgNl1sl8I5idNdDiAMMa5XvDvmYMt
         cdK7LIIG0dlBqvD6HYonjEQlzhGKUhO1GrmDguFbgdiC6kU6eTU1zbS59biQBC+y7h+H
         UjLY7+15ND7h/acz/g7e2iWqzIUmi9LbFwbWuCiVMu+6E84VG55FF4Lpt8O2cET9/HC7
         oo8w==
X-Received: by 10.182.87.69 with SMTP id v5mr78678obz.77.1389053126024; Mon,
 06 Jan 2014 16:05:26 -0800 (PST)
Received: by 10.76.80.165 with HTTP; Mon, 6 Jan 2014 16:05:04 -0800 (PST)
In-Reply-To: <xmqqtxdgfz8a.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240088>

2014/1/7 Junio C Hamano <gitster@pobox.com>:
> Francesco Pretto <ceztko@gmail.com> writes:
>
>> According to "Documentation/gitmodules.txt", 'checkout' is a valid
>> 'submodule.<name>.update' command.
>
> As you can see in the surrounding text, we call the value of
> submodule.*.update a "mode", not a command.
>

Ok.

>> Also "git-submodule.sh" refers to
>> it and processes it correctly.
>
> This present tense puzzles me.  If it already refers to checkout and
> handles it correctly is there anything that needs to be done?  Or
> did you mean "it should refer to and process it but it doesn't, so
> make it so?"
>

Like you said, "it already refers to checkout and handles it
correctly". I think the use of the simple present tense here is
correct: it's a fact. Feel free to advice another wording if you
prefer.

>> Reflecting commit 'ac1fbb' to support
>> this syntax and also validate property values during 'update' command,
>> issuing an error if the value found is unknown.
>
> Sorry, but -ECANNOTPARSE.

Not sure what's wrong here, can you explain why it's failing? I'm
using git-format-patch/git-send-email with default settings. Also, if
you can edit and keep the sign-off (I'm not familiar with the
mailing-list maintainer workflow, sorry), feel free to do it.

Thanks
