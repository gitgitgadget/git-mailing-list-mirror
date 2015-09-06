From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] am: match --signoff to the original scripted version
Date: Sun, 6 Sep 2015 09:16:27 -0700
Message-ID: <CA+55aFx+rwGwHr-pdo=yjgzysfJ_CVir7=dTV0GTjeboCAwjrw@mail.gmail.com>
References: <CA+55aFzN4SnenchxPScn61_apzitGAPtoYEd49iLZPxgK0KQGw@mail.gmail.com>
	<xmqqio7ob0xw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 06 18:16:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYccN-0001jV-4o
	for gcvg-git-2@plane.gmane.org; Sun, 06 Sep 2015 18:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbbIFQQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2015 12:16:30 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:33286 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbbIFQQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2015 12:16:28 -0400
Received: by iofh134 with SMTP id h134so67992141iof.0
        for <git@vger.kernel.org>; Sun, 06 Sep 2015 09:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=CCkEb+ZIGBr8owFUo4I45M9SNDseefQPLQzvHUzbZSw=;
        b=bDwbVJFc57StrGtIViHYye+pv2i/lTMautp9hF2L41zX4Lo1nRvsTNj2/RbonsbUhU
         6f0IUfV6jVnRmJ6m0k0UaJXS0DI8nVmbRnrQbAaiuHo7d58qluOODgw38fLqkxbgPwXj
         0gD+HrOUyDcwwOXpObrdCacUApLLamBC82zGhHScxxguKWVxmU92lSPM2a/fMPch+m3N
         ghRHA/YXHcRa8Hj1kvNj8exCFBpLJ69oAAGl+LgJoY98s64KI7PXnvexhia/aTrCMBIT
         6YlOzc3Aizc17j8I/mdl+mrK+oKz69Uj9InOamEBDxhPdQOgfn+cvVt+rOJ81p6KJvTX
         leXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=CCkEb+ZIGBr8owFUo4I45M9SNDseefQPLQzvHUzbZSw=;
        b=WMFIUThRkuH1YgPzCIyaeOPjKOIWITbqy6vaX4PqXDHsUqZkHPmJb+iGIa3spibvbz
         5e9pp1+JZE7sU00a2QiT+bKIvyyLKmf8i33EyRTV4kB/Mek4wvyFFTBgyYSn8V5fS/Zx
         japDKhMR+1PJxYGOFBEmzRfV7OkxpDU7HdDzg=
X-Received: by 10.107.15.170 with SMTP id 42mr21780321iop.137.1441556187854;
 Sun, 06 Sep 2015 09:16:27 -0700 (PDT)
Received: by 10.36.124.195 with HTTP; Sun, 6 Sep 2015 09:16:27 -0700 (PDT)
In-Reply-To: <xmqqio7ob0xw.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: NtKE-HhqMpDBjM6bjVdEq5Opg9s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277427>

On Sat, Sep 5, 2015 at 9:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>                      For
> the upcoming release, stop using the append_signoff() in "git am"
> and reimplement the looser definition used by the scripted version
> to use only in "git am" to fix this regression in "am" while
> avoiding new regressions to other users of append_signoff().

I've tested this by re-doing the same patch-bomb from Andrew that I
had problems with originally, and it WorksForMe(tm).

Thanks,

                Linus
