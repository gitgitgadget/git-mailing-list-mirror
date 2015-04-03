From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] standardize usage strings that were missed the first time
Date: Fri, 3 Apr 2015 16:48:10 -0700
Message-ID: <CAPc5daV7yf7X6y9-KAjGF2H=bq1T8gTR4729rDLFZtb-Pcs_TA@mail.gmail.com>
References: <1428010016-12968-1-git-send-email-alexhenrie24@gmail.com>
 <xmqqego2i47o.fsf@gitster.dls.corp.google.com> <CAMMLpeQkZ2jsuBg_J6veHpGcZiwwSzt+8xQ1g+dL2G18SnBtPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Alex Henrie <alexhenrie24@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 01:48:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeBKL-000627-9Z
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 01:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091AbbDCXsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 19:48:32 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:35353 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbbDCXsb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 19:48:31 -0400
Received: by obbfy7 with SMTP id fy7so102834665obb.2
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 16:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=gr8OAE4ZeYzTDzBSCr+lq0/0eo5fz00HlFKzXY6qDGI=;
        b=pK3QONfNzJtPO+AS1cNNbNf1lEeFacTj4Xm63tqjA6FApOE56v3GrLXopeGQ/2aP5R
         GhvHSJ9ofDi8uxvajmth9gNgBA8ifE4NUZNpBao9Ug/ts9wQ6txEv0Ev5s3U0vgE8TZr
         mN/AFtdy+S5bxXOJjczVKHPAksr7/kxDp/biNU81frWgOiJgQd3M05AK0GINUIsG8R0x
         jZksytAXb5Mg8Uq1nH50XwOYw4MsHcNsRPkq3pGN0nLLt4++Vu4nxR0dCP7N9W+oWsS2
         TlxMLND93e+JhaahdJWZqVeuvB9HDjl/HL+WR5vmGs7fD16vm5mEuKFqXwT4gE6FiBLy
         cp6A==
X-Received: by 10.182.60.197 with SMTP id j5mr5514702obr.85.1428104911067;
 Fri, 03 Apr 2015 16:48:31 -0700 (PDT)
Received: by 10.202.87.85 with HTTP; Fri, 3 Apr 2015 16:48:10 -0700 (PDT)
In-Reply-To: <CAMMLpeQkZ2jsuBg_J6veHpGcZiwwSzt+8xQ1g+dL2G18SnBtPw@mail.gmail.com>
X-Google-Sender-Auth: vJ2K0Z_n_RAaAvnlxo17sB7VD2Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266749>

On Fri, Apr 3, 2015 at 3:47 PM, Alex Henrie <alexhenrie24@gmail.com> wrote:
> 2015-04-02 15:56 GMT-06:00 Junio C Hamano <gitster@pobox.com>:
>> Thanks, but please no more _("string") changes for the rest of the
>> cycle, as that would impact i18n folks who will be starting from
>> tagged -rc releases.
>>
>> Please hold them off, and resend them after 2.4.0 final.
>
> I thought that during a code freeze, you held onto patches or
> committed them to a staging branch.

Yes, but that is done as time-permits basis, and it is much more
efficient to spread the load of remembering the topics that are
needed in future ;-)

Thanks.
