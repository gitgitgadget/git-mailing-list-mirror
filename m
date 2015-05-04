From: Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH] standardize usage strings that were missed the first time
Date: Mon, 4 May 2015 11:49:51 -0600
Message-ID: <CAMMLpeTNfe3zZgkApoXV=_Kj+bzfU1YBtyKtoPu00e8eTza_WA@mail.gmail.com>
References: <1430536341-21847-1-git-send-email-alexhenrie24@gmail.com>
 <xmqq383dwpf4.fsf@gitster.dls.corp.google.com> <xmqq4mntusad.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: pclouds@gmail.com, Ramkumar Ramachandra <artagnon@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 04 19:50:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpKVW-0001jJ-Dh
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 19:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbbEDRuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 13:50:14 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:35103 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbbEDRuM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 13:50:12 -0400
Received: by widdi4 with SMTP id di4so130512834wid.0
        for <git@vger.kernel.org>; Mon, 04 May 2015 10:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vNGI+K3gJa/p/mVfsXCiSNF8gSiAoJAFdMCt64IJh4M=;
        b=ZWDKiJLOg2QBUsAIX7alNtlAwiicaxw4ui1d71ds+ks5VwgMuqKyqC51+LcGX90bvX
         Fgfg09oxzt6M0Lfx638ySrks+6CKl82dMgXRDXjkkc+48hWSRtD/LFPtF0V6U8GQKOJN
         2pkqyxCEfBu/8yPZcm/3MXrq17slXYfs4JtJ72CT5b7NMSgtENyWVNa2LLIFQy2TNrBE
         KyhnkTE3huvo3HHm7IKNpD1rmPI/hsqIJVqtp5uC+lMZN9E5Kp9zQkyKFZW/8b/xYFJK
         nGCQsY7G6wYqDpqEBi85RROL9Ik6faUdwcTu7kIxel+12y9xZWUI16MlWmqIGYy0uSmj
         vEww==
X-Received: by 10.194.52.10 with SMTP id p10mr40287299wjo.98.1430761811862;
 Mon, 04 May 2015 10:50:11 -0700 (PDT)
Received: by 10.28.182.84 with HTTP; Mon, 4 May 2015 10:49:51 -0700 (PDT)
In-Reply-To: <xmqq4mntusad.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268336>

2015-05-03 17:59 GMT-06:00 Junio C Hamano <gitster@pobox.com>:
> Here is my attempt.
>
> commit ce41720cad79d858f09ebfc88cf84a4b152645c7
> Author: Alex Henrie <alexhenrie24@gmail.com>
> Date:   Thu Apr 2 15:26:56 2015 -0600
>
>     blame, log: format usage strings similarly to those in documentation
>
>     Earlier, 9c9b4f2f (standardize usage info string format, 2015-01-13)
>     tried to make usage-string in line with the documentation by
>
>         - Placing angle brackets around fill-in-the-blank parameters
>         - Putting dashes in multiword parameter names
>         - Adding spaces to [-f|--foobar] to make [-f | --foobar]
>         - Replacing <foobar>* with [<foobar>...]
>
>     but it missed a few places.
>
>     Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>

Looks great, thank you.

-Alex
